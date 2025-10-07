import 'package:flutter/material.dart';
import 'package:form_validation_exception/index.dart';

import 'field.dart';

abstract class FormCompositionFieldData
    extends StreamableFormFieldData<String> {
  String? placeholder;
  bool? autofocus;
  TextInputAction? inputAction;
  TextInputType? keyboardType;
  bool? isOptional;
  double? maxValue;
  int? max;
  int? min;
  String exceptionTitle;

  List<ValueChanged<String>> _onSubmittedListeners = [];
  ValueChanged<String> get onSubmitted => (value) {
        for (final listener in _onSubmittedListeners) listener(value);
      };

  FormCompositionFieldData({
    this.inputAction,
    this.maxValue,
    this.max,
    this.min,
    required String title,
    String? placeholder = "",
    TextInputType? keyboardType = TextInputType.text,
    bool? isOptional = false,
    bool? autofocus = false,
    String? initialValue = "",
    double? size,
    bool? isVisible,
    bool? isRemovable,
    String? exceptionTitle,
  })  : placeholder = placeholder ?? "",
        keyboardType = keyboardType ?? TextInputType.text,
        isOptional = isOptional ?? false,
        autofocus = autofocus ?? false,
        exceptionTitle = exceptionTitle ?? title,
        super(
          title: title,
          initialValue: initialValue ?? "",
          size: size,
          isRemovable: isRemovable,
          isVisible: isVisible,
        );

  void addOnSubmittedListener(ValueChanged<String> fn) =>
      _onSubmittedListeners.add(fn);

  @override
  void validate() {
    if (max != null && value != null && value!.length > max!) {
      throw FormValidationException.tooLongString(fieldTitle: title, max: max!);
    }
    if (min != null && value != null && value!.length < min!) {
      throw FormValidationException.tooShortString(fieldTitle: title, min: min!);
    }
    if (maxValue != null && value != null && double.parse(value!) > maxValue!) {
      throw FormValidationException.maxValue(
          fieldTitle: title, maxValue: maxValue!);
    }
  }
}
