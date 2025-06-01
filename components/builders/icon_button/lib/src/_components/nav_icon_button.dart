import 'package:flutter/material.dart';
import 'package:navigation_icon_library/index.dart';
import 'package:semantic_theme/index.dart';

import 'standard_icon_button.dart';

class NavIconButton extends StatelessWidget with StandardIconButton {
  final void Function() onTap;
  final NavigationIcon iconReference;

  @override
  Widget buildIcon(BuildContext context) {
    return iconReference.buildWidget(
      color: SemanticTheme.of(context)?.color.icon.nav ?? Colors.transparent,
    );
  }

  NavIconButton({
    required this.iconReference,
    required this.onTap,
  });
}
