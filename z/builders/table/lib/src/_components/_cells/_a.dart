import 'package:flutter/material.dart';
import 'package:haptics/index.dart';
import 'package:semantic_theme/index.dart';

import '../_widgets/cell_body_text_preview.dart';
import '../_widgets/cell_primary_title.dart';
import '../_widgets/cell_spaced_row.dart';

class CellA extends StatelessWidget {
  final String? title;
  final Widget? titleAccessory;
  final List<Widget>? rows;
  final String? note;
  final VoidCallback? onTap;

  CellA({
    this.title,
    this.titleAccessory,
    this.rows,
    this.note,
    this.onTap,
  });

  final _tapHapticOption = HapticOption.light;

  void _fireHaptic() {
    if (onTap != null) triggerHaptic(_tapHapticOption);
  }

  Widget? buildTitleRow(SemanticThemeData? theme) {
    final hasTitle = title != null && title!.isNotEmpty;
    final hasTitleAccessory = title != null;

    if (!hasTitle && !hasTitleAccessory) return null;

    final List<Widget> rowChildren = [];

    if (hasTitle) {
      rowChildren.add(CellPrimaryTitle(title!));
    }

    if (hasTitleAccessory) {
      final spacedTitleAccessory = Container(
        margin: EdgeInsets.only(
          left: theme?.distance.spacing.horizontal.small ?? 0,
        ),
        child: titleAccessory,
      );

      rowChildren.add(spacedTitleAccessory);
    }

    return CellSpacedRow(children: rowChildren);
  }

  @override
  Widget build(BuildContext context) {
    final theme = SemanticTheme.of(context);

    final List<Widget> columnChildren = [];

    final titleRow = buildTitleRow(theme);
    if (titleRow != null) columnChildren.add(titleRow);

    if (rows != null && rows!.isNotEmpty) columnChildren.addAll(rows!);

    if (note != null && note!.isNotEmpty) {
      if (columnChildren.isNotEmpty) {
        final paddedNote = Container(
          margin: EdgeInsets.only(
            top: theme?.distance.spacing.vertical.small ?? 0,
          ),
          child: CellBodyTextPreview(note!),
        );
        columnChildren.add(paddedNote);
      } else {
        columnChildren.add(CellBodyTextPreview(note!));
      }
    }

    return GestureDetector(
      onTapDown: (details) => _fireHaptic(),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: theme?.distance.padding.horizontal.medium ?? 0,
          vertical: theme?.distance.padding.vertical.medium ?? 0,
        ),
        margin: EdgeInsets.only(
          top: theme?.distance.spacing.vertical.medium ?? 0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(theme?.radius.medium ?? Radius.circular(0)),
          border: Border.all(color: theme?.color.stroke.medium ?? Colors.black),
          color: theme?.color.background.general ?? Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: columnChildren,
        ),
      ),
    );
  }
}
