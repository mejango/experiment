import 'package:flutter/material.dart';
import 'package:navigation_icon_library/index.dart';
import 'package:semantic_theme/index.dart';

import 'nav_button.dart';

class PrimaryActionIconNavButton extends StatelessWidget with NavButton {
  final void Function() onTap;
  final NavigationIcon iconReference;

  @override
  Widget? buildIcon(BuildContext context) {
    return iconReference.buildWidget(
      color: SemanticTheme.of(context)?.color?.icon?.action ?? Colors.transparent,
    );
  }

  PrimaryActionIconNavButton({
    required this.iconReference,
    required this.onTap,
  });
}
