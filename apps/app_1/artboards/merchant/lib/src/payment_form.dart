import 'dart:async';

import 'package:flutter/material.dart';
import 'package:form_vertical_floating_artboard_template/index.dart';
import 'package:navigator/index.dart';

import 'payment_data.dart';

class PaymentVerticalFloatingArtboard extends FormVerticalFloatingArtboard
    with PaymentArtboardData {
  @override
  Future<void> submit(BuildContext context) async {
    // Handle payment submission
    print('Payment submitted with amount: ${amountFieldData.value}');
    
    // Navigate back to merchant page
    ArtboardNavigator.of(context)?.pop("payment_completed");
  }
}
