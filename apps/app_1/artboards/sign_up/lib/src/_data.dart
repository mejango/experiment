import 'package:flutter/material.dart';
import 'package:form_builder/index.dart';

mixin SignUpArtboardData implements FormBuilder {
  @override
  String get title => "Save my session";

  @override
  String get submitButtonText => "Save";

  @override
  Future<List<StreamableFormFieldData>> buildInitialFieldData(
          BuildContext context) async => Future.value([
        _emailFieldData
      ]);

  final _emailFieldData = FormEmailTextFieldData(
    placeholder: "tyhay@coco.io",
  );
}
