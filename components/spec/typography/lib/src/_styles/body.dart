import 'typography_style.dart';
import '_utils/font_size.dart' as font_size;
import '_utils/font_weight.dart' as font_weight;

class BodyIos with _Body, TypographyStyle {}

class BodyAndroid with _Body, TypographyStyle {}

mixin _Body implements TypographyStyle {
  @override
  final fontSize = font_size.small;
  @override
  final fontWeight = font_weight.thin;
  @override
  final leading = font_size.small;
  @override
  final tracking = 0;
}
