import os
import shutil

def copy_and_update(src_root, dest_root):
    yaml_file = 'pubspec.yaml'
    os.makedirs(dest_root, exist_ok=True)

    for pkg in os.listdir(src_root):
        src_dir = os.path.join(src_root, pkg)
        dest_dir = os.path.join(dest_root, pkg)
        if not os.path.isdir(src_dir):
            continue
        if os.path.exists(dest_dir):
            print(f"Skipping {pkg} (already exists in {dest_root})")
            continue
        print(f"Copying {pkg}...")
        shutil.copytree(src_dir, dest_dir)
        yml_path = os.path.join(dest_dir, yaml_file)
        if os.path.isfile(yml_path):
            with open(yml_path, 'r') as f:
                lines = f.readlines()
            new_lines = []
            in_env = False
            sdk_set = False
            for line in lines:
                if line.strip().startswith('environment:'):
                    in_env = True
                    new_lines.append(line)
                    continue
                if in_env and line.strip().startswith('sdk:'):
                    if not sdk_set:
                        new_lines.append('  sdk: ^3.7.2\n')
                        sdk_set = True
                    in_env = False
                    continue
                if in_env and not sdk_set and (line.strip() == '' or not line.startswith(' ')):
                    new_lines.append('  sdk: ^3.7.2\n')
                    sdk_set = True
                    in_env = False
                new_lines.append(line)
            if not any('environment:' in l for l in new_lines):
                new_lines.append('\nenvironment:\n  sdk: ^3.7.2\n')
            elif not sdk_set:
                # Add sdk under environment if missing
                for i, l in enumerate(new_lines):
                    if l.strip().startswith('environment:'):
                        new_lines.insert(i+1, '  sdk: ^3.7.2\n')
                        break
            with open(yml_path, 'w') as f:
                f.writelines(new_lines)
            print(f"  Updated SDK constraint in {yml_path}")

    print(f"Done with {src_root} -> {dest_root}!\n")

if __name__ == "__main__":
    copy_and_update('lib', os.path.join('z', 'lib'))
    copy_and_update('types', os.path.join('z', 'types'))
