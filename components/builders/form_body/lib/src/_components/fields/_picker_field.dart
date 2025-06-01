import 'package:flutter/material.dart';
import 'package:haptics/index.dart';
import 'package:semantic_theme/index.dart';

import '_widgets/index.dart';

class PickerField extends StatelessWidget {
  final String? name;
  final Widget? fieldBody;
  final Function? onTap;

  PickerField({
    this.name,
    this.fieldBody,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = SemanticTheme.of(context);

    List<Widget> rowChildren = [];

    if (name != null) {
      final label = FieldLabel(labelText: name!);
      final spacer = Container(
        width: theme?.distance?.spacing?.horizontal?.small ?? 0,
      );
      rowChildren.addAll([label, spacer]);
    }

    final tapTarget = Expanded(
      child: GestureDetector(
        child: Container(
          alignment: Alignment(1, 0),
          child: fieldBody,
        ),
        onTap: onTap as GestureTapCallback?,
        onTapDown: (details) => triggerHaptic(HapticOption.light),
        behavior: HitTestBehavior.opaque,
      ),
    );

    rowChildren.add(tapTarget);

    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: rowChildren,
      ),
    );
  }
}
