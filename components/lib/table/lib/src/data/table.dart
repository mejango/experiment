import 'package:flutter/material.dart';
import 'package:stream/index.dart';

import 'table_header.dart';
import 'section.dart';
import 'row.dart';

import '../util/index.dart';

class StreamableTableData extends StreamableData {
  final StreamableTableHeaderData? headerData;
  final Axis scrollDirection;
  final bool reverse;

  //Sections should never be changed or removed.
  final List<StreamableTableSectionData?> sectionData;

  List<StreamableTableRowData?> get rowData {
    return sectionData.expand((sectionData) => sectionData?.rowData ?? <StreamableTableRowData?>[]).toList();
  }

  StreamableTableData(
      {this.headerData,
      this.sectionData = const [],
      Axis scrollDirection = Axis.vertical,
      bool reverse = false,
      List<StreamableTableRowData?>? rowData = const []})
      : reverse = reverse,
        scrollDirection = scrollDirection {
    _sortWithRowData(rowData);
  }

  StreamableTableData.withoutSections(
      {StreamableTableHeaderData? headerData,
      bool reverse = false,
      Axis scrollDirection = Axis.vertical,
      List<StreamableTableRowData?>? rowData = const []})
      : this(
            headerData: headerData,
            sectionData: [
              StreamableTableSectionData(
                  criteria: (_) => true, headerData: null, sort: (_, __) => 0)
            ],
            reverse: reverse,
            scrollDirection: scrollDirection,
            rowData: rowData);

  void replaceTableLocation(
      TableLocation location, StreamableTableRowData rowData) {
    final sectionData = this.sectionData[location.sectionIndex];
    sectionData?.replaceIndex(location.rowIndex, rowData);
  }

  void addRowData(StreamableTableRowData rowData, int index) {
    if (index < 0 || index >= this.sectionData.length) return;

    final sectionData = this.sectionData[index];
    sectionData?.addRowData(rowData);
  }

  void removeAtTableLocation(TableLocation location) {
    final sectionData = this.sectionData[location.sectionIndex];
    sectionData?.removeRowDataAtIndex(location.rowIndex);
  }

  StreamableTableRowData? rowDataAt(TableLocation location) {
    final sectionData = this.sectionData[location.sectionIndex];
    final rowData = sectionData?.rowData[location.rowIndex];
    return rowData;
  }

  void sort() {
    _sortWithRowData(rowData);
  }

  void _sortWithRowData(List<StreamableTableRowData?>? rowData) {
    //Empty all sections.
    for (var sectionData in sectionData) {
      sectionData?.rowData.removeRange(0, sectionData.rowData.length);
    }

    //Add the rows to their correct sections.
    for (var rowData in rowData ?? <StreamableTableRowData?>[]) {
      for (final sectionData in sectionData) {
        if (!(sectionData?.acceptsRow(rowData) ?? false)) continue;
        sectionData?.addRowData(rowData);
        break;
      }
    }

    //Sort the sections.
    for (var sectionData in sectionData) {
      sectionData?.sortRowData();
    }
  }

  TableLocation? tableLocationOfRowData(StreamableTableRowData rowData) {
    for (int i = 0; i < sectionData.length; i++) {
      final sectionData = this.sectionData[i];
      final rowIndex = sectionData?.indexOfRowData(rowData);
      if (rowIndex == null || rowIndex < 0) continue;

      return TableLocation(rowIndex: rowIndex, sectionIndex: i);
    }
    return null;
  }
}
