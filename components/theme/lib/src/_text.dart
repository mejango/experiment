import 'package:flutter/material.dart';
import 'package:color/index.dart' as color;

import 'option.dart';

class RoofTextColor {
  RoofThemeOption _current;

  Color get brand {
    switch (_current) {
      case RoofThemeOption.light:
        return color.red;
      case RoofThemeOption.dark:
        return color.red;
    }
  }

  Color get primary {
    switch (_current) {
      case RoofThemeOption.light:
        return color.black2;
      case RoofThemeOption.dark:
        return color.gray1;
    }
  }

  Color get secondary {
    switch (_current) {
      case RoofThemeOption.light:
        return color.gray4;
      case RoofThemeOption.dark:
        return color.gray3;
    }
  }

  Color get placeholder {
    switch (_current) {
      case RoofThemeOption.light:
        return color.gray3;
      case RoofThemeOption.dark:
        return color.black3;
    }
  }

  Color get fill {
    switch (_current) {
      case RoofThemeOption.light:
        return color.black2;
      case RoofThemeOption.dark:
        return color.white1;
    }
  }

  Color get primaryAction {
    switch (_current) {
      case RoofThemeOption.light:
        return color.white1;
      case RoofThemeOption.dark:
        return color.white1;
    }
  }

  Color get secondaryAction {
    switch (_current) {
      case RoofThemeOption.light:
        return color.blue;
      case RoofThemeOption.dark:
        return color.blue;
    }
  }

  Color get inactiveAction {
    switch (_current) {
      case RoofThemeOption.light:
        return color.gray4;
      case RoofThemeOption.dark:
        return color.gray3;
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

  Color get tagAlert {
    switch (_current) {
      case RoofThemeOption.light:
        return color.white1;
      case RoofThemeOption.dark:
        return color.alert;
    }
  }

  Color get tagGood {
    switch (_current) {
      case RoofThemeOption.light:
        return color.white1;
      case RoofThemeOption.dark:
        return color.lightGreen;
    }
  }

  Color get tagDefault {
    switch (_current) {
      case RoofThemeOption.light:
        return color.white1;
      case RoofThemeOption.dark:
        return color.white1;
    }
  }

  RoofTextColor(this._current);
}
