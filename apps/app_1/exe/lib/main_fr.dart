import 'package:flutter/material.dart';
import 'package:sm_theme/index.dart';
import 'package:stream/index.dart';
import 'package:semantic_theme/index.dart';

import 'src/bloc.dart';
import 'src/widget.dart' as app;

void main() {
  runApp(_SustainersMarket());
}

class _SustainersMarket extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SemanticTheme(
      themeData: SmSemanticTheme(SmThemeOption.dark),
      child: MaterialApp(
        title: 'Sustainers Market',
        debugShowCheckedModeBanner: true,
        home: BlocProvider(
          bloc: AppBloc(),
          child: app.RootWidget(),
        ),
      ),
    );
  }
}
