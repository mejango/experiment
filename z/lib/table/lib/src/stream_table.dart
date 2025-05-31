import 'package:flutter/material.dart';
import 'package:stream/index.dart';

import 'bloc.dart';
import 'widget.dart';
import 'data/index.dart';

abstract class StreamTable<
    T extends StreamableTableRowData,
    U extends StreamableTableSectionHeaderData,
    V extends StreamableTableHeaderData> extends StatelessWidget {
  final bloc = StreamTableBloc();

  bool get showsHeaderForEmptyTable => true;
  bool get showsHeadersForEmptySections => false;

  Widget build(BuildContext context) {
    final table = StreamTableBuilder(
      buildRow: ({required StreamableTableRowData rowData, int? rowIndex, int? sectionIndex}) => 
          buildRow(rowData: rowData as T, rowIndex: rowIndex, sectionIndex: sectionIndex),
      buildSectionHeader: ({required StreamableTableSectionHeaderData headerData, int? sectionIndex}) => 
          buildSectionHeader(headerData: headerData as U, sectionIndex: sectionIndex),
      buildTableHeader: ({required StreamableTableHeaderData headerData}) => 
          buildTableHeader(headerData: headerData as V),
      showsHeaderForEmptyTable: showsHeaderForEmptyTable,
      showsHeadersForEmptySections: showsHeadersForEmptySections,
    );
    return BlocProvider(
      bloc: bloc,
      child: table,
    );
  }

  Widget? buildRow({required T rowData, int? rowIndex, int? sectionIndex}) => null;
  Widget? buildSectionHeader({required U headerData, int? sectionIndex}) => null;
  SliverPersistentHeader? buildTableHeader({required V headerData}) => null;
}
