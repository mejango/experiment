import 'package:flutter/material.dart';
import 'package:semantic_theme/index.dart';
import 'package:standard_icon_library/index.dart';
import 'package:decorated_text/index.dart';

import '_thread.dart';

class DueSoonThreadCell extends StatelessWidget {
  final String? title;
  final WeightDecoratedText? secondaryText;
  final StandardIcon? iconReference;
  final int? timestamp;
  final VoidCallback? onTap;

  DueSoonThreadCell({
     this.title,
    this.secondaryText,
     this.iconReference,
     this.timestamp,
     this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = SemanticTheme.of(context);

    final titleTextStyle = theme?.typography?.body?.textStyle(
      color: theme.color?.text?.action ?? Colors.black,
    ) ?? TextStyle();

    final timestampTextStyle = theme?.typography?.body?.textStyle(
      color: theme.color?.text?.generalSecondary ?? Colors.black,
    ) ?? TextStyle();

    return ThreadCell(
      title: title,
      titleTextStyle: titleTextStyle,
      secondaryText: secondaryText,
      iconReference: iconReference,
      timestamp: timestamp,
      timestampTextStyle: timestampTextStyle,
      onTap: onTap,
    );
  }
}
