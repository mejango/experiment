import 'package:flutter/material.dart';
import 'package:semantic_theme/index.dart';
import 'package:tag_kind_option/index.dart';
import 'package:mask/index.dart';
import 'package:date/index.dart';
import 'package:haptics/index.dart';
import 'package:tag_builder/index.dart';
import 'package:key_value_row_builder/index.dart';

import '../_widgets/cell_primary_title.dart';
import '../_widgets/cell_spaced_row.dart';

class PaymentCell extends StatelessWidget with KeyValueRowBuilder {
  final String? tenant;
  final int? amount;
  final int? timestamp;
  final String? note;
  final PaymentStatus? paymentStatus;
  final VoidCallback? onTap;

  PaymentCell({
    this.tenant,
    this.amount,
    this.timestamp,
    this.note,
    this.paymentStatus,
    this.onTap,
  });

  // final _radius = radius.regular;
  // final _cellPadding = distance.c;
  // final _spacing = distance.b;
  // final _topMargin = distance.b;
  final _tapHapticOption = HapticOption.light;

  void _fireHaptic() {
    if (onTap != null) triggerHaptic(_tapHapticOption);
  }

  @override
  Widget build(BuildContext context) {
    final theme = SemanticTheme.of(context);

    final tenantNameWidget = CellPrimaryTitle(tenant ?? "");

    final statusTag = Container(
      margin: EdgeInsets.only(
        left: theme?.distance?.spacing?.horizontal?.small ?? 0,
      ),
      child: _StatusTag(paymentStatus ?? PaymentStatus.manual),
    );

    final titleRow = CellSpacedRow(
      children: <Widget>[
        tenantNameWidget,
        statusTag,
      ],
    );
    List<Widget> columnChildren = [titleRow];

    final dateText =
        Date.fromSecondsSinceEpoch(timestamp ?? 0).toLongMonthAbbreviatedString;

    if (note != null && note!.isNotEmpty) {
      final messageRow = Container(
        margin: EdgeInsets.only(
          top: theme?.distance?.spacing?.vertical?.small ?? 0,
        ),
        child: Text(
          note ?? "",
          style: theme?.typography?.body?.textStyle(
            color: theme.color?.text?.generalSecondary ?? Colors.black,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      );
      columnChildren.add(messageRow);
    }

    final dateRow = buildKeyValueRow(
      context,
      title: "Date",
      value: dateText,
      valueStyle: theme?.typography?.bodyHeavy?.textStyle(
        color: theme.color?.text?.generalPrimary ?? Colors.black,
      ),
    );
    columnChildren.add(dateRow);

    final formattedTotal = applyMask(
      MaskOption.money,
      text: (amount ?? 0 / 100).toString(),
      context: context,
    );

    final amountRow = buildKeyValueRow(
      context,
      title: "Amount",
      value: formattedTotal,
    );
    columnChildren.add(amountRow);

    final bodyColumn = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: columnChildren,
    );

    return GestureDetector(
      onTapDown: (details) => _fireHaptic(),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: theme?.distance?.padding?.horizontal?.medium ?? 0,
          vertical: theme?.distance?.padding?.vertical?.medium ?? 0,
        ),
        margin: EdgeInsets.only(
          top: theme?.distance?.spacing?.vertical?.small ?? 0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            theme?.radius?.medium ?? Radius.circular(0),
          ),
          border: Border.all(color: theme?.color?.stroke?.medium ?? Colors.black),
          color: theme?.color?.background?.raised ?? Colors.white,
        ),
        child: bodyColumn,
      ),
    );
  }
}

class _StatusTag extends StatelessWidget with TagBuilder {
  final PaymentStatus status;

  _StatusTag(this.status);

  TagKindOption? _getTagKind(PaymentStatus status) {
    switch (status) {
      case PaymentStatus.cancelled:
        return TagKindOption.error;
      case PaymentStatus.processed:
        return TagKindOption.good;
      case PaymentStatus.manual:
        return TagKindOption.normal;
    }
  }

  String? _getStatusText(PaymentStatus status) {
    switch (status) {
      case PaymentStatus.manual:
        return "MANUAL";
      case PaymentStatus.cancelled:
        return "CANCELLED";
      case PaymentStatus.processed:
        return "PROCESSED";
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

enum PaymentStatus {
  manual,
  cancelled,
  processed,
}
