const fs = require('fs');
const path = require('path');
const yaml = require('js-yaml');

// 1. Find all workspace packages (directories with pubspec.yaml)
function findWorkspacePackages(rootDir) {
  const packages = {};
  function search(dir) {
    const entries = fs.readdirSync(dir, { withFileTypes: true });
    for (const entry of entries) {
      if (entry.isDirectory()) {
        const subdir = path.join(dir, entry.name);
        const pubspecPath = path.join(subdir, 'pubspec.yaml');
        if (fs.existsSync(pubspecPath)) {
          const pubspec = yaml.load(fs.readFileSync(pubspecPath, 'utf8'));
          if (pubspec && pubspec.name) {
            packages[pubspec.name] = path.relative(rootDir, subdir);
          }
        }
        search(subdir);
      }
    }
  }
  search(rootDir);
  return packages;
}

// 2. Fix pubspec.yaml files
function fixPubspec(pubspecPath, workspacePackages) {
  const doc = yaml.load(fs.readFileSync(pubspecPath, 'utf8'));
  let changed = false;

  // Fix dependencies
  if (doc.dependencies) {
    for (const dep in doc.dependencies) {
      if (workspacePackages[dep]) {
        const val = doc.dependencies[dep];
        if (typeof val === 'object' && (val.git || val.path)) {
          doc.dependencies[dep] = null; // Mark for removal
          changed = true;
        }
      }
    }
    // Remove marked
    for (const dep in doc.dependencies) {
      if (doc.dependencies[dep] === null) {
        delete doc.dependencies[dep];
        doc.dependencies[dep] = ""; // Add as workspace dependency
      }
    }
  }

  // Remove dependency_overrides for workspace packages
  if (doc.dependency_overrides) {
    for (const dep in doc.dependency_overrides) {
      if (workspacePackages[dep]) {
        delete doc.dependency_overrides[dep];
        changed = true;
      }
    }
    if (Object.keys(doc.dependency_overrides).length === 0) {
      delete doc.dependency_overrides;
    }
  }

  if (changed) {
    fs.writeFileSync(pubspecPath, yaml.dump(doc, { lineWidth: 1000 }));
    console.log(`Fixed: ${pubspecPath}`);
  }
}

// 3. Main
const rootDir = process.cwd();
const workspacePackages = findWorkspacePackages(rootDir);

for (const pkg in workspacePackages) {
  const pubspecPath = path.join(rootDir, workspacePackages[pkg], 'pubspec.yaml');
  fixPubspec(pubspecPath, workspacePackages);
}