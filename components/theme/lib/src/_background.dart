import 'package:flutter/material.dart';
import 'package:color/index.dart' as color;

import 'option.dart';

class RoofBackgroundColor {
  RoofThemeOption _current;

  Color get brand {
    switch (_current) {
      case RoofThemeOption.light:
        return color.white1;
      case RoofThemeOption.dark:
        return color.black1;
    }
  }

  Color get inputForeground {
    switch (_current) {
      case RoofThemeOption.light:
        return color.white1;
      case RoofThemeOption.dark:
        return color.black2;
    }
  }

  Color get inputBackground {
    switch (_current) {
      case RoofThemeOption.light:
        return color.white2;
      case RoofThemeOption.dark:
        return color.black1;
    }
  }

  Color get generalPrimary {
    switch (_current) {
      case RoofThemeOption.light:
        return color.white2;
      case RoofThemeOption.dark:
        return color.black2;
    }
  }

  Color get generalSecondary {
    switch (_current) {
      case RoofThemeOption.light:
        return color.white1;
      case RoofThemeOption.dark:
        return color.black1;
    }
  }

  Color get scrim {
    switch (_current) {
      case RoofThemeOption.light:
        return Colors.black.withOpacity(0.2);
      case RoofThemeOption.dark:
        return Colors.black.withOpacity(0.6);
    }
  }

  Color get primaryAction {
    switch (_current) {
      case RoofThemeOption.light:
        return color.blue;
      case RoofThemeOption.dark:
        return color.blue;
    }
  }

  Color get secondaryAction {
    switch (_current) {
      case RoofThemeOption.light:
        return color.white1;
      case RoofThemeOption.dark:
        return color.black1;
    }
  }

  Color get errorAction {
    switch (_current) {
      case RoofThemeOption.light:
        return color.alert;
      case RoofThemeOption.dark:
        return color.alert;
    }
  }

  Color get inactiveAction {
    switch (_current) {
      case RoofThemeOption.light:
        return color.gray4;
      case RoofThemeOption.dark:
        return color.blue.withAlpha(100);
    }
  }

  Color get disabled {
    switch (_current) {
      case RoofThemeOption.light:
        return color.gray4;
      case RoofThemeOption.dark:
        return color.gray4;
    }
  }

  Color get tagDefault {
    switch (_current) {
      case RoofThemeOption.light:
        return color.gray3;
      case RoofThemeOption.dark:
        return color.white1.withAlpha(20);
    }
  }

  Color get tagGood {
    switch (_current) {
      case RoofThemeOption.light:
        return color.lightGreen;
      case RoofThemeOption.dark:
        return color.white1.withAlpha(20);
    }
  }

  Color get tagAlert {
    switch (_current) {
      case RoofThemeOption.light:
        return color.alert_dark;
      case RoofThemeOption.dark:
        return color.white1.withAlpha(20);
    }
  }

  Color get emergency {
    switch (_current) {
      case RoofThemeOption.light:
        return color.emergency;
      case RoofThemeOption.dark:
        return color.emergency;
    }
  }

  RoofBackgroundColor(this._current);
}
