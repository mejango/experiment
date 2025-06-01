import 'package:flutter/material.dart';
import 'package:semantic_theme/index.dart';
import 'package:standard_icon_library/index.dart';
import 'package:haptics/index.dart';

class LoadMoreCell extends StatefulWidget {
  final VoidCallback? onTap;

  LoadMoreCell({this.onTap = null});

  @override
  _LoadMoreCellState createState() => _LoadMoreCellState();
}

class _LoadMoreCellState extends State<LoadMoreCell> {
  final _tapHapticOption = HapticOption.light;

  bool loading = false;

  _fireHaptic() {
    if (widget.onTap != null) triggerHaptic(_tapHapticOption);
  }

  _handleLoading() {
    // modify loading state based on tap or loading finished
    if (!loading) {
      setState(() {
        loading = true;
      });
    }
  }

  _onTap() {
    _handleLoading();
    widget.onTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    final theme = SemanticTheme.of(context);

    final loadMoreIcon = StandardIcon.loadMore.buildWidget(
      color: theme?.color?.icon?.generalPrimary ?? Colors.black,
    );

    final loadingIcon = CircularProgressIndicator();

    return GestureDetector(
      onTapDown: (details) => _fireHaptic(),
      onTap: _onTap,
      child: Container(
        margin: EdgeInsets.only(
          top: theme?.distance?.spacing?.vertical?.small ?? 0,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: theme?.distance?.padding?.horizontal?.medium ?? 0,
          vertical: theme?.distance?.padding?.vertical?.medium ?? 0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(theme?.radius?.medium ?? Radius.circular(0)),
          color: theme?.color?.background?.raised ?? Colors.white,
        ),
        child: Center(
          child: loading ? loadingIcon : loadMoreIcon,
        ),
      ),
    );
  }
}
