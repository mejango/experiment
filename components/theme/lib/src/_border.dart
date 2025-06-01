import 'package:flutter/material.dart';
import 'package:color/index.dart' as color;

import 'option.dart';

class RoofBorderColor {
  RoofThemeOption _current;

  Color get submitButton {
    switch (_current) {
      case RoofThemeOption.light:
        return Colors.transparent;
      case RoofThemeOption.dark:
        return Colors.transparent;
    }
  }

  Color get transitionButton {
    switch (_current) {
      case RoofThemeOption.light:
        return color.blue;
      case RoofThemeOption.dark:
        return color.blue;
    }
  }

  Color get inactiveButton {
    switch (_current) {
      case RoofThemeOption.light:
        return color.blue.withAlpha(100);
      case RoofThemeOption.dark:
        return color.blue.withAlpha(100);
    }
  }

  RoofBorderColor(this._current);
}
