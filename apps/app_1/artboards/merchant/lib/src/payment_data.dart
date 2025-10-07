import 'package:flutter/material.dart';
import 'package:form_builder/index.dart';

mixin PaymentArtboardData implements FormBuilder {
  @override
  String get title => "Payment";

  @override
  String get submitButtonText => "Pay";

  @override
  Future<List<StreamableFormFieldData>> buildInitialFieldData(
          BuildContext context) async => Future.value([
        amountFieldData,
      ]);

  final amountFieldData = FormCurrencyTextFieldData(
    title: "Amount to pay",
    placeholder: "0.00",
  );
}
