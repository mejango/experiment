import 'package:flutter/material.dart';
import 'package:form_body_builder/src/_components/fields/_widgets/index.dart';
import 'package:mask/index.dart';
import 'package:semantic_theme/index.dart';

//TODO
//for animating:
// https://spaced_columnoverflow.com/questions/50736571/when-i-select-a-textfield-the-keyboard-moves-over-it
/// may want to make this animation a mixin so text area and any other field can benefit if needed.
class StandardTextField extends StatelessWidget {
  final String? fieldName;
  final String? placeholder;
  final String? initialValue;
  final bool? isPassword;
  final bool? autofocus;
  final TextInputAction? textInputAction;
  final MaskOption? mask;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final Function(String, BuildContext)? onSubmitted;
  final Function(bool)? onFocusChanged;
  final Function? onTap;
  final FocusNode? focusNode;

  StandardTextField({
    this.fieldName,
    this.placeholder,
    this.initialValue,
    this.isPassword = false,
    this.autofocus = false,
    this.mask,
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
    final labelContainer = Flexible(
      flex: 0,
      child: FieldLabel(
        labelText: fieldName ?? "",
      ),
    );

    final fieldBody = _FieldBody(
      autofocus: autofocus ?? false,
      isPassword: isPassword ?? false,
      textInputAction: textInputAction ?? TextInputAction.done,
      initialValue: initialValue ?? "",
      mask: mask as MaskOption,
      placeholder: placeholder ?? "",
      keyboardType: keyboardType ?? TextInputType.text,
      onChanged: onChanged as Function(String),
      onSubmitted: onSubmitted as Function(String, BuildContext),
      onFocusChanged: onFocusChanged as Function(bool),
      onTap: onTap,
      focusNode: focusNode as FocusNode,
    );

    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          labelContainer,
          fieldBody,
        ],
      ),
    );
  }
}

class _FieldBody extends StatefulWidget {
  final bool? autofocus;
  final bool? isPassword;
  final TextInputAction? textInputAction;
  final String? initialValue;
  final String? placeholder;
  final MaskOption? mask;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final Function(String, BuildContext)? onSubmitted;
  final Function(bool)? onFocusChanged;
  final Function? onTap;
  final FocusNode? focusNode;

  _FieldBody({
    this.autofocus,
    this.isPassword,
    this.initialValue,
    this.textInputAction,
    this.mask,
    this.keyboardType,
    this.placeholder,
    this.onChanged,
    this.onSubmitted,
    this.onFocusChanged,
    this.onTap,
    this.focusNode,
  });

  _FieldBodyState createState() => _FieldBodyState();
}

class _FieldBodyState extends State<_FieldBody> {
  final _controller = TextEditingController();

  String _formattedPlaceholder = "";
  bool _didSetInitialValue = false;

  _FieldBodyState();

  @override
  void initState() {
    _controller.addListener(_controllerUpdated);
    widget.focusNode?.addListener(_focusUpdated);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_didSetInitialValue) {
      _formattedPlaceholder = _formattedText(
        text: widget.placeholder ?? "",
        context: context,
      );
      _setInitialValue();
    }

    _didSetInitialValue = true;
    super.didChangeDependencies();
  }

  void _setInitialValue() {
    if (widget.initialValue?.isEmpty ?? true) return;
    final formattedText = _formattedText(
      text: widget.initialValue ?? "",
      context: context,
    );
    _setText(formattedText);
  }

  @override
  Widget build(BuildContext context) {
    final theme = SemanticTheme.of(context);

    final decoration = InputDecoration(
      hintText: _formattedPlaceholder,
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

    return Expanded(
      child: TextField(
        autofocus: widget.autofocus ?? false,
        obscureText: widget.isPassword ?? false,
        textInputAction: widget.textInputAction,
        keyboardType: widget.keyboardType,
        style: theme?.typography?.body?.textStyle(
          color: theme.color?.text?.inputActive ?? Colors.black,
        ),
        textAlign: TextAlign.right,
        decoration: decoration,
        focusNode: widget.focusNode,
        keyboardAppearance: theme?.systemUiStyle?.keyboardBrightness?.value ?? Brightness.light,
        onSubmitted: (value) => widget.onSubmitted?.call(value, context),
        onTap: widget.onTap as GestureTapCallback?,
        controller: _controller,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    widget.focusNode?.removeListener(_focusUpdated);
    super.dispose();
  }

  void _controllerUpdated() {
    if (widget.mask != null) {
      final formattedText = _formattedText(
        text: _controller.text,
        context: context,
      );
      if (formattedText != _controller.text) return _setText(formattedText);
    }
    widget.onChanged?.call(_controller.text);
  }

  String _formattedText({
    required String text,
    required BuildContext context,
  }) {
    if (widget.mask == null) return text;
    final formattedText = applyMask(
      widget.mask as MaskOption,
      text: text,
      isEditing: widget.focusNode?.hasFocus ?? false,
      context: context,
    );
    return formattedText;
  }

  void _setText(String text) {
    //Prevents the cursor from jumping.
    TextSelection cursorPos = _controller.selection;
    _controller.text = text;
    cursorPos = TextSelection.fromPosition(
      TextPosition(
        offset: _controller.text.length,
      ),
    );
    _controller.selection = cursorPos;
  }

  void _focusUpdated() {
    final formattedText = _formattedText(
      text: _controller.text,
      context: context,
    );
    _setText(formattedText);
    widget.onFocusChanged?.call(widget.focusNode?.hasFocus ?? false);
  }
}
