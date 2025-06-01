import 'package:flutter/material.dart';
import 'package:labeled_value/index.dart';
import 'package:haptics/index.dart';
import 'package:semantic_theme/index.dart';

import '_components/roller_column_body.dart';

class RollerColumn<T> extends StatefulWidget {
  final LabeledValue<T>? selectedValue;
  final List<LabeledValue<T>>? list;
  final void Function(LabeledValue<T>)? onChange;
  final bool? infiniteScroll;
  final int? optionsVisible;
  final CrossAxisAlignment? crossAxisAlignment;

  RollerColumn({
    this.selectedValue,
    this.list,
    this.onChange,
    this.infiniteScroll,
    this.optionsVisible,
    this.crossAxisAlignment,
  });

  @override
  _RollerColumnState<T> createState() => _RollerColumnState<T>();
}

class _RollerColumnState<T> extends State<RollerColumn<T>> {
  final double _stepHeight = 40;
  final _delayBeforeSnap = Duration(milliseconds: 50);

  int? _stepsVisible;
  double? _boundaryOffset;
  ScrollController? _scrollController;
  bool? _infiniteScroll;
  LabeledValue<T>? _selectedValue;

  @override
  void initState() {
    _stepsVisible = widget.optionsVisible ?? 5;
    _boundaryOffset = _stepHeight * (_stepsVisible! - 1) / 2;

    _selectedValue = widget.selectedValue ?? widget.list?.first;

    if (widget.list?.length != null && widget.list!.length < (_stepsVisible ?? 0)) {
      _infiniteScroll = false;
    } else {
      _infiniteScroll = widget.infiniteScroll ?? true;
    }

    double? initialOffset = _stepHeight *
        (widget.list?.map((option) => option.value).toList().indexOf(_selectedValue?.value as T) ?? 0);

    if (_infiniteScroll == true) {
      initialOffset += _stepHeight * widget.list!.length - (_boundaryOffset ?? 0);
    }

    _scrollController = ScrollController(initialScrollOffset: initialOffset);

    super.initState();
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }

  void _handleRollover() {
    if (_infiniteScroll == false) return;

    final double segmentHeight = (widget.list?.length ?? 0) * _stepHeight;

    /*
    If _infiniteScroll == true, column is divided into three repeated segments. 
    To create perceived infinite scroll, adjust controller position to keep scroll window in the middle segment.
    */
    if (_scrollController?.offset != null && _scrollController!.offset > segmentHeight * 2)
      _scrollController!.position.correctBy(-segmentHeight);
    else if (_scrollController?.offset != null && _scrollController!.offset < segmentHeight)
      _scrollController!.position.correctBy(segmentHeight);
  }

  int _getNearestStepIndex() {
    for (int i = 0; i < (widget.list?.length ?? 0) * (_infiniteScroll == true ? 3 : 1); i++) {
      double stepCenter = _stepHeight * (i - .5);

      if (_infiniteScroll == true) stepCenter -= (_boundaryOffset ?? 0);

      final offsetFromStepCenter =
          (stepCenter - _scrollController!.offset).abs();

      if (offsetFromStepCenter < _stepHeight) return i;
    }
    return 0;
  }

  void _snapScroll() {
    if (_scrollController?.offset != null && _scrollController!.offset % _stepHeight == 0) return;

    final theme = SemanticTheme.of(context);

    Future.delayed(_delayBeforeSnap, () {
      double targetOffset = _getNearestStepIndex() * _stepHeight;

      if (_infiniteScroll == true) targetOffset -= (_boundaryOffset ?? 0);

      _scrollController?.animateTo(
        targetOffset,
        duration: theme?.duration.short ?? Duration.zero,
        curve: theme?.curve.hurried ?? Curves.linear,
      );
    });
  }

  void _onScroll() {
    LabeledValue<T> newValue =
        widget.list![_getNearestStepIndex() % (widget.list?.length ?? 0)];

    if (newValue != _selectedValue) {
      triggerHaptic(HapticOption.click);
      setState(() {
        _selectedValue = newValue;
      });
      widget.onChange?.call(_selectedValue!);
    }

    _handleRollover();
  }

  @override
  Widget build(BuildContext context) {
    final double verticalPadding = _infiniteScroll == true ? 0 : (_boundaryOffset ?? 0);

    return Container(
      height: (_stepsVisible ?? 0) * _stepHeight,
      child: NotificationListener<Notification>(
        onNotification: (scrollNotification) {
          switch (scrollNotification.runtimeType) {
            case ScrollEndNotification:
              _snapScroll();
              break;
            case ScrollUpdateNotification:
              _onScroll();
              break;
          }
          // TODO return false/null or true for `onNotification`?
          return false;
        },
        child: ListView(
          controller: _scrollController,
          padding: EdgeInsets.symmetric(
            vertical: verticalPadding,
          ),
          children: [
            // TODO convert to customScrollView using slivers instead of single RollerColumnBody
            RollerColumnBody(
              selectedValue: _selectedValue ?? LabeledValue(value: null, label: ''),
              children: widget.list!,
              segmentCount: _infiniteScroll == true ? 3 : 1,
              crossAxisAlignment: widget.crossAxisAlignment,
            )
          ],
        ),
      ),
    );
  }
}
