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

  @override
  Widget build(BuildContext context) {
    // Return a sliver directly
    return BlocProvider(
      bloc: bloc,
      child: StreamTableBuilder(
        buildRow: ({required StreamableTableRowData rowData, int? rowIndex, int? sectionIndex}) => 
            buildRow(rowData: rowData as T, context: context, rowIndex: rowIndex, sectionIndex: sectionIndex),
        buildSectionHeader: ({required StreamableTableSectionHeaderData headerData, int? sectionIndex}) => 
            buildSectionHeader(headerData: headerData as U, context: context, sectionIndex: sectionIndex),
        buildTableHeader: ({required StreamableTableHeaderData headerData}) => 
            buildTableHeader(headerData: headerData as V, context: context),
        showsHeaderForEmptyTable: showsHeaderForEmptyTable,
        showsHeadersForEmptySections: showsHeadersForEmptySections,
      ),
    );
  }

  Widget? buildRow({required T rowData, required BuildContext context, int? rowIndex, int? sectionIndex}) => null;
  Widget? buildSectionHeader({required U headerData, required BuildContext context, int? sectionIndex}) => null;
  SliverPersistentHeader? buildTableHeader({required V headerData, required BuildContext context}) => null;
}