import 'package:flutter/material.dart';
import 'package:sm_theme/index.dart';
import 'package:stream/index.dart';
import 'package:semantic_theme/index.dart';

import 'src/bloc.dart';
import 'src/widget.dart' as app;

void main() {
  runApp(_App1());
}

class _App1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("Building app");
    return SemanticTheme(
      themeData: SmSemanticTheme(SmThemeOption.dark),
      child: MaterialApp(
        title: 'App 1',
        debugShowCheckedModeBanner: false,
        home: BlocProvider(
          bloc: AppBloc(),
          child: app.RootWidget(),
        ),
      ),
    );
  }
}
