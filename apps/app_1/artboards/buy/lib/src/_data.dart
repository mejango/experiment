import 'package:flutter/material.dart';
import 'package:form_builder/index.dart';

mixin BuyArtboardData implements FormBuilder {
  @override
  String get title => "Faz um pagamento";

  @override
  String get submitButtonText => "Pagar";

  @override
  Future<List<StreamableFormFieldData>> buildInitialFieldData(
          BuildContext context) async => Future.value([
        _codeFieldData
      ]);

  final _codeFieldData = FormMediumTextFieldData(
    title: "Codigo da venda",
  );
}
