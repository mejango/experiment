import 'package:flutter/material.dart';
import 'package:semantic_theme/index.dart';
import 'package:date/index.dart';
import 'package:haptics/index.dart';

class ThreadCommentCell extends StatelessWidget {
  final String? creator;
  final int? timestamp;
  final String? note;
  final VoidCallback? onTap;

  ThreadCommentCell({
    this.creator,
    this.timestamp,
    this.note,
    this.onTap,
  });

  final _tapHapticOption = HapticOption.light;

  void _fireHaptic() {
    if (onTap != null) triggerHaptic(_tapHapticOption);
  }

  @override
  Widget build(BuildContext context) {
    final theme = SemanticTheme.of(context);

    return GestureDetector(
      onTapDown: (details) => _fireHaptic(),
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: theme?.distance?.spacing?.vertical?.small ?? 0,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: theme?.distance?.padding?.horizontal?.small ?? 0,
          vertical: theme?.distance?.padding?.vertical?.small ?? 0,
        ),
        child: _Body(
          creator: creator,
          timestamp: timestamp,
          note: note,
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final String? creator;
  final int? timestamp;
  final String? note;

  _Body({
    this.creator,
    this.timestamp,
    this.note,
  });

  @override
  Widget build(BuildContext context) {
    final theme = SemanticTheme.of(context);

    final creatorWidget = Text(
      creator ?? "",
      style: theme?.typography?.bodyHeavy?.textStyle(
        color: theme.color?.text?.generalPrimary ?? Colors.black,
      ),
    );

    final formattedTimestamp =
        Date.fromSecondsSinceEpoch(timestamp ?? 0).toAdaptiveString;

    final timestampWidget = Container(
      margin: EdgeInsets.only(left: theme?.distance?.spacing?.horizontal?.small ?? 0),
      child: Text(
        formattedTimestamp,
        style: theme?.typography?.detail?.textStyle(
          color: theme.color?.text?.generalSecondary ?? Colors.black,
        ),
      ),
    );

    final headerRow = Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: <Widget>[
        creatorWidget,
        timestampWidget,
      ],
    );

    final noteWidget = Container(
      margin: EdgeInsets.only(
        top: theme?.distance?.spacing?.vertical?.min ?? 0,
      ),
      child: Text(
        note ?? "",
        style: theme?.typography?.body?.textStyle(
          color: theme.color?.text?.generalPrimary ?? Colors.black,
        ),
      ),
    );

    return Column(
      children: <Widget>[headerRow, noteWidget],
    );
  }
}
