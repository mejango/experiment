import 'package:semantic_theme/index.dart';

import '../_utils/theme_option_dependent.dart';

abstract class SemanticColorLibrary<T> extends ThemeOptionDependent<T> {
  SemanticColorLibrary(T currentThemeOption) : super(currentThemeOption);

  SemanticBackgroundColor<T>? get background;
  SemanticStrokeColor<T>? get stroke;
  SemanticIconColor<T>? get icon;
  SemanticTextColor<T>? get text;
}
