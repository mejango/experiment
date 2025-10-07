import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:semantic_theme/index.dart';

import '_widgets/nav_title_baseline.dart';

class AnimatedTitleNavBar extends StatefulWidget {
  final ScrollController scrollController;
  final List<Widget>? actionButtons;
  final Widget? navButton;
  final String? title;
  final bool? hideOnScroll;

  AnimatedTitleNavBar({
    required this.scrollController,
    this.actionButtons,
    this.navButton,
    this.title,
    this.hideOnScroll,
  });

  @override
  _AnimatedTitleNavBarState createState() => _AnimatedTitleNavBarState();
}

class _AnimatedTitleNavBarState extends State<AnimatedTitleNavBar> {
  final _containerKey = GlobalKey();

  // titleCanShow pattern prevents titleVisible being set to true while scrollPosition is near 0, and scroll direction is up. This is intended to allow adequate scroll distance for the navBar to hide on initial scroll-up before title becomes visible.
  bool _transitionCanStart = true;
  bool _titleVisible = true;
  double _transitionValue = 0;
  double? _containerHeight;

  double get _transitionOffset => (_containerHeight ?? 0) * 1.5;

  @override
  void initState() {
    if (widget.hideOnScroll == true) {
      _transitionCanStart = false;
      _titleVisible = false;
      widget.scrollController.addListener(() => _onScroll());
    }

    SchedulerBinding.instance.addPostFrameCallback(
      (_) => _setContainerHeight(),
    );
    super.initState();
  }

  void _onScroll() {
    double? newTransitionValue;
    bool? newTitleVisible;
    bool? newTransitionCanStart;

    final scrollPosition = widget.scrollController.offset;

    if (scrollPosition >= _transitionOffset) {
      newTransitionCanStart = true;
    } else if (scrollPosition <= 0) {
      newTransitionCanStart = false;
    }

    if (scrollPosition >= _transitionOffset) {
      newTransitionValue = 1;
    } else if (scrollPosition <= 0) {
      newTransitionValue = 0;
    } else if (_transitionCanStart == true) {
      newTransitionValue = scrollPosition / _transitionOffset;
    }

    if (scrollPosition < (_containerHeight ?? 0))
      newTitleVisible = false;
    else if (_transitionCanStart) newTitleVisible = true;

    if (newTransitionValue == null &&
        newTransitionCanStart == null &&
        newTitleVisible == null &&
        newTransitionValue == _transitionValue &&
        newTransitionCanStart == _transitionCanStart &&
        newTitleVisible == _titleVisible) return;

    setState(() {
      if (newTransitionValue != _transitionValue &&
          newTransitionValue != null) {
        _transitionValue = newTransitionValue;
      }
      if (newTransitionCanStart != _transitionCanStart &&
          newTransitionCanStart != null) {
        _transitionCanStart = newTransitionCanStart;
      }
      if (newTitleVisible != _titleVisible && newTitleVisible != null) {
        _titleVisible = newTitleVisible;
      }
    });
  }

  void _setContainerHeight() {
    final containerContext = _containerKey.currentContext;

    if (containerContext == null) return;

    setState(() {
      _containerHeight = containerContext.size?.height ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = SemanticTheme.of(context);

    final List<Widget> rowChildren = [];

    if (widget.navButton != null) {
      final spacedNavButton = Padding(
        padding: EdgeInsets.only(right: theme?.distance?.spacing?.horizontal?.min ?? 0),
        child: widget.navButton,
      );

      rowChildren.add(spacedNavButton);
    }

    if (widget.title != null) {
      final opacityTitle = AnimatedOpacity(
        opacity: _titleVisible ? 1 : 0,
        curve: theme?.curve?.normal ?? Curves.easeInOut,
        duration: theme?.duration?.medium ?? Duration(milliseconds: 300),
        child: NavTitleBaseline(
          text: Text(
            widget.title ?? '',
            style: theme?.typography?.title?.textStyle(
              color: theme.color?.text?.generalPrimary ?? Colors.black,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          baseline: theme?.typography?.title?.fontSize ?? 0,
        ),
      );

      rowChildren.add(
        Expanded(child: opacityTitle),
      );
    } else {
      rowChildren.add(Expanded(
        child: Container(),
      ));
    }

    if (widget.actionButtons != null) {
      final spacedActionButtons = widget.actionButtons
          ?.map(
            (button) => Padding(
              child: button,
              padding: EdgeInsets.only(
                left: theme?.distance?.spacing?.horizontal?.min ?? 0,
              ),
            ),
          )
          .toList();

      rowChildren.add(
        Row(children: spacedActionButtons ?? []),
      );
    }

    final itemRow = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: rowChildren),
      ],
    );

    final safeAreaTop = MediaQuery.of(context).padding.top;

    final shadow = theme?.shadow?.appBar;

    List<BoxShadow>? opacityAdjustedShadow;
    if (shadow != null) {
      opacityAdjustedShadow = [
        BoxShadow(
          color:
              shadow.color.withAlpha((shadow.color.a * _transitionValue).toInt()),
          blurRadius: shadow.blurRadius,
          spreadRadius: shadow.spreadRadius,
          offset: shadow.offset,
        )
      ];
    }

    return Container(
      key: _containerKey,
      padding: EdgeInsets.fromLTRB(
        theme?.distance?.gutter?.horizontal?.small ?? 0,
        (theme?.distance?.gutter?.vertical?.small ?? 0) + safeAreaTop,
        theme?.distance?.gutter?.horizontal?.small ?? 0,
        theme?.distance?.gutter?.vertical?.small ?? 0,
      ),
      decoration: BoxDecoration(
        color: theme?.color?.background?.general ?? Colors.white,
        boxShadow: opacityAdjustedShadow,
      ),
      child: itemRow,
    );
  }
}
