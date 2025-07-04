import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:semantic_theme/index.dart';
import 'package:vertical_drawer_artboard_scaffold/index.dart';
import 'package:vertical_floating_artboard_scaffold/index.dart';
import 'package:horizontal_floating_artboard_scaffold/index.dart';
import 'package:artboard/index.dart';
import 'package:navigator/index.dart';
import 'package:keyboard_accessory/index.dart';

import 'routing.dart';

class VerticalFullScreenArtboardNavigator extends StatefulWidget {
  final Artboard artboard;

  VerticalFullScreenArtboardNavigator({required this.artboard});

  @override
  State<StatefulWidget> createState() =>
      VerticalFullScreenInheritedArtboardNavigator();

  static VerticalFullScreenInheritedArtboardNavigator? of(
    BuildContext context, {
    bool shouldRebuild = true,
  }) {
    print("of: $shouldRebuild");
    final inheritedWidget = shouldRebuild
        ? context.dependOnInheritedWidgetOfExactType<
            _VerticalFullScreenInheritedArtboardNavigator>()
        : context.findAncestorWidgetOfExactType<
            _VerticalFullScreenInheritedArtboardNavigator>();

    return inheritedWidget?.data;
  }
}

class VerticalFullScreenInheritedArtboardNavigator
    extends State<VerticalFullScreenArtboardNavigator> {
  final _popMinDragDistanceDelta = 30;
  final _popMaxDragTimeDelta = 60;

  int? _initialDragTime;
  double? _initialDragDy;
  int? _timeDelta;
  double? _downDistanceDelta;

  // Must drag _popMinDragDistanceDelta in less time than _popMaxDragTimeDelta to pop
  get _shouldPop =>
      _timeDelta != null &&
      _downDistanceDelta != null &&
      _timeDelta! < _popMaxDragTimeDelta &&
      _downDistanceDelta! > _popMinDragDistanceDelta;

  Widget build(BuildContext context) {
    print("building theeee navigator");
    final swipablePage = GestureDetector(
      onHorizontalDragStart: _onHorizontalDragStart,
      onHorizontalDragUpdate: (details) {
        if (!Platform.isIOS || details.primaryDelta == null || details.primaryDelta! < 0) return;
        _onDragRightUpdate(details);
        if (_shouldPop) Navigator.maybePop(context);
      },
      behavior: HitTestBehavior.translucent,
      child: widget.artboard,
    );

    final navigator = ArtboardNavigator(
      child: swipablePage,
      goTo: _goTo,
      pop: _pop,
    );

    return _VerticalFullScreenInheritedArtboardNavigator(
      data: this,
      child: KeyboardAccessory(child: navigator),
    );
  }

  void _onHorizontalDragStart(DragStartDetails details) {
    _initialDragTime = details.sourceTimeStamp?.inMilliseconds;
    _initialDragDy = details.globalPosition.dx;
  }

  void _onDragRightUpdate(DragUpdateDetails details) {
    _timeDelta = (details.sourceTimeStamp?.inMilliseconds ?? 0) - (_initialDragTime ?? 0);
    _downDistanceDelta = details.globalPosition.dx - (_initialDragDy ?? 0);
  }

  Future<T> _goTo<T>(
    Artboard artboard, {
    required BuildContext context,
  }) async {

    final theme = SemanticTheme.of(context);
    if (theme == null) throw Exception('Theme cannot be null');

    if (artboard is VerticalFloatingArtboard) {
      final floatingNavigator = VerticalFloatingArtboardNavigator(
        artboard: artboard,
      );

      final result = await Navigator.of(context).push<dynamic>(
        VerticalFloatingRoute(
          builder: (context) => floatingNavigator,
          theme: theme,
        ),
      );

      if (result is Artboard) {
        return await _goTo<T>(
          result,
          context: context,
        );
      } else if (result is T) {
        return result;
      }

      return Future.value();
    } else if (artboard is VerticalDrawerArtboard) {
      final drawerNavigator = VerticalDrawerArtboardNavigator(
        artboard: artboard,
      );

      final result = await Navigator.of(context).push<dynamic>(
        VerticalDrawerRoute(
          builder: (context) => drawerNavigator,
          theme: theme,
        ),
      );

      if (result is Artboard) {
        return await _goTo<T>(
          result,
          context: context,
        );
      } else if (result is T) {
        return result;
      }

      return Future.value();
    } else if (artboard is HorizontalFloatingArtboard) {
      final floatingNavigator = HorizontalFloatingArtboardNavigator(
        artboard: artboard,
      );

      final theme = SemanticTheme.of(context);
      if (theme == null) throw Exception('Theme cannot be null');
      final result = await Navigator.of(context).push<dynamic>(
        HorizontalFloatingRoute(
          builder: (context) => floatingNavigator,
          theme: theme,
        ),
      );

      if (result is Artboard) {
        return await _goTo<T>(
          result,
          context: context,
        );
      } else if (result is T) {
        return result;
      }

      return Future.value();
    } else {
      final theme = SemanticTheme.of(context);
      if (theme == null) throw Exception('Theme cannot be null');
      final result = await Navigator.of(context).push<T>(
        VerticalFullScreenRoute(
          builder: (context) {
            return VerticalFullScreenArtboardNavigator(
              artboard: artboard,
            );
          },
          theme: theme,
        ),
      );
      if (result == null) throw Exception('Navigation result cannot be null');
      return result;
    }
  }

  bool _pop<T>([T? result]) {
    Navigator.pop(context, result);
    return true;
  }
}

class _VerticalFullScreenInheritedArtboardNavigator extends InheritedWidget {
  final VerticalFullScreenInheritedArtboardNavigator data;

  _VerticalFullScreenInheritedArtboardNavigator({
    required this.data,
    required Widget child,
  }) : super(child: child);

  @override
  bool updateShouldNotify(_VerticalFullScreenInheritedArtboardNavigator old) =>
      false;
}
