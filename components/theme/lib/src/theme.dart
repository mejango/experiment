import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'semantic_color.dart';
import 'option.dart';

class RoofTheme extends StatefulWidget {
  final Widget child;
  final RoofThemeOption theme;

  RoofTheme(this.theme, {required this.child});

  @override
  State<StatefulWidget> createState() => RoofInheritedTheme();

  static RoofInheritedTheme of(BuildContext context,
      {bool shouldRebuild = true}) {
    final inheritedWidget = (shouldRebuild
        ? context.dependOnInheritedWidgetOfExactType<_RoofInheritedTheme>()
        : context.findAncestorWidgetOfExactType<_RoofInheritedTheme>());

    return (inheritedWidget as _RoofInheritedTheme).data;
  }
}

class RoofInheritedTheme extends State<RoofTheme> {
  RoofThemeOption? _current;

  RoofThemeOption? get current => _current;

  set current(RoofThemeOption? newValue) {
    _current = newValue;
    color = RoofSemanticColor(current: newValue ?? widget.theme);
  }

  RoofSemanticColor? color;

  SystemUiOverlayStyle get systemChromeStyle {
    switch (_current) {
      case RoofThemeOption.light:
        return SystemUiOverlayStyle.dark;
      case RoofThemeOption.dark:
        return SystemUiOverlayStyle.light;
      default:
        return SystemUiOverlayStyle.dark;
    }
  }

  BoxShadow get shadow {
    double blurRadius;
    int alpha;
    switch (_current) {
      case RoofThemeOption.light:
        blurRadius = 12;
        alpha = 50;
        break;
      case RoofThemeOption.dark:
        blurRadius = 16;
        alpha = 25;
        break;
      default:
        blurRadius = 16;
        alpha = 25;
        break;
    }
    return BoxShadow(
        color: color?.background.scrim.withAlpha(alpha) ?? Colors.transparent,
        blurRadius: blurRadius,
        offset: Offset(0, 5));
  }

  @override
  void initState() {
    current = widget.theme;
    super.initState();
  }

  void use(RoofThemeOption theme) => setState(() => current = theme);

  @override
  Widget build(BuildContext context) {
    return _RoofInheritedTheme(data: this, child: widget.child);
  }
}

class _RoofInheritedTheme extends InheritedWidget {
  final RoofInheritedTheme data;

  _RoofInheritedTheme({required this.data, required Widget child})
      : super(child: child);

  @override
  bool updateShouldNotify(_RoofInheritedTheme old) => true;
}
