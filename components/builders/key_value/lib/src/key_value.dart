import 'package:flutter/material.dart';
import 'package:semantic_theme/index.dart';

class KeyValue extends StatelessWidget {
  final String title;
  final String value;

  KeyValue({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = SemanticTheme.of(context);

    final titleWidget = Text(
      title.toUpperCase(),
      style: theme?.typography?.label?.textStyle(
        color: theme.color?.text?.generalSecondary ?? Colors.black,
      ),
    );

    final valueWidget = Container(
      margin: EdgeInsets.only(
        top: theme?.distance?.spacing?.vertical?.min ?? 0,
      ),
      child: Text(
        value,
        style: theme?.typography?.body?.textStyle(
          color: theme.color?.text?.generalPrimary ?? Colors.black,
        ),
        softWrap: true,
      ),
    );

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          titleWidget,
          valueWidget,
        ],
      ),
    );
  }
}
