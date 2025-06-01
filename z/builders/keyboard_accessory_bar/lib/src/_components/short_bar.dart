import 'package:flutter/material.dart';

class KeyboardAccessoryShortBar extends StatelessWidget {
  final List<Widget> children;

  KeyboardAccessoryShortBar({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(children: children),
    );
  }
}
