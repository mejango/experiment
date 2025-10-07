import 'dart:async';

import 'package:flutter/material.dart';
import 'package:form_validation_exception/index.dart';

import 'text_field.dart';

class FormEmailTextFieldData extends FormTextFieldData {
  static final regEx = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

  FormEmailTextFieldData({
    String? initialValue,
    double? size,
    bool? isVisible,
    bool? autofocus,
    bool? isRequired,
    String? exceptionTitle,
    String? placeholder
  }) : super(
          title: 'Email',
          placeholder: placeholder ?? 'address@email.com',
          initialValue: initialValue,
          autofocus: autofocus,
          keyboardType: TextInputType.emailAddress,
          size: size,
          isVisible: isVisible,
          min: isRequired == true ? 1 : null,
          exceptionTitle: exceptionTitle,
        );

  @override
  void validate() {
    if (value == null || !regEx.hasMatch(value!)) {
      throw FormValidationException.badEmail();
    }
    super.validate();
  }
}
