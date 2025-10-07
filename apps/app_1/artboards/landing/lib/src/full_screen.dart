import 'package:button_builder/index.dart';
import 'package:titled_table_vertical_full_screen_artboard_template/index.dart';
import 'package:flutter/material.dart';
import 'package:spaced_column_builder/index.dart';
import 'package:table/index.dart';
import 'package:decorated_text/index.dart';
import 'package:semantic_theme/index.dart';
import 'package:navigation_icon_library/index.dart';
import 'package:icon_button_builder/index.dart';
import 'package:sell_artboard/index.dart';
import 'package:navigator/index.dart';
import 'package:merchant_artboard/index.dart';

import '_data.dart';
import 'package:app1_cells/index.dart';
import 'store_code_form.dart';

class LandingFullScreenArtboard
    extends TitledVerticalFullTableScreenArtboard
    with
        // LandingArtboardData,
        SpacedColumnBuilder,
        PrimaryCenterButtonBuilder, 
        SecondaryCenterButtonBuilder,
        ActionIconButtonBuilder {
  @override
  String get artboardTitle => '🥥 Coco Pay';

  @override
  String get artboardSubtitle => 'Community commerce';

  @override
  Widget? artboardNavButton(BuildContext context) => null;

  @override
  final streamTable = LandingStreamTable();
  
  @override
  List<Widget> artboardActionButtons(BuildContext context) => [
        buildSecondaryActionIconButton(
      iconReference: NavigationIcon.settings,
      onTap: () => print('settings'),
    ),
  ];

  // @override
  List<Widget>? Function(BuildContext) get buildSpacedColumnButtons => 
      (BuildContext context) => [
            // buildPrimaryCenterButton(
            //   context,
            //   onTap: () {
            //     ArtboardNavigator.of(context)?.goTo(
            //       SignUpVerticalFloatingArtboard(),
            //     );
            //   },
            //   text: "Sign up",
            // ),
            buildSecondaryCenterButton(
              context,
              onTap: () {
                ArtboardNavigator.of(context)?.goTo(
                  SellVerticalFloatingArtboard(),
                );
              },
              text: "Create your business",
            ),
            buildPrimaryCenterButton(
              context,
              onTap: () {
                ArtboardNavigator.of(context)?.goTo(
                  StoreCodeVerticalFloatingArtboard(),
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
  List<StreamableTableSectionData>? get sectionData => [
      StreamableTableSectionData(
        headerData: StreamableTableSectionHeaderData(title: "Recent"),
        criteria: (rowData) => (rowData as LandingItemData).section == 0,
      ),
      StreamableTableSectionData(
        headerData:  StreamableTableSectionHeaderData(title: "Trending"),
        criteria: (rowData) => (rowData as LandingItemData).section == 1,
      ),
    ];


    @override
    List<StreamableTableRowData>? get rowData {
      // Sample merchants split into two sections
      final recentlyShopped = [
        Merchant(
          name: "Om Coffee",
          createdAt: DateTime.now().millisecondsSinceEpoch ~/ 1000,
          logoUri: "https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=100&h=100&fit=crop",
          section: 0,
          ticker: "OM",
        ),
        Merchant(
          name: "Paradiso Cafe",
          createdAt: DateTime.now().millisecondsSinceEpoch ~/ 1000 - 3600,
          logoUri: "https://images.unsplash.com/photo-1526738549149-8e07eca6c147?w=100&h=100&fit=crop",
          section: 0,
          ticker: "PARA",
        ),
        Merchant(
          name: "Vizu Parilla Bar",
          createdAt: DateTime.now().millisecondsSinceEpoch ~/ 1000 - 7200,
          logoUri: "https://images.unsplash.com/photo-1542838132-92c53300491e?w=100&h=100&fit=crop",
          section: 0,
          ticker: "VIZU",
        ),
        Merchant(
          name: "Eleve Pilates",
          createdAt: DateTime.now().millisecondsSinceEpoch ~/ 1000 - 10800,
          logoUri: "https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=100&h=100&fit=crop",
          section: 0,
          ticker: "ELEV",
        ),
        Merchant(
          name: "Cafe Preto Tattoo",
          createdAt: DateTime.now().millisecondsSinceEpoch ~/ 1000 - 14400,
          logoUri: "https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=100&h=100&fit=crop",
          section: 0,
          ticker: "PRET",
        ),
      ];

      final topShopsAroundYou = [
        Merchant(
          name: "Recanto Dos Pães",
          createdAt: DateTime.now().millisecondsSinceEpoch ~/ 1000 - 18000,
          logoUri: "https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=100&h=100&fit=crop",
          section: 1,
          ticker: "RECA",
        ),
        Merchant(
          name: "Sehat Thai",
          createdAt: DateTime.now().millisecondsSinceEpoch ~/ 1000 - 21600,
          logoUri: "https://images.unsplash.com/photo-1596462502278-27bfdc403348?w=100&h=100&fit=crop",
          section: 1,
          ticker: "SEHA",
        ),
        Merchant(
          name: "GIWA Spa",
          createdAt: DateTime.now().millisecondsSinceEpoch ~/ 1000 - 25200,
          logoUri: "https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=100&h=100&fit=crop",
          section: 1,
          ticker: "GIWA",
        ),
        Merchant(
          name: "Nefasta Cervejaria",
          createdAt: DateTime.now().millisecondsSinceEpoch ~/ 1000 - 28800,
          logoUri: "https://images.unsplash.com/photo-1450778869180-41d0601e046e?w=100&h=100&fit=crop",
          section: 1,
          ticker: "NEFA",
        ),
        Merchant(
          name: "Suflocos Bar",
          createdAt: DateTime.now().millisecondsSinceEpoch ~/ 1000 - 32400,
          logoUri: "https://images.unsplash.com/photo-1513475382585-d06e58bcb0e0?w=100&h=100&fit=crop",
          section: 1,
          ticker: "SUFL",
        ),
      ];

      // Convert merchants to LandingItemData and combine both sections
      final allMerchants = [...recentlyShopped, ...topShopsAroundYou];
      return allMerchants.map((merchant) => _dataForMerchant(merchant)).toList();
    }


    LandingItemData _dataForMerchant(Merchant merchant) {
      final decoratedTitle = WeightDecoratedText();

      decoratedTitle.addSection(text: merchant.name ?? '');

      String? logoUri = merchant.logoUri;

      if (logoUri != null) {
        logoUri = logoUri.replaceAll("ipfs://", "https://jbm.infura-ipfs.io/ipfs/");
      }

      return LandingItemData(
        title: decoratedTitle,
        description: '',
        image: logoUri != null ? Image.network(logoUri) : null,
        section: merchant.section,
        timestamp: merchant.createdAt ?? 0,
        ticker: merchant.ticker,
      );
    }
}

class LandingStreamTable extends StreamTable<StreamableTableRowData,
    StreamableTableSectionHeaderData, StreamableTableHeaderData> {
  Widget buildLandingCell({
    LandingItemData? rowData,
    int? rowIndex,
    int? sectionIndex,
    VoidCallback? onTap,
  }) {
    return LandingItemCell(
      title: rowData?.title,
      note: "" + (rowData?.description ?? ""),
      image: rowData?.image,
      timestamp: rowData?.timestamp,
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
    if (rowData is LandingItemData) {
      return buildLandingCell(
        rowData: rowData,
        rowIndex: rowIndex,
        sectionIndex: sectionIndex,
        onTap: () => ArtboardNavigator.of(context)?.goTo(
          MerchantFullScreenArtboard(
            merchantTitle: rowData.title.text,
            ticker: rowData.ticker,
          ),
        )
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