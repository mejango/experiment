import 'package:flutter/material.dart';
import 'package:semantic_theme/index.dart';

mixin NavBar implements StatelessWidget {
  List<Widget>? get actionButtons;
  List<Widget>? buildNavigationWidgets(BuildContext context);

  Widget build(BuildContext context) {
    final theme = SemanticTheme.of(context);

    final List<Widget> rowChildren = [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: buildNavigationWidgets(context) ?? [],
      ),
    ];

    if (actionButtons != null) {
      rowChildren.add(
        Row(children: actionButtons ?? []),
      );
    }

    final itemRow = Center(
      child: Column(
        // Stretch the cards in horizontal axis
        crossAxisAlignment: CrossAxisAlignment.stretch,

        ///Pushes sub-layout to the bottom.
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: rowChildren,
          ),
        ],
      ),
    );

    final safeAreaTop = MediaQuery.of(context).padding.top;

    return Container(
      padding: EdgeInsets.fromLTRB(
        theme?.distance?.gutter?.horizontal?.small ?? 0,
        (theme?.distance?.gutter?.vertical?.small ?? 0) + safeAreaTop,
        theme?.distance?.gutter?.horizontal?.small ?? 0,
        theme?.distance?.gutter?.vertical?.small ?? 0,
      ),
      decoration: BoxDecoration(
        color: theme?.color?.background?.general ?? Colors.white,
        boxShadow: [theme?.shadow?.medium ?? BoxShadow(color: Colors.black, blurRadius: 0)],
      ),
      child: itemRow,
    );
  }
}
