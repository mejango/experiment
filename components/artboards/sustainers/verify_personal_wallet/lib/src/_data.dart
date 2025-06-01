import 'package:flutter/material.dart';
import 'package:form_builder/index.dart';

mixin VerifyPersonalWalletArtboardData implements FormBuilder {
  @override
  Future<List<StreamableFormFieldData>> get initialFieldData async => [
        _firstName,
        _lastName,
        _email,
        _address,
        _dob,
        _last4Ssn,
      ];

  Future<void> submit(BuildContext context) {
    // TODO: implement submit
    return Future.value();
  }

  final _firstName = FormFirstNameTextFieldData(
    isRequired: true,
  );
  final _lastName = FormLastNameTextFieldData(
    isRequired: true,
  );
  final _email = FormEmailTextFieldData(
    isRequired: true,
  );
  static final _address = AddressMetaFieldData(
    isRequired: true,
  );
  final _dob = FormDateOfBirthFieldData();
  final _last4Ssn = FormShortSsnFieldData(
    isRequired: true,
  );
}
