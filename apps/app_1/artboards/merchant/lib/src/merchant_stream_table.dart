import 'package:flutter/material.dart';
import 'package:table/index.dart';
import 'token_cell.dart';

class TokenItemData extends StreamableTableRowData {
  final String ticker;
  final double balance;
  final double valuePerToken;
  final double issuance;

  TokenItemData({
    required this.ticker,
    required this.balance,
    required this.valuePerToken,
    required this.issuance,
  });
}

class MerchantStreamTable extends StreamTable<StreamableTableRowData,
    StreamableTableSectionHeaderData, StreamableTableHeaderData> {
  
  Widget buildTokenCell({
    TokenItemData? rowData,
    int? rowIndex,
    int? sectionIndex,
    VoidCallback? onTap,
  }) {
    return TokenCell(
      ticker: rowData?.ticker ?? '',
      balance: rowData?.balance ?? 0.0,
      valuePerToken: rowData?.valuePerToken ?? 0.0,
      issuance: rowData?.issuance ?? 0.0,
      onTap: onTap,
    );
  }

  @override
  Widget? buildRow({
    required StreamableTableRowData rowData,
    required BuildContext context,
    int? rowIndex,
    int? sectionIndex,
  }) {
    if (rowData is TokenItemData) {
      return buildTokenCell(
        rowData: rowData,
        rowIndex: rowIndex,
        sectionIndex: sectionIndex,
        onTap: () => print('Token tapped: ${rowData.ticker}'),
      );
    }

    return null;
  }

  @override
  Widget? buildSectionHeader({
    required BuildContext context,
    required StreamableTableSectionHeaderData headerData,
    int? sectionIndex,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      child: Text(
        headerData.title ?? '',
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
