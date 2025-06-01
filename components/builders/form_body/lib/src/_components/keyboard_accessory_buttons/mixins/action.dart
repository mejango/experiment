import 'package:flutter/material.dart';
import 'package:haptics/index.dart';
import 'package:semantic_theme/index.dart';

mixin ActionKeyboardAccessoryButton implements StatelessWidget {
  String? get title;
  void Function()? get onTap;

  final _tapHapticOption = HapticOption.light;

  void _fireHaptic() {
    if (onTap != null) triggerHaptic(_tapHapticOption);
  }

  Widget buildButton({
    required BuildContext context,
    required void Function() onTap,
    required Widget child,
    Color? backgroundColor,
  }) {
    final theme = SemanticTheme.of(context);

    return Expanded(
      child: GestureDetector(
        onTapDown: (details) => _fireHaptic(),
        onTap: onTap,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: theme?.color.background.raised ?? Colors.white,
            boxShadow: [theme?.shadow.small ?? BoxShadow(color: Colors.black, blurRadius: 0)],
          ),
          child: Container(
            child: child,
            padding: EdgeInsets.symmetric(
              vertical: theme?.distance.padding.vertical.medium ?? 0,
            ),
            color: backgroundColor ?? theme?.color.background.general ?? Colors.white,
          ),
        ),
      ),
    );
  }
}
