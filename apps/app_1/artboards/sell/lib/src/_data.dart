import 'package:flutter/material.dart';
import 'package:form_builder/index.dart';

mixin SellArtboardData implements FormBuilder {
  @override
  String get title => "Create your business";

  @override
  String get submitButtonText => "Create";

  @override
  Future<List<StreamableFormFieldData>> buildInitialFieldData(
          BuildContext context) async => Future.value([
        _nameFieldData,
        _tickerFieldData
      ]);

  final _nameFieldData = FormMediumTextFieldData(
    title: "Name of your business",
  );

  final _tickerFieldData = FormMediumTextFieldData(
    title: "Ticker of your business",
  );

  // final _amountFieldData = FormCurrencyTextFieldData(
  //   placeholder: "0.00",
  // );
}
