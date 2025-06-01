import 'package:flutter/material.dart';
import 'package:mask/index.dart';
import 'package:date/index.dart';
import 'package:haptics/index.dart';
import 'package:semantic_theme/index.dart';
import 'package:tag_builder/index.dart';
import 'package:lease_status/index.dart';
import 'package:tag_kind_option/index.dart';

import '../_widgets/cell_primary_title.dart';
import '../_widgets/cell_spaced_row.dart';

class LeaseCell extends StatelessWidget {
  final List<String>? tenants;
  final String? title;
  final int? rentAmount;
  final int? startTimestamp;
  final int? endTimestamp;
  final VoidCallback? onTap;

  LeaseCell({
    this.tenants,
    this.title,
    this.rentAmount,
    this.startTimestamp,
    this.endTimestamp,
    this.onTap,
  });

  final _tapHapticOption = HapticOption.light;

  void _fireHaptic() {
    if (onTap != null) triggerHaptic(_tapHapticOption);
  }

  @override
  Widget build(BuildContext context) {
    final theme = SemanticTheme.of(context);

    final titleWidget = CellPrimaryTitle(title ?? "");

    final leaseStatus = LeaseStatus.fromLease(startTimestamp ?? 0, endTimestamp ?? 0);

    final statusWidget = Container(
      margin: EdgeInsets.only(
        left: theme?.distance.spacing.horizontal.small ?? 0,
      ),
      child: _StatusTag(leaseStatus),
    );

    final titleRow = CellSpacedRow(
      children: <Widget>[
        titleWidget,
        statusWidget,
      ],
    );
    List<Widget> columnChildren = [titleRow];

    final formattedAmount = applyMask(
      MaskOption.money,
      text: (rentAmount ?? 0 / 100).toString(),
      context: context,
    );

    final rentWidget = Container(
      margin: EdgeInsets.only(
        right: theme?.distance.spacing.horizontal.small ?? 0,
      ),
      child: Text(
        formattedAmount,
        style: theme?.typography.bodyHeavy.textStyle(
          color: theme.color.text.generalPrimary,
        ),
      ),
    );

    final dateWidget = _DateRange(
      startTimestamp ?? 0,
      endTimestamp ?? 0,
    );

    final statsRow = Container(
      margin: EdgeInsets.only(
        top: theme?.distance.spacing.vertical.large ?? 0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: <Widget>[
          rentWidget,
          dateWidget,
        ],
      ),
    );

    columnChildren.add(statsRow);

    if (tenants != null) {
      final tenantsSection = Container(
        margin: EdgeInsets.only(
          top: theme?.distance.spacing.vertical.large ?? 0,
        ),
        child: _Tenants(tenants ?? []),
      );
      columnChildren.add(tenantsSection);
    }

    final bodyColumn = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: columnChildren,
    );

    return GestureDetector(
      onTapDown: (details) => _fireHaptic(),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: theme?.distance.padding.horizontal.medium ?? 0,
          vertical: theme?.distance.padding.vertical.medium ?? 0,
        ),
        margin: EdgeInsets.only(
          top: theme?.distance.spacing.vertical.small ?? 0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(theme?.radius.medium ?? Radius.circular(0)),
          border: Border.all(color: theme?.color.stroke.medium ?? Colors.black),
          color: theme?.color.background.raised ?? Colors.white,
        ),
        child: bodyColumn,
      ),
    );
  }
}

class _Tenants extends StatelessWidget {
  final List<String> tenants;

  _Tenants(this.tenants);

  @override
  Widget build(BuildContext context) {
    final theme = SemanticTheme.of(context);

    String tenantString = "";

    for (int i = 0; i < tenants.length; i++) {
      final bool isLastTenant = i == tenants.length - 1;

      tenantString += tenants[i] + (isLastTenant ? "" : ", ");
    }

    return Text(
      tenantString,
      style: theme?.typography.body.textStyle(
        color: theme?.color.text.generalPrimary ?? Colors.black,
      ),
    );
  }
}

class _DateRange extends StatelessWidget {
  final int startTimestamp;
  final int endTimestamp;

  _DateRange(
    this.startTimestamp,
    this.endTimestamp,
  );

  @override
  Widget build(BuildContext context) {
    final theme = SemanticTheme.of(context);

    final startTimestampText =
        Date.fromSecondsSinceEpoch(startTimestamp).toLongString;
    final endTimestampText =
        Date.fromSecondsSinceEpoch(endTimestamp).toLongString;
    final formattedDateString = "$startTimestampText - $endTimestampText";

    return Text(
      formattedDateString,
      style: theme?.typography.detail.textStyle(
        color: theme.color.text.generalSecondary,
      ),
    );
  }
}

class _StatusTag extends StatelessWidget with TagBuilder {
  final LeaseStatusOption status;

  _StatusTag(this.status);

  TagKindOption? _getTagKind(LeaseStatusOption status) {
    switch (status) {
      case LeaseStatusOption.active:
        return TagKindOption.good;
      case LeaseStatusOption.ended:
      case LeaseStatusOption.upcoming:
        return TagKindOption.normal;
    }
  }

  String? _getStatusText(LeaseStatusOption status) {
    switch (status) {
      case LeaseStatusOption.active:
        return "ACTIVE";
      case LeaseStatusOption.ended:
        return "ENDED";
      case LeaseStatusOption.upcoming:
        return "UPCOMING";
    }
  }

  @override
  Widget build(BuildContext context) {
    return buildTag(
      context,
      text: _getStatusText(status),
      kind: _getTagKind(status),
    );
  }
}
