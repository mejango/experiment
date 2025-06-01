import 'package:flutter/material.dart';
import 'package:form_body_builder/src/_components/fields/_widgets/index.dart';
import 'package:haptics/index.dart';
import 'package:semantic_theme/index.dart';
import 'package:tag_builder/index.dart';
import 'package:x_small_icon_library/index.dart';

class MetaFormField extends StatelessWidget with TagBuilder {
  final String? title;
  final List<String>? displayValues;
  final Function? onTap;

  MetaFormField({
    required this.title,
    this.displayValues,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = SemanticTheme.of(context);

    final List<Widget> columnChildren = [];

    final label = Padding(
      padding: EdgeInsets.only(
        right: theme?.distance?.spacing?.horizontal?.small ?? 0,
      ),
      child: FieldLabel(labelText: title!),
    );

    if (displayValues?.isNotEmpty ?? false) {
      final texts = displayValues
          ?.map(
            (value) => Text(
              value,
              style: theme?.typography?.body?.textStyle(
                color: theme.color?.text?.inputActive ?? Colors.black,
              ),
              textAlign: TextAlign.right,
            ),
          )
          .toList();
      columnChildren.addAll(texts ?? []);
    } else {
      final emptyText = Text(
        'Not set',
        style: theme?.typography?.body?.textStyle(
          color: theme.color?.text?.inputPlaceholder ?? Colors.black,
        ),
        textAlign: TextAlign.right,
      );
      columnChildren.add(emptyText);
    }

    final rightArrow = Padding(
      padding: EdgeInsets.only(
        left: theme?.distance?.spacing?.horizontal?.small ?? 0,
      ),
      child: XSmallIcon.rightArrow.buildWidget(
        color: theme?.color?.icon?.generalSecondary ?? Colors.black,
      ),
    );

    final fieldBody = Container(
      child: Row(
        children: [
          label,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: columnChildren,
            ),
          ),
          rightArrow,
        ],
      ),
    );

    return GestureDetector(
      onTap: () => hapticAction(
        HapticOption.light,
        action: onTap as VoidCallback?,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: theme?.distance?.padding?.vertical?.small ?? 0,
        ),
        child: fieldBody,
      ),
    );
  }
}
