import 'package:blossm_command/index.dart';
import 'package:flutter/material.dart';

import '../_utils/dispatcher_config.dart';
import '../_utils/device_info.dart';

class SessionCommands extends BlossmCommandDispatcher with DispatcherConfig {
  final BuildContext context;

  SessionCommands(this.context);

  @override
  String get domain => "session";

  @override
  Future Function() get onTokenInvalid => () => redirectToLanding(context);

  @override
  Future Function() get onChallengeIssued =>
      () => Future.value(); // redirectToChallengeAnswer(context);

  Future start() async {
    final _hasToken = await tokenStore.readSessionToken() != null;
    if (_hasToken) return;

    final deviceInfo = await DeviceInfo.read();

    print("deviceInfo: ${deviceInfo.toMap()}");

    return dispatch(
      route: "start",
      payload: {
        "device": deviceInfo.toMap(),
      },
    );
  }

  Future save({
    required String phoneNumber,
  }) async {
    return dispatch(
      payload: {
        "phone": phoneNumber,
        "id": phoneNumber,
      },
      route: "save",
    );
  }

  Future logout() {
    return dispatch(
      payload: {},
      route: "logout",
    );
  }

  Future switchContext({
    required String context,
  }) {
    return dispatch(
      payload: {
        "context": context,
      },
      route: "switch-context",
    );
  }
}
