import 'package:flutter/material.dart';
import 'package:mask/index.dart';
import 'package:date/index.dart';
import 'package:tag_builder/index.dart';
import 'package:key_value_row_builder/index.dart';
import 'package:invoice_options/index.dart';
import 'package:tag_kind_option/index.dart';

import '_a.dart';

class InvoiceCell extends StatelessWidget with KeyValueRowBuilder {
  final String? name;
  final int? totalAmount;
  final int? unpaidAmount;
  final int? dueTimestamp;
  final InvoiceType? invoiceType;
  final VoidCallback? onTap;

  InvoiceCell({
    this.name,
    this.totalAmount,
    this.unpaidAmount,
    this.dueTimestamp,
    this.invoiceType,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final InvoiceStatusOption invoiceStatus = InvoiceStatus.fromInvoice(
      unpaidAmount ?? 0,
      dueTimestamp ?? 0,
    );

    final dueText =
        Date.fromSecondsSinceEpoch(dueTimestamp ?? 0).toLongMonthAbbreviatedString;

    final dueRow = buildKeyValueRow(
      context,
      title: "Due",
      value: dueText,
    );

    final formattedTotal = applyMask(
      MaskOption.money,
      text: (totalAmount ?? 0 / 100).toString(),
      context: context,
    );

    final amountRow = buildKeyValueRow(
      context,
      title: "Total amount",
      value: formattedTotal,
    );

    final formattedUnpaid = applyMask(
      MaskOption.money,
      text: (unpaidAmount ?? 0 / 100).toString(),
      context: context,
    );

    final unpaidRow = buildKeyValueRow(
      context,
      title: "Unpaid",
      value: formattedUnpaid,
    );

    final typeRow = buildKeyValueRow(
      context,
      title: "Invoice type",
      value: invoiceType?.displayString ?? "",
    );

    return CellA(
      title: name,
      titleAccessory: _StatusTag(invoiceStatus),
      rows: <Widget>[
        dueRow,
        amountRow,
        unpaidRow,
        typeRow,
      ],
      onTap: onTap,
    );
  }
}

class _StatusTag extends StatelessWidget with TagBuilder {
  final InvoiceStatusOption status;

  _StatusTag(this.status);

  TagKindOption? _getTagKind(InvoiceStatusOption status) {
    switch (status) {
      case InvoiceStatusOption.paid:
        return TagKindOption.good;
      case InvoiceStatusOption.overdue:
        return TagKindOption.error;
      case InvoiceStatusOption.unpaid:
        return TagKindOption.normal;
    }
  }

  String? _getStatusText(InvoiceStatusOption status) {
    switch (status) {
      case InvoiceStatusOption.paid:
        return "PAID";
      case InvoiceStatusOption.overdue:
        return "OVERDUE";
      case InvoiceStatusOption.unpaid:
        return "UNPAID";
    }
  }

  @override
  Widget build(BuildContext context) {
    return buildTag(
      context,
      text: _getStatusText(status),
      kind: _getTagKind(status)
    );
  }
}
