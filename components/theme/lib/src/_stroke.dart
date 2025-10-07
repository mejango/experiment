import 'package:flutter/material.dart';
import 'package:color/index.dart' as color;

import 'option.dart';

class RoofStrokeColor {
  RoofThemeOption _current;

  Color get light {
    switch (_current) {
      case RoofThemeOption.light:
        return color.black1.withAlpha(20);
      case RoofThemeOption.dark:
        return color.white1.withAlpha(10);
    }
  }

  Color get focus {
    switch (_current) {
      case RoofThemeOption.light:
        return color.black1.withAlpha(50);
      case RoofThemeOption.dark:
        return color.white1.withAlpha(50);
    }
  }

  Color get secondaryAction {
    switch (_current) {
      case RoofThemeOption.light:
        return color.white1;
      case RoofThemeOption.dark:
        return color.blue.withAlpha(25);
    }
  }

  Color get alert {
    switch (_current) {
      case RoofThemeOption.light:
        return color.alert;
      case RoofThemeOption.dark:
        return color.alert;
    }
  }

  RoofStrokeColor(this._current);
}
