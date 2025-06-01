import 'package:flutter/material.dart';

import 'input_dock.dart';

mixin InputDockBuilder {
  InputDock buildInputDock(
    BuildContext context, {
    required Widget actionButton,
    required List<Widget> auxiliaryWidgets,
  }) {
    return InputDock(
      actionButton: actionButton,
      auxiliaryWidgets: auxiliaryWidgets,
    );
  }
}
