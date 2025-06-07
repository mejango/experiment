import 'package:button_builder/index.dart';
import 'package:titled_table_vertical_full_screen_artboard_template/index.dart';
import 'package:flutter/material.dart';
import 'package:spaced_column_builder/index.dart';
import 'package:vertical_full_screen_artboard_scaffold/index.dart';
import 'package:table/index.dart';

import '_data.dart';

class LandingFullScreenArtboard
    extends TitledVerticalFullTableScreenArtboard
    with
        LandingArtboardData,
        SpacedColumnBuilder,
        PrimaryCenterButtonBuilder {
  @override
  String get artboardTitle => 'JuicyPay';

  @override
  String get artboardSubtitle => 'Trending projects';

  @override
  Widget? artboardNavButton(BuildContext context) => null;
  
  @override
  List<Widget> artboardActionButtons(BuildContext context) => [];

  // @override
  // List<Widget>? Function(BuildContext) get buildSpacedColumnButtons => null;
      // (BuildContext context) => [
      //       buildPrimaryCenterButton(
      //         context,
      //         onTap: () {
      //           print('boom');
      //           // ArtboardNavigator.of(context).goTo(
      //           //   SignUpVerticalFloatingArtboard(),
      //           // );
      //         },
      //         icon: XSmallIcon.house,
      //         text: "I'm a roommate",
      //       ),
          //   buildPrimaryCenterButton(
          //     context,
          //     onTap: () => print('login'),
          //     icon: XSmallIcon.house,
          //     text: "I'm a tenant",
          //   ),
          //   buildPrimaryCenterButton(
          //     context,
          //     onTap: () => print('login'),
          //     icon: XSmallIcon.house,
          //     text: "I'm a landlord",
          //   ),
          //   buildPrimaryCenterButton(
          //     context,
          //     onTap: () => print('login'),
          //     icon: XSmallIcon.house,
          //     text: "Log in",
          //   ),
          // ];
  
  // @override
  // Widget buildDock(BuildContext context) => buildSpacedColumn(
  //       context,
  //       children: buildSpacedColumnButtons(context),
  //     );

  @override
  State<LandingFullScreenArtboard> createState() => _LandingFullScreenArtboardState();
}

class _LandingFullScreenArtboardState<T extends LandingFullScreenArtboard>
    extends State<T> with VerticalFullScreenArtboardState<T> {

  List<Object?>? projects;

  @override
  void initState() {
    print("initState");
    _fetchData();
    super.initState();
  }

  Future _fetchData() async {
    if (projects == null) {
      projects = await Projects().get(pageSize: 50);
    }

    final tableData = projects?.map((object) {
      return widget.dataForProject(object as Project);
    }).toList();

    widget.table.batchInsertRowData(tableData as List<StreamableTableRowData>);
  }

@override
  Widget build(BuildContext context) {
    final superWidget = super.build(context);
    if (projects != null) {
      final tableData = projects?.map((object) {
        return widget.dataForProject(object as Project);
      }).toList();

      widget.table.batchInsertRowData(tableData as List<StreamableTableRowData>);
    }
    return superWidget;
  }
}
