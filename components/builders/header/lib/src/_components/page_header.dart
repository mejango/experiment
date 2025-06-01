import 'package:flutter/material.dart';
import 'package:semantic_theme/index.dart';

class PageHeader extends StatelessWidget {
  final String text;
  final double? horizontalGutter;

  PageHeader({
    required this.text,
    this.horizontalGutter,
  });

  @override
  Widget build(BuildContext context) {
    final theme = SemanticTheme.of(context);

    final titleText = Text(
      text,
      style: theme?.typography.headingPrimary.textStyle(
        color: theme?.color.text.generalPrimary ?? Colors.black,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );

    return Padding(
      child: Row(
        children: [
          Expanded(
            child: titleText,
          )
        ],
      ),
      padding: EdgeInsets.symmetric(
        vertical: theme?.distance.padding.vertical.large ?? 0,
        horizontal: horizontalGutter ?? 0,
      ),
    );
  }
}
