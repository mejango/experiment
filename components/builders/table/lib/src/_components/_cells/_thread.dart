import 'package:flutter/material.dart';
import 'package:decorated_text/index.dart';
import 'package:semantic_theme/index.dart';
import 'package:standard_icon_library/index.dart';
import 'package:haptics/index.dart';
import 'package:date/index.dart';

class ThreadCell extends StatelessWidget {
  final StandardIcon? iconReference;
  final String? title;
  final TextStyle? titleTextStyle;
  final WeightDecoratedText? secondaryText;
  final int? timestamp;
  final TextStyle? timestampTextStyle;
  final VoidCallback? onTap;

  ThreadCell({
     this.iconReference,
     this.title,
     this.titleTextStyle,
    this.secondaryText,
     this.timestamp,
     this.timestampTextStyle,
     this.onTap,
  });

  final _tapHapticOption = HapticOption.light;

  void _fireHaptic() {
    if (onTap != null) triggerHaptic(_tapHapticOption);
  }

  @override
  Widget build(BuildContext context) {
    final theme = SemanticTheme.of(context);

    final paddedIconWidget = _IconWidget(
      iconReference: iconReference,
    );

    final body = _PaddedBody(
      title: title,
      titleTextStyle: titleTextStyle,
      secondaryText: secondaryText,
    );

    final timestampWidget = _Timestamp(
      timestamp: timestamp,
      timestampTextStyle: timestampTextStyle,
    );

    return GestureDetector(
      onTapDown: (details) => _fireHaptic(),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: theme?.distance?.padding?.horizontal?.small ?? 0,
          vertical: theme?.distance?.padding?.vertical?.medium ?? 0,
        ),
        child: Row(
          children: <Widget>[
            paddedIconWidget,
            body,
            timestampWidget,
          ],
        ),
      ),
    );
  }
}

class _IconWidget extends StatelessWidget {
  final StandardIcon? iconReference;

  _IconWidget({
    this.iconReference,
  });

  @override
  Widget build(BuildContext context) {
    final theme = SemanticTheme.of(context);

    return iconReference?.buildWidget(
      color: theme?.color?.icon?.generalPrimary ?? Colors.black,
    ) ?? const SizedBox.shrink();
  }
}

class _PaddedBody extends StatelessWidget {
  final String? title;
  final TextStyle? titleTextStyle;
  final WeightDecoratedText? secondaryText;

  _PaddedBody({
    this.title,
    this.titleTextStyle,
    this.secondaryText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = SemanticTheme.of(context);

    List<Widget> columnChildren = [];

    final titleWidget = Text(
      title ?? "",
      style: titleTextStyle,
      overflow: TextOverflow.ellipsis,
    );

    columnChildren.add(titleWidget);

    if (secondaryText != null) {
      final TextStyle defaulTextStyle = theme?.typography?.detailHeavy?.textStyle(
        color: theme.color?.text?.generalSecondary ?? Colors.black,
      ) ?? TextStyle();
      final TextStyle thinTextStyle = theme?.typography?.detail?.textStyle(
        color: theme.color?.text?.generalSecondary ?? Colors.black,
      ) ?? TextStyle();

      final secondaryTextWidget = secondaryText?.generateWidget(
        defaultStyle: defaulTextStyle,
        thinStyle: thinTextStyle,
        textScaler: MediaQuery.of(context).textScaler
      );

      final paddedSecondaryTextWidget = Padding(
        padding: EdgeInsets.only(
          top: theme?.distance?.spacing?.vertical?.min ?? 0,
        ),
        child: secondaryTextWidget,
      );

      columnChildren.add(paddedSecondaryTextWidget);
    }

    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: theme?.distance?.padding?.horizontal?.small ?? 0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: columnChildren,
        ),
      ),
    );
  }
}

class _Timestamp extends StatelessWidget {
  final int? timestamp;
  final TextStyle? timestampTextStyle;

  _Timestamp({
    this.timestamp,
    this.timestampTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    final String formattedTimestamp =
        Date.fromSecondsSinceEpoch(timestamp ?? 0).toAdaptiveString;

    final timestampWidget = Text(
      formattedTimestamp,
      style: timestampTextStyle,
    );

    return Container(
      child: timestampWidget,
    );
  }
}
