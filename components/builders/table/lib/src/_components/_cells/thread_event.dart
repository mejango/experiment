import 'package:flutter/material.dart';
import 'package:semantic_theme/index.dart';
import 'package:standard_icon_library/index.dart';
import 'package:key_value_builder/index.dart';
import 'package:spaced_grid_builder/index.dart';
import 'package:date/index.dart';
import 'package:haptics/index.dart';

class ThreadEventCell extends StatelessWidget {
  final String? title;
  final int? timestamp;
  final StandardIcon? iconReference;
  final String? note;
  final List<KeyValue>? details;
  final VoidCallback? onTap;

  ThreadEventCell({
    this.title,
    this.timestamp,
    this.iconReference,
    this.note,
    this.details,
    this.onTap,
  });

  final _tapHapticOption = HapticOption.light;

  void _fireHaptic() {
    if (onTap != null) triggerHaptic(_tapHapticOption);
  }

  @override
  Widget build(BuildContext context) {
    final theme = SemanticTheme.of(context);

    final _iconReference = iconReference ?? StandardIcon.event;

    return GestureDetector(
      onTapDown: (details) => _fireHaptic(),
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: theme?.distance.spacing.vertical.small ?? 0,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: theme?.distance.padding.horizontal.small ?? 0,
        ),
        child: _Body(
          iconReference: _iconReference,
          title: title,
          timestamp: timestamp,
          note: note,
          details: details,
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final StandardIcon? iconReference;
  final String? title;
  final int? timestamp;
  final String? note;
  final List<KeyValue>? details;

  _Body({
    this.iconReference,
    this.title,
    this.timestamp,
    this.note,
    this.details,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _Icon(
          iconReference: iconReference,
        ),
        _Content(
          title: title,
          timestamp: timestamp,
          note: note,
          details: details,
        ),
      ],
    );
  }
}

class _Icon extends StatelessWidget {
  final StandardIcon? iconReference;

  _Icon({
    this.iconReference,
  });

  @override
  Widget build(BuildContext context) {
    final theme = SemanticTheme.of(context);

    final iconColor = theme?.color.icon.generalPrimary ?? Colors.black;

    final iconWidget = iconReference?.buildWidget(color: iconColor);

    return Padding(
      padding: EdgeInsets.only(
        right: theme?.distance.padding.horizontal.small ?? 0,
        top: theme?.distance.padding.vertical.small ?? 0,
      ),
      child: iconWidget,
    );
  }
}

class _Content extends StatelessWidget with KeyValueBuilder, SpacedGridBuilder {
  final String? title;
  final int? timestamp;
  final String? note;
  final List<KeyValue>? details;

  _Content({
    this.title,
    this.timestamp,
    this.note,
    this.details,
  });

  @override
  Widget build(BuildContext context) {
    final theme = SemanticTheme.of(context);

    final titleWidget = Flexible(
      child: Text(
        title ?? "",
        style: theme?.typography.body.textStyle(
          color: theme.color.text.generalSecondary,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );

    final formattedTimestamp =
        Date.fromSecondsSinceEpoch(timestamp ?? 0).toAdaptiveString;

    final timestampWidget = Padding(
      padding: EdgeInsets.only(
        left: theme?.distance.padding.horizontal.small ?? 0,
      ),
      child: Text(
        formattedTimestamp,
        style: theme?.typography.detail.textStyle(
          color: theme.color.text.generalSecondary,
        ),
      ),
    );

    final titleRow = Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: <Widget>[titleWidget, timestampWidget],
    );

    final List<Widget> verticalChildren = [titleRow];

    if (note != null && note!.trim().isNotEmpty) {
      final noteWidget = Container(
        margin: EdgeInsets.only(
          top: theme?.distance.spacing.vertical.min ?? 0,
        ),
        child: Text(
          note ?? "",
          style: theme?.typography.body.textStyle(
            color: theme.color.text.generalPrimary,
          ),
        ),
      );

      verticalChildren.add(noteWidget);
    }

    if (details != null) {
      final detailsContainer = Container(
        margin: EdgeInsets.only(
          top: theme?.distance.spacing.vertical.small ?? 0,
        ),
        child: buildSpacedGrid(
          context,
          children: details ?? [],
          horizontalSpacing: theme?.distance.spacing.horizontal.small ?? 0,
          verticalSpacing: theme?.distance.spacing.vertical.small ?? 0,
        ),
      );

      verticalChildren.add(detailsContainer);
    }

    return Flexible(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: theme?.distance.padding.horizontal.medium ?? 0,
          vertical: theme?.distance.padding.vertical.medium ?? 0,
        ),
        decoration: BoxDecoration(
          color: theme?.color.background.raised ?? Colors.white,
          borderRadius: BorderRadius.all(theme?.radius.large ?? Radius.circular(0)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: verticalChildren,
        ),
      ),
    );
  }
}
