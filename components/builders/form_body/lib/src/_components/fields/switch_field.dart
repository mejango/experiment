import 'package:flutter/material.dart';
import 'package:form_body_builder/src/_components/fields/_widgets/index.dart';
import 'package:haptics/index.dart';
import 'package:semantic_theme/index.dart';

class SwitchField extends StatefulWidget {
  final String? title;
  final bool initialValue;
  final int? labelMaxLines;
  final Function(bool)? onChanged;

  const SwitchField({
    this.title,
    this.initialValue = false,
    this.labelMaxLines = 3,
    this.onChanged,
  });

  @override
  _SwitchFieldState createState() => _SwitchFieldState();
}

class _SwitchFieldState extends State<SwitchField>
    with SingleTickerProviderStateMixin {
   late bool isOn;
   late Animation<Color?> animation;
   late int labelMaxLines;
   late AnimationController controller;
   late Color isOnColor;
   late Color isOffColor;

  initState() {
    isOn = widget.initialValue;
    super.initState();
    controller = AnimationController(
      duration: Duration.zero, // Will update in didChangeDependencies
      vsync: this,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final theme = SemanticTheme.of(context);

    // Update duration if needed
    controller.duration = theme?.duration?.short ?? Duration.zero;

    isOnColor = theme?.color?.background?.actionPrimary ?? Colors.white;
    isOffColor = theme?.color?.background?.actionDisabled ?? Colors.white;

    animation = ColorTween(
      begin: isOffColor,
      end: isOnColor,
    )
        .chain(
          CurveTween(
            curve: theme?.curve?.hurried ?? Curves.linear,
          ),
        )
        .animate(controller)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final labelContainer = Expanded(
      child: FieldLabel(labelText: widget.title ?? ""),
    );

    final switchColor = animation.value;
    final switchButton = _AnimatedSwitch(isOn: isOn, color: switchColor!);

    return GestureDetector(
      onTap: () => hapticAction(
        HapticOption.light,
        action: _setIsOn,
      ),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [labelContainer, switchButton],
        ),
      ),
    );
  }

  void _setIsOn() {
    setState(() {
      isOn = !isOn;
      isOn ? controller.forward() : controller.reverse();
    });
    widget.onChanged?.call(isOn);
  }
}

class _AnimatedSwitch extends StatelessWidget {
  final bool isOn;
  final Color color;

  final double _width = 50;
  final double _height = 28;
  final double _innerSpacing = 4.0;

  double get _radius => _height * 0.5;
  double get _animatedContainerWidth =>
      _height - _innerSpacing * 2 - 2; // subtract 2 for border width * 2
  double get _animatedContainerRadius => _animatedContainerWidth * 0.5;

  _AnimatedSwitch({required this.isOn, required this.color});

  @override
  Widget build(BuildContext context) {
    final theme = SemanticTheme.of(context);

    return Container(
      width: _width,
      height: _height,
      margin: EdgeInsets.only(
        left: theme?.distance?.spacing?.horizontal?.medium ?? 0,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: color),
        borderRadius: BorderRadius.all(Radius.circular(_radius)),
      ),
      child: Padding(
        padding: EdgeInsets.all(_innerSpacing),
        child: AnimatedAlign(
          child: Container(
            width: _animatedContainerWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(_animatedContainerRadius),
              ),
              color: color,
            ),
          ),
          alignment: isOn ? Alignment(1.0, 0.0) : Alignment(-1.0, 0.0),
          curve: theme?.curve?.hurried ?? Curves.linear,
          duration: theme?.duration?.short ?? Duration.zero,
        ),
      ),
    );
  }
}
