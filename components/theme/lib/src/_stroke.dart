import 'package:flutter/material.dart';
import 'package:color/index.dart' as color;

import 'option.dart';

class RoofStrokeColor {
  RoofThemeOption _current;

  Color get light {
    final opacity1 = 0.08;
    final opacity2 = 0.04;
    switch (_current) {
      case RoofThemeOption.light:
        return color.black1.withValues(alpha: opacity1 * 255);
      case RoofThemeOption.dark:
        return color.white1.withValues(alpha: opacity2 * 255);
    }
  }

  Color get focus {
    final opacity = 0.2;
    switch (_current) {
      case RoofThemeOption.light:
        return color.black1.withValues(alpha: opacity * 255);
      case RoofThemeOption.dark:
        return color.white1.withValues(alpha: opacity * 255);
    }
  }

  Color get secondaryAction {
    switch (_current) {
      case RoofThemeOption.light:
        return color.white1;
      case RoofThemeOption.dark:
        return color.blue.withValues(alpha: 0.1 * 255);
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
