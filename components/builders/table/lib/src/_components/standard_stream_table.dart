import 'package:flutter/material.dart';
import 'package:table/index.dart';

import '../data/index.dart';
import '_cells/activity.dart';
import '_section_headers/a.dart';

class StandardStreamTable extends StreamTable<StreamableTableRowData,
    StreamableTableSectionHeaderData, StreamableTableHeaderData> {
  Widget buildCellA({
    CellAData? rowData,
    int? rowIndex,
    int? sectionIndex,
  }) {
    return ActivityCell(
      title: rowData?.title,
      note: "" + (rowData?.description ?? ""),
      image: rowData?.image,
      timestamp: rowData?.timestamp,
    );
  }

  @override
  Widget? buildRow({
    required BuildContext context,
    required StreamableTableRowData rowData,
    int? rowIndex,
    int? sectionIndex,
  }) {
    if (rowData is CellAData) {
      return buildCellA(
        rowData: rowData,
        rowIndex: rowIndex,
        sectionIndex: sectionIndex,
      );
    }

    return null;
  }

  Widget? buildSectionHeader({
    required BuildContext context,
    StreamableTableSectionHeaderData? headerData,
    int? sectionIndex,
  }) =>
      TableSectionHeaderA(title: headerData?.title);
}
