// import 'package:auth_verify_code_artboard/index.dart';
import 'package:blossm_command/index.dart';
import 'package:flutter/material.dart';
import 'package:navigator/index.dart';
import 'package:landing_artboard/index.dart';

import 'token_storer.dart';

mixin DispatcherConfig {
  final String baseUrl = "core.dev.dianet.work";

  final TokenStore tokenStore = DiaTokenStore();

  final Function(BuildContext) redirectToLanding =
      (BuildContext context) => ArtboardNavigator.of(context)?.goTo(
            LandingFullScreenArtboard(),
          );

  // final Function(BuildContext) redirectToChallengeAnswer =
  //     (BuildContext context) => ArtboardNavigator.of(context).goTo(
  //           AuthVerifyCodeVerticalFloatingArtboard(),
  //         );
}
