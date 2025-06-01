import 'package:flutter/material.dart';
import 'package:semantic_theme/index.dart';
import 'package:tag_kind_option/index.dart';

class StandardTag extends StatelessWidget {
  final String? text;
  final TagKindOption? kind;

  StandardTag({
    this.text,
    this.kind = TagKindOption.normal,
  });

  @override
  Widget build(BuildContext context) {
    final theme = SemanticTheme.of(context);

    Color _textColor = theme?.color.text.generalPrimary ?? Colors.black;
    Color _backgroundColor = theme?.color.background.neutralContrast ?? Colors.white;

    switch (kind) {
      case TagKindOption.error:
        _textColor = theme?.color.text.onNotifyBackground ?? Colors.black;
        _backgroundColor = theme?.color.background.warn ?? Colors.white;
        break;
      case TagKindOption.good:
        _textColor = theme?.color.text.onNotifyBackground ?? Colors.black;
        _backgroundColor = theme?.color.background.good ?? Colors.white;
        break;
      case TagKindOption.emergency:
        _textColor = theme?.color.text.onNotifyBackground ?? Colors.black;
        _backgroundColor = theme?.color.background.bad ?? Colors.white;
        break;
      case TagKindOption.normal:
        break;
      default:
        break;
    }

    final textStyle = theme?.typography.detail.textStyle(
      color: _textColor,
    );

    final textWidget = Text(
      text ?? "",
      style: textStyle,
    );

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: theme?.distance.padding.horizontal.min ?? 0,
        vertical: theme?.distance.padding.vertical.min ?? 0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          theme?.radius.min ?? Radius.circular(0),
        ),
        color: _backgroundColor,
      ),
      child: textWidget,
    );
  }
}
