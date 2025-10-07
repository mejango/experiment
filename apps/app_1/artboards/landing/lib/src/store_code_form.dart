import 'dart:async';

import 'package:flutter/material.dart';
import 'package:form_vertical_floating_artboard_template/index.dart';
import 'package:navigator/index.dart';

import 'store_code_data.dart';
import 'package:merchant_artboard/index.dart';

class StoreCodeVerticalFloatingArtboard extends FormVerticalFloatingArtboard
    with StoreCodeArtboardData {
  @override
  Future<void> submit(BuildContext context) async {
    // Handle store code submission
    print('Store code submitted: ${storeCodeFieldData.value}');
    
    // Navigate to payment form
    ArtboardNavigator.of(context)?.goTo(
      PaymentVerticalFloatingArtboard(),
    );
  }
}
