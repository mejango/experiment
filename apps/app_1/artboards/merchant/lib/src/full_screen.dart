import 'package:button_builder/index.dart';
import 'package:titled_table_vertical_full_screen_artboard_template/index.dart';
import 'package:flutter/material.dart';
import 'package:spaced_column_builder/index.dart';
import 'package:table/index.dart';
import 'package:semantic_theme/index.dart';
import 'package:navigation_icon_library/index.dart';
import 'package:icon_button_builder/index.dart';
import 'package:navigator/index.dart';

import 'merchant_stream_table.dart';
import 'payment_form.dart';

class MerchantFullScreenArtboard
    extends TitledVerticalFullTableScreenArtboard
    with
        // LandingArtboardData,
        SpacedColumnBuilder,
        PrimaryCenterButtonBuilder, 
        SecondaryCenterButtonBuilder,
        ActionIconButtonBuilder,
        NavIconButtonBuilder {
  
  final String merchantTitle;
  final String? merchantSubtitle;
  final String? ticker;

  MerchantFullScreenArtboard({
    required this.merchantTitle,
    this.merchantSubtitle,
    this.ticker,
  });

  @override
  String get artboardTitle => merchantTitle;

  @override
  String? get artboardSubtitle => merchantSubtitle;

  @override
  Widget? artboardNavButton(BuildContext context) => buildNavIconButton(
    iconReference: NavigationIcon.backArrow,
    onTap: () => ArtboardNavigator.of(context)?.pop("back"),
  );

  @override
  final streamTable = MerchantStreamTable();
  

  @override
  List<Widget> artboardActionButtons(BuildContext context) => [];

  // @override
  List<Widget>? Function(BuildContext) get buildSpacedColumnButtons => 
      (BuildContext context) => [
            buildPrimaryCenterButton(
              context,
              onTap: () {
                ArtboardNavigator.of(context)?.goTo(
                  PaymentVerticalFloatingArtboard(),
                );
              },
              text: "Pay",
            ),
          ];
  
  @override
  Widget buildDock(BuildContext context) => Container(
        color: SemanticTheme.of(context)?.color?.background?.raised,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
              child: buildSpacedColumn(
              context,
              children: buildSpacedColumnButtons(context) ?? [],
            ),
            ),
          ],
        ),
      );
  
  @override
  List<StreamableTableSectionData>? get sectionData => null;

    @override
    List<StreamableTableRowData>? get rowData {
      // Use dynamic ticker or default to COCO
      final tokenTicker = ticker ?? "COCO";
      
      return [
        TokenItemData(
          ticker: tokenTicker,
          balance: 150.75,
          issuance: 100.0,
          valuePerToken: 2.45,
        ),
      ];
    }

}