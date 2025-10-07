import 'package:flutter/material.dart';
import 'package:semantic_theme/index.dart';

import '_widgets/index.dart';

class TextArea extends StatelessWidget {
  final String? fieldName;
  final String? placeholder;
  final String? initialValue;
  final bool? autofocus;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Function(String)? onChanged;
  final Function(String, BuildContext)? onSubmitted;
  final Function(bool)? onFocusChanged;
  final Function? onTap;
  final FocusNode? focusNode;

  TextArea({
    this.fieldName,
    this.placeholder,
    this.initialValue,
    this.autofocus = false,
    this.textInputAction,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.onSubmitted,
    this.onFocusChanged,
    this.onTap,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> fieldChildren = [];

    if (fieldName != null) {
      fieldChildren.add(
        FieldLabel(labelText: fieldName!),
      );
    }

    final body = _FieldBody(
      autofocus: autofocus,
      initialValue: initialValue,
      placeholder: placeholder,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      onSubmitted: onSubmitted,
      onFocusChanged: onFocusChanged,
      onChanged: onChanged,
      onTap: onTap,
      focusNode: focusNode,
    );

    fieldChildren.add(body);

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: fieldChildren,
      ),
    );
  }
}

class _FieldBody extends StatefulWidget {
  final bool? autofocus;
  final String? initialValue;
  final String? placeholder;
  final TextInputAction? textInputAction;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final Function(String, BuildContext)? onSubmitted;
  final Function(bool)? onFocusChanged;
  final Function? onTap;
  final FocusNode? focusNode;

  _FieldBody({
    this.autofocus,
    this.initialValue,
    this.textInputAction,
    this.placeholder,
    this.keyboardType,
    this.onChanged,
    this.onSubmitted,
    this.onFocusChanged,
    this.onTap,
    this.focusNode,
  });

  _FieldBodyState createState() => _FieldBodyState();
}

class _FieldBodyState extends State<_FieldBody> {
  final int _maxLines = 3;
  final _controller = TextEditingController();

  void _controllerUpdated() => widget.onChanged?.call(_controller.text);

  @override
  void initState() {
    _controller.text = widget.initialValue ?? "";
    _controller.addListener(_controllerUpdated);
    widget.focusNode?.addListener(focusUpdated);
    super.initState();
  }

  void focusUpdated() {
    widget.onFocusChanged?.call(widget.focusNode?.hasFocus ?? false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = SemanticTheme.of(context);

    final decoration = InputDecoration(
      hintText: widget.placeholder,
      border: OutlineInputBorder(),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: theme?.color?.stroke?.medium ?? Colors.black),
        borderRadius: BorderRadius.all(theme?.radius?.medium ?? Radius.circular(0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: theme?.color?.stroke?.strong ?? Colors.black),
        borderRadius: BorderRadius.all(theme?.radius?.medium ?? Radius.circular(0)),
      ),
      hintStyle: theme?.typography?.body?.textStyle(
        color: theme.color?.text?.inputPlaceholder ?? Colors.black,
      ),
    );

    return TextField(
      autofocus: widget.autofocus ?? false,
      textInputAction: widget.textInputAction,
      maxLines: _maxLines,
      decoration: decoration,
      keyboardType: widget.keyboardType,
      enableSuggestions: false,
      autocorrect: false,
      enableIMEPersonalizedLearning: false,
      onSubmitted: (value) => widget.onSubmitted?.call(value, context),
      focusNode: widget.focusNode,
      onTap: widget.onTap as GestureTapCallback?,
      controller: _controller,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
