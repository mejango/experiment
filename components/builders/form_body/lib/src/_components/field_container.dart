import 'package:flutter/material.dart';
import 'package:form_body_builder/src/_components/utils/min_field_height.dart';
import 'package:semantic_theme/index.dart';

class FieldContainer extends StatelessWidget {
  final Widget? child;

  FieldContainer({this.child});

  @override
  Widget build(BuildContext context) {
    final theme = SemanticTheme.of(context);

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: theme?.distance?.padding?.vertical?.min ?? 0,
        horizontal: theme?.distance?.padding?.horizontal?.medium ?? 0,
      ),
      constraints: BoxConstraints(
        minHeight: minFieldHeight,
      ),
      decoration: BoxDecoration(
        color: theme?.color?.background?.raised ?? Colors.white,
        borderRadius: BorderRadius.all(theme?.radius?.small ?? Radius.circular(0)),
      ),
      child: Center(child: child),  
    );
  }
}
