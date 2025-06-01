import 'package:flutter/material.dart';
import 'package:form_body_builder/src/_components/fields/_picker_field.dart';
import 'package:semantic_theme/index.dart';
import 'package:tag_builder/index.dart';

class TagField extends StatelessWidget with TagBuilder {
  final String? title;
  final String? placeholder;
  final List<String>? tags;
  final Function? onTap;

  TagField({
    required this.title,
    required this.placeholder,
    this.tags,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = SemanticTheme.of(context);

    Widget fieldBody;

    if (tags != null && tags!.isNotEmpty) {
      final List<Widget> tagWidgets = tags?.map(
                (tag) => buildTag(
                  context,
                  text: tag,
                ),
              )
              .toList() ?? [];

      fieldBody = Padding(
        padding: EdgeInsets.symmetric(
          vertical: theme?.distance.padding.vertical.min ?? 0,
        ),
        child: Wrap(
          children: tagWidgets,
          spacing: theme?.distance.spacing.horizontal.min ?? 0,
          runSpacing: theme?.distance.spacing.vertical.min ?? 0,
          alignment: WrapAlignment.end,
        ),
      );
    } else {
      fieldBody = Text(
        placeholder ?? "",
        style: theme?.typography.body.textStyle(
          color: theme.color.text.inputPlaceholder,
        ),
      );
    }

    return PickerField(
      name: title,
      onTap: onTap,
      fieldBody: fieldBody,
    );
  }
}
