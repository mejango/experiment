import 'dart:math';
import 'package:flutter/material.dart';
import 'package:artboard/index.dart';

import 'package:semantic_theme/index.dart';

mixin HorizontalFloatingArtboard<T> implements StatefulWidget, Artboard<T> {}

mixin HorizontalFloatingArtboardState<T extends HorizontalFloatingArtboard>
    implements State<T>, ArtboardState<T> {
  Widget buildBody(BuildContext context);

  Widget build(BuildContext context) {
    final theme = SemanticTheme.of(context);

    final decoration = BoxDecoration(
      color: theme?.color.background.general,
      borderRadius: BorderRadius.all(theme?.radius.large ?? Radius.zero),
      boxShadow: [
        theme?.shadow.large ?? BoxShadow(color: Colors.transparent),
      ],
    );

    final pageContent = Container(
      padding: EdgeInsets.symmetric(
        horizontal: theme?.distance.gutter.horizontal.medium ?? 0,
        vertical: theme?.distance.gutter.vertical.medium ?? 0,
      ),
      child: buildBody(context),
    );

    final safeArea = MediaQuery.of(context).padding;
    final margin = EdgeInsets.fromLTRB(
      theme?.distance.gutter.horizontal.large ?? 0,
      theme?.distance.gutter.vertical.medium ?? 0,
      theme?.distance.gutter.horizontal.medium ?? 0,
      theme?.distance.gutter.vertical.medium ?? 0,
    );
    final safeAreaMargin = EdgeInsets.fromLTRB(
      margin.left,
      max(margin.top, safeArea.top),
      margin.right,
      max(margin.bottom, safeArea.bottom),
    );

    final nonClickableSurface = GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {},
      child: pageContent,
    );

    return Container(
      margin: safeAreaMargin,
      decoration: decoration,
      child: nonClickableSurface,
    );
  }
}
