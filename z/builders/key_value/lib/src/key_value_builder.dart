import 'package:flutter/material.dart';

import 'key_value.dart';

mixin KeyValueBuilder {
  Widget buildKeyValue(
    BuildContext context, {
    required String title,
    required String value,
  }) {
    return KeyValue(
      title: title,
      value: value,
    );
  }
}