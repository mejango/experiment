import 'package:flutter/material.dart';

class IconReference {
  final IconData iconData;
  final double size;

  IconReference({
    required this.iconData,
    required this.size,
  });

  Icon buildWidget({required Color color}) {
    return Icon(
      iconData,
      size: size,
      color: color,
    );
  }
}
