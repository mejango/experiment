import 'dart:async';

import 'package:flutter/material.dart';
import 'package:form_validation_exception/index.dart';

import 'text_field.dart';

class FormPasswordTextFieldData extends FormTextFieldData {
  static const numberSet = '0123456789';
  static const letterSet =
      'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
  static const symbolSet = (r'[\^$*.\[\]{}()?\-"!@#%&/\,><:;_~`+=' // <-- Notice the escaped symbols
    "'" // <-- ' is added to the expression
    ']');
  static const characterSet = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#\$%^&*()_+-?><,./|][}{]~';

  FormPasswordTextFieldData({
    String title = "Password",
    String placeholder = "8+ letters, numbers & symbols",
    String? initialValue,
    double? size,
    bool? isVisible,
    bool? autofocus,
    ValueChanged<String>? onSubmitted,
    String? exceptionTitle,
  }) : super(
          title: title,
          placeholder: placeholder,
          initialValue: initialValue,
          autofocus: autofocus,
          size: size,
          isVisible: isVisible,
          isPassword: true,
          min: 8,
          max: 30,
          keyboardType: TextInputType.visiblePassword,
          exceptionTitle: exceptionTitle,
        );

  void validate() {
    if (value == null ||
        !value!.contains(RegExp('[$numberSet]')) ||
        !value!.contains(RegExp('[$letterSet]')) ||
        !value!.contains(RegExp(symbolSet)) || 
        !_allCharsInStringRegex(value!, characterSet)) {
      throw FormValidationException.unsafePassword();
    }
    super.validate();
  }

  /// Checks if all characters in the [source] string are present
  /// in the [target] string using a regular expression.
  /// The order and frequency of characters do not matter.
  bool _allCharsInStringRegex(String source, String target) {
    // If the source string is empty, its characters are vacuously
    // considered to be in the target.
    if (source.isEmpty) {
      return true;
    }

    // 1. Get the unique characters from the source string.
    final uniqueSourceChars = source.split('').toSet();

    // 2. Escape any special regex characters to ensure they are treated literally.
    // For example, '$' must be escaped to '\$' to match a literal dollar sign.
    String escape(String s) =>
        s.replaceAllMapped(RegExp(r'[.*+?^${}()|[\]\\]'), (m) => '\\${m[0]}');

    // 3. Build the regex pattern using a positive lookahead `(?=...)` for each unique character.
    // This asserts that each character exists somewhere in the target string.
    final lookaheads = uniqueSourceChars.map((c) => '(?=.*${escape(c)})').join();

    // The full pattern anchors the lookaheads to the start of the string.
    final pattern = '^$lookaheads.*\$';
    
    // 4. Create the RegExp and test it against the target string.
    return RegExp(pattern).hasMatch(target);
  }
}
