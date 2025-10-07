import 'dart:async';

import 'package:flutter/material.dart';
import 'package:table/index.dart';

import '_components/standard_stream_table.dart';

mixin TableBuilder {
  List<StreamableTableRowData?>? get rowData => null;
  List<StreamableTableSectionData?>? get sectionData => null;
  StreamableTableData? get tableData => null;

  StreamTableBloc get table => streamTable.bloc;

  StreamTable get streamTable;

  StreamTable buildTable(BuildContext context) {
    _load(context);
    return streamTable;
  }

  void _load(BuildContext context) async {
    final tableData = _createTableData(context);
    table.update(tableData);
  }

  StreamableTableData _createTableData(BuildContext context) {
    final tableData = this.tableData;
    if (tableData != null) return tableData;

    final sectionData = this.sectionData;
    final rowData = this.rowData;
    if (sectionData?.isNotEmpty ?? false) {
      return StreamableTableData(sectionData: sectionData!, rowData: rowData!);
    }
    return StreamableTableData.withoutSections(rowData: rowData);
  }
}
