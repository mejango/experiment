import 'dart:async';

import 'package:stream/index.dart';
import 'package:sm_theme/index.dart';

import 'data/index.dart';

class AppBloc extends BlocBase {
  late StreamableAppStateData _appStateData;

  set theme(SmThemeOption theme) {
    _inAppState.add(_appStateData);
  }

  //The stream responsible for communicating changes to the app's state.
  final _appStateController = StreamController<StreamableAppStateData>();

  //Set the apps first state.
  set _initialAppStateData(StreamableAppStateData initialAppStateData) {
    _appStateData = initialAppStateData;
    _inAppState.add(_appStateData);
  }

  Sink<StreamableAppStateData> get _inAppState => _appStateController.sink;
  Stream<StreamableAppStateData> get outAppState => _appStateController.stream;

  AppBloc() {
    _init();
  }

  void _init() async {
    _initialAppStateData = StreamableAppStateData(isInSession: true);
  }

  @override
  void dispose() {
    _appStateController.close();
  }
}
