import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:semantic_theme/index.dart';

class ThreadListView extends StatefulWidget {
  final List<Widget>? children;
  final Widget? button;

  ThreadListView({
    this.children,
    this.button,
  });

  @override
  _ThreadListViewState createState() => _ThreadListViewState();
}

class _ThreadListViewState extends State<ThreadListView> {
  ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(_setInitialScroll);
  }

  void _setInitialScroll(_) {
    _controller.jumpTo(0);
  }

  @override
  Widget build(BuildContext context) {
    final theme = SemanticTheme.of(context);

    List<Widget> listChildren = [];

    if (widget.button != null) {
      final paddedButton = Container(
        margin: EdgeInsets.only(
          top: theme?.distance.spacing.vertical.small ?? 0,
        ),
        child: widget.button,
      );
      listChildren.add(paddedButton);
    }

    listChildren.addAll(widget.children ?? []);

    return Container(
      alignment: Alignment.bottomCenter,
      padding: EdgeInsets.symmetric(
        horizontal: theme?.distance.padding.horizontal.small ?? 0,
      ),
      color: theme?.color.background.general ?? Colors.white,
      child: ListView(
        reverse: true,
        controller: _controller,
        padding: EdgeInsets.only(
          bottom: theme?.distance.padding.vertical.medium ?? 0,
        ),
        children: listChildren,
      ),
    );
  }
}
