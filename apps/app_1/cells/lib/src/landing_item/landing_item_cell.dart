import 'package:flutter/material.dart';
import 'package:decorated_text/index.dart';
import 'package:semantic_theme/index.dart';
import 'package:date/index.dart';
import 'package:haptics/index.dart';

class LandingItemCell extends StatelessWidget {
  final WeightDecoratedText? title;
  final int? timestamp;
  final Image? image;
  final String? note;
  final VoidCallback? onTap;

  LandingItemCell({
    required this.title,
    required this.timestamp,
    this.image,
    this.note,
    this.onTap,
    Key? key,
  }) : super(key: key);

  final _tapHapticOption = HapticOption.light;

  void _fireHaptic() {
    if (onTap != null) triggerHaptic(_tapHapticOption);
  }

  @override
  Widget build(BuildContext context) {
    final theme = SemanticTheme.of(context);

    return Container(
      child: GestureDetector(
        onTapDown: (details) => _fireHaptic(),
        onTap: onTap,
        child: Container(
          // Everything in the cell is relative to the horizontal padding.
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: theme?.distance?.padding?.horizontal?.small ?? 0,
              vertical: theme?.distance?.padding?.vertical?.min ?? 0,
            ),

            ///This column contains the body of the cell, and the divider;
            child: Column(
              ///Maximizes space between body and divider
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _Body(
                  image: image,
                  title: title ?? WeightDecoratedText(text: ""),
                  note: note ?? "", 
                  timestamp: timestamp,
                ),
                _CellDivider()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final WeightDecoratedText? title;
  final Image? image;
  final String? note;
  final int? timestamp;

  _Body({
    required this.title,
    required this.image,
    this.note,
    this.timestamp,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = SemanticTheme.of(context);

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: theme?.distance?.padding?.vertical?.small ?? 0,
      ),
      //The body of the cell contains the icon and the labels.
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              right: theme?.distance?.spacing?.horizontal?.medium ?? 0,
            ),
            height: 100,
            width: 100,
            child:  image
          ),

          ///This child should expand to occupy remaining space.
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _relevantLabels(theme, timestamp ?? 0),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _relevantLabels(SemanticThemeData? theme, int timestamp) {
    var list = <Widget>[_TitleLabel(decoratedText: title ?? WeightDecoratedText(text: ""))];
    if (note != null && note!.trim().isNotEmpty) {
      list.add(
        Container(
          padding: EdgeInsets.only(
            top: theme?.distance?.padding?.vertical?.min ?? 0,
          ),
          child: _DetailLabel(text: note ?? ""),
        ),
      );
    }
    list.add(_TimeLabel(timestamp));
    return list;
  }
}

class _DetailLabel extends StatelessWidget {
  final String text;

  _DetailLabel({
    Key? key,
    required this.text,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = SemanticTheme.of(context);

    return Text(
      text,
      style: theme?.typography?.body?.textStyle(
        color: theme.color?.text?.generalSecondary ?? Colors.black,
      ),
    );
  }
}

class _CellDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = SemanticTheme.of(context);

    return Container(
      margin: EdgeInsets.only(
        top: theme?.distance?.spacing?.vertical?.small ?? 0,
      ),
      height: 1,
      decoration: BoxDecoration(color: theme?.color?.stroke?.medium ?? Colors.black),
    );
  }
}

class _TitleLabel extends StatelessWidget {
  final WeightDecoratedText decoratedText;

  _TitleLabel({
    Key? key,
    required this.decoratedText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = SemanticTheme.of(context);

    final primaryTextColor = theme?.color?.text?.generalPrimary ?? Colors.black;

    return decoratedText.generateWidget(
      defaultStyle:
          theme?.typography?.title?.textStyle(color: primaryTextColor) ?? TextStyle(),
      thinStyle: theme?.typography?.title?.textStyle(color: primaryTextColor) ?? TextStyle(),
      textScaler: MediaQuery.textScalerOf(context)
    );
  }
}

class _TimeLabel extends StatelessWidget {
  final int timestamp;

  _TimeLabel(this.timestamp);

  @override
  Widget build(BuildContext context) {
    final theme = SemanticTheme.of(context);

    final formattedTimestamp =
        Date.fromSecondsSinceEpoch(timestamp).toAdaptiveString;

    final textWidget = Text(
      "Created $formattedTimestamp",
      style: theme?.typography?.detail?.textStyle(
        color: theme.color?.text?.generalSecondary ?? Colors.black,
      ),
    );

    return textWidget;
  }
}
