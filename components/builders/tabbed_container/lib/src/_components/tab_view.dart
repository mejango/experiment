import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tab/index.dart';
import 'package:input_dock_builder/index.dart';

class StandardTabView extends StatefulWidget {
  const StandardTabView({
    required this.tabs,
    required this.controller,
  });

  final TabController controller;
  final List<RoofTab> tabs;

  @override
  _StandardTabViewState createState() => _StandardTabViewState();
}

class _StandardTabViewState extends State<StandardTabView> with InputDockBuilder {
  TabController? _controller;
  PageController? _pageController;
  List<Widget>? _children;
  int? _currentIndex;
  int _warpUnderwayCount = 0;

  List<Widget> _buildTabViews() {
    final List<Widget> views = [];

    for (final RoofTab tab in widget.tabs) {
      if (tab.dockData != null) {
        final tabView = Expanded(
          child: tab.view ?? const SizedBox.shrink(),
        );

        final inputDock = buildInputDock(
          context,
          auxiliaryWidgets: tab.dockData?.auxiliaryWidgets ?? [],
          actionButton: tab.dockData?.actionButton ?? const SizedBox.shrink(),
        );

        final view = Column(
          children: <Widget>[
            tabView,
            inputDock,
          ],
        );
        views.add(view);
      } else {
        views.add(tab.view ?? const SizedBox.shrink());
      }
    }
    return views;
  }

  void _updateTabController() {
    _controller = widget.controller;
    _controller?.animation?.addListener(_handleTabControllerAnimationTick);
  }

  @override
  void initState() {
    super.initState();
    _children = _buildTabViews();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateTabController();
    _currentIndex = _controller?.index;
    _pageController = PageController(initialPage: _currentIndex ?? 0);
  }

  @override
  void dispose() {
    _controller?.animation?.removeListener(_handleTabControllerAnimationTick);
    super.dispose();
  }

  void _handleTabControllerAnimationTick() {
    if (_warpUnderwayCount > 0 || !(_controller?.indexIsChanging ?? false)) return;

    if (_controller?.index != _currentIndex) {
      _currentIndex = _controller?.index;
      _warpToCurrentIndex();
    }
  }

  Future<void> _warpToCurrentIndex() async {
    if (!mounted) return Future<void>.value();

    if (_pageController?.page == _currentIndex?.toDouble())
      return Future<void>.value();

    final int previousIndex = _controller?.previousIndex ?? 0;
    if (((_currentIndex ?? 0) - previousIndex).abs() == 1)
      return _pageController?.animateToPage(_currentIndex ?? 0,
          duration: kTabScrollDuration, curve: Curves.ease);

    assert(((_currentIndex ?? 0) - previousIndex).abs() > 1);
    int? initialPage;
    setState(() {
      _warpUnderwayCount += 1;
      _children = List<Widget>.from(_buildTabViews(), growable: false);
      if (_currentIndex != null && (_currentIndex ?? 0) > previousIndex) {
        _children?[_currentIndex! - 1] = _children![previousIndex];
        initialPage = _currentIndex! - 1;
      } else {
        _children?[_currentIndex! + 1] = _children![previousIndex];
        initialPage = _currentIndex! + 1;
      }
    });

    _pageController?.jumpToPage(initialPage ?? 0);

    await _pageController?.animateToPage(_currentIndex ?? 0,
        duration: kTabScrollDuration, curve: Curves.ease);
    if (!mounted) return Future<void>.value();

    setState(() {
      _warpUnderwayCount -= 1;
      _children = _buildTabViews();
    });
  }

  // Called when the PageView scrolls
  bool _handleScrollNotification(ScrollNotification notification) {
    if (_warpUnderwayCount > 0) return false;

    if (notification.depth != 0) return false;

    _warpUnderwayCount += 1;
    if (notification is ScrollUpdateNotification &&
        !(_controller?.indexIsChanging ?? false)) {
      if ((_pageController?.page ?? 0 - (_controller?.index ?? 0)).abs() > 1.0) {
        _controller?.index = (_pageController?.page ?? 0).floor();
        _currentIndex = _controller?.index;
      }
      _controller?.offset =
          (_pageController?.page ?? 0 - (_controller?.index ?? 0)).clamp(-1.0, 1.0).toDouble();
    } else if (notification is ScrollEndNotification) {
      _controller?.index = (_pageController?.page ?? 0).round();
      _currentIndex = _controller?.index;
    }
    _warpUnderwayCount -= 1;

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: PageView(
        dragStartBehavior: DragStartBehavior.start,
        controller: _pageController,
        physics: ScrollPhysics(),
        children: _children ?? [],
      ),
    );
  }
}
