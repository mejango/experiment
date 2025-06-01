import 'package:flutter/material.dart';
import 'package:semantic_theme/index.dart';
import 'package:standard_icon_library/index.dart';
import 'package:haptics/index.dart';

class SegueBar extends StatelessWidget {
  final String? title;
  final StandardIcon? iconReference;
  final String? auxiliaryText;
  final VoidCallback? onTap;

  SegueBar({
    this.title,
    this.iconReference,
    this.auxiliaryText,
    this.onTap,
  });

  final _tapHapticOption = HapticOption.light;

  void _fireHaptic() {
    if (onTap != null) triggerHaptic(_tapHapticOption);
  }

  @override
  Widget build(BuildContext context) {
    final theme = SemanticTheme.of(context);

    final iconWidget = iconReference?.buildWidget(
      color: theme?.color?.icon?.nav ?? Colors.black,
    );

    final titleTextStyle = theme?.typography?.bodyHeavy?.textStyle(
      color: theme.color?.text?.generalPrimary ?? Colors.black,
    );

    final paddedTitleWidget = Expanded(
      child: Padding(
        padding: EdgeInsets.only(
          left: theme?.distance?.padding?.horizontal?.small ?? 0,
        ),
        child: Text(title ?? "", style: titleTextStyle),
      ),
    );

    List<Widget> rowChildren = [
      iconWidget ?? SizedBox.shrink(),
      paddedTitleWidget,
    ];

    if (auxiliaryText != null) {
      final auxiliaryTextWidget = _AuxiliaryTextWidget(
        text: auxiliaryText ?? "",
        leftMargin: theme?.distance?.spacing?.horizontal?.small ?? 0,
      );

      rowChildren.add(auxiliaryTextWidget);
    }

    return GestureDetector(
      onTapDown: (details) => _fireHaptic(),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: theme?.distance?.padding?.horizontal?.small ?? 0,
          vertical: theme?.distance?.padding?.vertical?.small ?? 0,
        ),
        child: Row(
          children: rowChildren,
        ),
      ),
    );
  }
}

class _AuxiliaryTextWidget extends StatelessWidget {
  final String? text;
  final double? leftMargin;

  _AuxiliaryTextWidget({
    this.text,
    this.leftMargin,
  });

  final double _height = 40;

  @override
  Widget build(BuildContext context) {
    final theme = SemanticTheme.of(context);

    final double borderRadius = _height / 2;

    final textWidget = Text(
      text ?? "",
      style: theme?.typography?.bodyHeavy?.textStyle(
        color: theme.color?.text?.action ?? Colors.black,
      ),
    );

    return Container(
      height: _height,
      margin: EdgeInsets.only(left: leftMargin ?? 0),
      padding: EdgeInsets.symmetric(
        horizontal: theme?.distance?.padding?.horizontal?.small ?? 0,
      ),
      decoration: BoxDecoration(
        color: theme?.color?.background?.raised ?? Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(borderRadius),
        ),
      ),
      child: Center(
        child: textWidget,
      ),
    );
  }
}
