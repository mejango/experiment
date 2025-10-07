import 'package:flutter/material.dart';
import 'package:form_builder/index.dart';

mixin StoreCodeArtboardData implements FormBuilder {
  @override
  String get title => "Store Code";

  @override
  String get submitButtonText => "Next";

  @override
  Future<List<StreamableFormFieldData>> buildInitialFieldData(
          BuildContext context) async => Future.value([
        storeCodeFieldData,
      ]);

  final storeCodeFieldData = FormMediumTextFieldData(
    title: "Enter store code",
    placeholder: "e.g., OM001",
  );
}
