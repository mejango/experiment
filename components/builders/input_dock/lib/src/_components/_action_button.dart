import 'package:flutter/material.dart';
import 'package:semantic_theme/index.dart';
import 'package:standard_icon_library/index.dart';
import 'package:haptics/index.dart';

import '../input_dock.dart';

class DockActionButton extends StatefulWidget {
  final Function action;
  final String actionTitle;
  final StandardIcon actionIconReference;

  DockActionButton({
    required this.action,
    required this.actionTitle,
    required this.actionIconReference,
  });

  _DockActionButtonState createState() => _DockActionButtonState();
}

class _DockActionButtonState extends State<DockActionButton>
    with TickerProviderStateMixin {
  final GlobalKey _buttonKey = GlobalKey();
  final GlobalKey _buttonIconKey = GlobalKey();
  final _tapHapticOption = HapticOption.light;

  double minWidthToShowText = 0;
  late double maxButtonWidth;
  late double buttonIconWidth;
  late Animation<double>? widthAnimation;
  late Animation<double>? opacityAnimation;
  late AnimationController widthAnimationController;
  late AnimationController opacityAnimationController;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(_buildButtonAnimation);

    final theme = SemanticTheme.of(context);

    widthAnimationController = AnimationController(
      duration: theme?.duration?.short ?? Duration.zero,
      vsync: this,
    );
    opacityAnimationController = AnimationController(
      duration: theme?.duration?.short ?? Duration.zero,
      vsync: this,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dock = InputDock.of(context);
    final theme = SemanticTheme.of(context);

    dock?.showSubmitButton == true ? _animateForward() : _animateReverse();

    final buttonDecoration = BoxDecoration(
      border: Border.all(color: theme?.color?.stroke?.actionSecondary ?? Colors.transparent),
      borderRadius: BorderRadius.all(theme?.radius?.medium ?? Radius.zero),
    );

    final animatedWidth = widthAnimation?.value ?? null;
    final showText =
        animatedWidth == null || animatedWidth >= minWidthToShowText;

    final containerPadding = showText
        ? EdgeInsets.symmetric(
            horizontal: theme?.distance?.padding?.horizontal?.small ?? 0,
          )
        : null;

    final buttonChildren = <Widget>[];

    final buttonIcon = Container(
      key: _buttonIconKey,
      child: widget.actionIconReference.buildWidget(
        color: theme?.color?.icon?.action ?? Colors.transparent,
      ),
    );

    final buttonText = _ButtonText(
      text: widget.actionTitle,
      show: showText,
      opacity: opacityAnimation?.value ?? 1,
    );

    buttonChildren.add(buttonIcon);
    buttonChildren.add(buttonText);

    return GestureDetector(
      onTapDown: (details) => triggerHaptic(_tapHapticOption),
      onTap: _onTap,
      child: Container(
        key: _buttonKey,
        width: animatedWidth ?? null,
        height: dock?.baseHeight ?? 0,
        padding: containerPadding,
        decoration: buttonDecoration,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: buttonChildren,
        ),
      ),
    );
  }

  void _animateForward() {
    widthAnimationController.forward();
    opacityAnimationController.forward();
  }

  void _animateReverse() {
    widthAnimationController.reverse();
    opacityAnimationController.reverse();
  }

  void _onTap() {
    showDialog(
      builder: (context) => AlertDialog(
        title: Text(
          widget.actionTitle,
        ),
      ),
      context: context,
    );
    widget.action();
  }

  void _buildButtonAnimation(_) {
    _calculateComponentSizes();
    _buildAnimationFromMaxButtonWidth(maxButtonWidth);
  }

  void _calculateComponentSizes() {
    if (_buttonKey.currentContext == null) return;

    final RenderBox actionButtonRenderBox =
        _buttonKey.currentContext?.findRenderObject() as RenderBox;
    final RenderBox actionButtonIconRenderBox =
        _buttonIconKey.currentContext?.findRenderObject() as RenderBox;

    maxButtonWidth = actionButtonRenderBox.size.width;
    buttonIconWidth = actionButtonIconRenderBox.size.width;

    // minWidthToShowText ensures button children don't overflow while button is collapsing by removing the text precisely before overflow would occur. Value should be at least equal to ((width of the button icon) + (button x-axis containerPadding) + (borderWidth * 2))
    minWidthToShowText = buttonIconWidth +
        (SemanticTheme.of(context)?.distance?.padding?.horizontal?.small ?? 0 * 2) +
        2;
  }

  void _buildAnimationFromMaxButtonWidth(double maxButtonWidth) {
    final dock = InputDock.of(context);
    final theme = SemanticTheme.of(context);

    final double minButtonWidth = dock?.baseHeight ?? 0;

    final widthCurve = CurvedAnimation(
      parent: widthAnimationController,
      curve: theme?.curve?.hurried ?? Curves.linear,
      reverseCurve: theme?.curve?.hurried?.flipped ?? Curves.linear,
    );

    final opacityCurve = CurvedAnimation(
      parent: opacityAnimationController,
      curve: theme?.curve?.normal ?? Curves.linear,
      reverseCurve: theme?.curve?.normal?.flipped ?? Curves.linear,
    );

    widthAnimation = Tween(
      begin: maxButtonWidth,
      end: minButtonWidth,
    ).animate(widthCurve)
      ..addListener(() {
        setState(() {});
      });

    opacityAnimation = Tween(
      begin: 1.0,
      end: 0.0,
    ).animate(opacityCurve)
      ..addListener(() {
        setState(() {});
      });
  }
}

class _ButtonText extends StatelessWidget {
  final String? text;
  final bool? show;
  final double? opacity;

  _ButtonText({
    this.text,
    this.show,
    this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    final theme = SemanticTheme.of(context);

    return Flexible(
      child: Container(
        width: show == true ? null : 0,
        padding: EdgeInsets.only(
          left: theme?.distance?.padding?.horizontal?.small ?? 0,
        ),
        child: Opacity(
          opacity: opacity ?? 1,
          child: Text(
            text ?? '',
            softWrap: false,
            overflow: TextOverflow.fade,
            style: theme?.typography?.button?.textStyle(
              color: theme.color?.text?.action ?? Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
