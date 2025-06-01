import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:semantic_theme/index.dart';

class SpacedListView extends StatefulWidget {
  final List<Widget>? children;
  final Widget? button;
  final ScrollController? scrollController;
  final bool? buttonIsLast;

  SpacedListView({
    this.children,
    this.button,
    this.scrollController,
    this.buttonIsLast,
  });

  @override
  _SpacedListViewState createState() => _SpacedListViewState();
}

class _SpacedListViewState extends State<SpacedListView> {
  @override
  Widget build(BuildContext context) {
    final theme = SemanticTheme.of(context);

    List<Widget>? spacedChildren = widget.children?.map(
          (child) => Container(
            child: child,
            margin: EdgeInsets.only(
              bottom: theme?.distance.gutter.vertical.medium ?? 0,
            ),
          ),
        )
        .toList();

    if (widget.button != null) {
      final paddedButton = Container(
        child: widget.button,
        margin: widget.buttonIsLast == true
            ? EdgeInsets.only(top: theme?.distance.spacing.vertical.medium ?? 0)
            : EdgeInsets.only(bottom: theme?.distance.spacing.vertical.medium ?? 0),
      );

      spacedChildren = widget.buttonIsLast == true
          ? [...spacedChildren ?? [], paddedButton]
          : [paddedButton, ...spacedChildren ?? []];
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: theme?.distance.gutter.horizontal.medium ?? 0,
      ),
      color: theme?.color.background.general ?? Colors.transparent,
      child: ListView(
        controller: widget.scrollController,
        padding: EdgeInsets.only(
          bottom: theme?.distance.gutter.vertical.medium ?? 0,
        ),
        children: spacedChildren ?? [],
      ),
    );
  }
}
