import 'package:flutter/material.dart';
import 'package:key_value_row_builder/index.dart';
import 'package:date/index.dart';
import 'package:semantic_theme/index.dart';

import '_a.dart';

class MessageCell extends StatelessWidget with KeyValueRowBuilder {
  final String? subject;
  final String? message;
  final int? latestActivityTimestamp;
  final VoidCallback? onTap;

  MessageCell({
    this.subject,
    this.message,
   this.latestActivityTimestamp,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = SemanticTheme.of(context);

    final formattedDateText =
        Date.fromSecondsSinceEpoch(latestActivityTimestamp ?? 0).toAdaptiveString;

    final dateWidget = Text(
      formattedDateText,
      style: theme?.typography?.detail?.textStyle(
        color: theme.color?.text?.generalSecondary ?? Colors.black,
      ),
    );

    return CellA(
      title: subject,
      titleAccessory: dateWidget,
      note: message,
    );
  }
}
