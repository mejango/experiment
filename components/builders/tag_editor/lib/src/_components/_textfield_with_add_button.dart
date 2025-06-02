import 'package:flutter/material.dart';
import 'package:semantic_theme/index.dart';

class TextFieldWithAddButton extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String) addTagCallback;
  final List<String>? options;

  TextFieldWithAddButton({
    required this.controller,
    required this.addTagCallback,
    this.options,
  });

  @override
  Widget build(BuildContext context) {
    final theme = SemanticTheme.of(context);

    final List<Widget> fieldRowChildren = [];

    final decoration = InputDecoration(
      hintText: "big house",
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
      ),
      hintStyle: theme?.typography?.body?.textStyle(
        color: theme.color?.text?.inputPlaceholder ?? Colors.black,
      ),
    );

    final textField = Expanded(
      child: Container(
        child: TextField(
          autofocus: true,
          controller: controller,
          style: theme?.typography?.body?.textStyle(
            color: theme.color?.text?.inputActive ?? Colors.black,
          ),
          decoration: decoration,
        ),
      ),
    );

    fieldRowChildren.add(textField);

    if (controller.text.isNotEmpty) {
      bool canCreateTag = options?.map((option) => option.toLowerCase())
          .contains(controller.text.toLowerCase()) ?? false;

      final Widget addButton = GestureDetector(
        onTap: canCreateTag ? () => addTagCallback(controller.text) : null,
        child: Container(
          padding: EdgeInsets.only(
            left: theme?.distance?.padding?.horizontal?.medium ?? 0,
            top: theme?.distance?.padding?.vertical?.small ?? 0,
            bottom: theme?.distance?.padding?.vertical?.small ?? 0,
          ),
          child: Text(
            "Create tag",
            style: theme?.typography?.button?.textStyle(
              color: canCreateTag
                  ? theme.color?.text?.action ?? Colors.black
                  : theme.color?.text?.actionDisabled ?? Colors.black,
            ),
          ),
        ),
      );

      fieldRowChildren.add(addButton);
    }

    return Container(
      padding: EdgeInsets.only(
        bottom: theme?.distance?.padding?.vertical?.small ?? 0,
      ),
      margin: EdgeInsets.symmetric(
        vertical: theme?.distance?.spacing?.horizontal?.small ?? 0,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: theme?.color?.stroke?.medium ?? Colors.black),
        ),
      ),
      child: Row(
        children: fieldRowChildren,
      ),
    );
  }
}
