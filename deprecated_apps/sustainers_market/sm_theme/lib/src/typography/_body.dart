import 'dart:ui';

import 'package:semantic_theme/index.dart';

import '../_constants/_font_family.dart' as ff;
import '../_constants/_font_size.dart' as fs;
import '../_constants/_font_weight.dart' as fw;

class SmBodyTypography extends SemanticTypography {
  SmBodyTypography(currentThemeOption) : super(currentThemeOption);

  @override
  String get fontFamily => ff.circular;

  @override
  List<String> get fontFamilyFallback => null;

  @override
  double get fontSize => fs.small;

  @override
  FontWeight get fontWeight => fw.thin;

  @override
  double get letterSpacing => null;
}
