import 'package:flutter/material.dart';
import 'package:semantic_theme/index.dart';
import 'package:x_small_icon_library/index.dart';

import 'nav_button.dart';

class SecondaryActionIconNavButton extends StatelessWidget with NavButton {
  final void Function() onTap;
  final XSmallIcon iconReference;

  @override
  Widget? buildIcon(BuildContext context) {
    return iconReference.buildWidget(
      color: SemanticTheme.of(context)?.color?.icon?.generalSecondary ?? Colors.transparent,
    );
  }

  SecondaryActionIconNavButton({
    required this.iconReference,
    required this.onTap,
  });
}
