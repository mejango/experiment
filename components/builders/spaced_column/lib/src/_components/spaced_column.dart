import 'package:flutter/material.dart';
import 'package:semantic_theme/index.dart';

class SpacedColumn extends StatelessWidget {
  final List<Widget> children;

  SpacedColumn({required this.children});

  @override
  Widget build(BuildContext context) {
    final theme = SemanticTheme.of(context);

    final List<Widget> stackChildren = [];

    for (final child in children) {
      stackChildren.add(
        Padding(
          child: child,
          padding: EdgeInsets.only(
            top: theme?.distance?.spacing?.vertical?.medium ?? 0,
          ),
        ),
      );
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: theme?.distance?.gutter?.horizontal?.medium ?? 0,
        vertical: theme?.distance?.padding?.vertical?.large ?? 0,
      ),
      child: Column(children: stackChildren),
    );
  }
}
