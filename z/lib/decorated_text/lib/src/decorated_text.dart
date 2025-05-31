import 'package:flutter/material.dart';

class StyleDecoratedText extends _DecoratedText {
  final TextStyle defaultStyle;

  StyleDecoratedText({required String text, required this.defaultStyle})
      : super(text: text);

  addSection({required String text, required TextStyle style}) {
    final section = _StyleTextSection(text: text, style: style);
    super._addSection(section);
  }

  RichText generateWidget() {
    final children = _sections.map((section) {
      return TextSpan(
          text: section.text,
          style: (section as _StyleTextSection).style);
    }).toList();

    return super._generateWidgetFromChildren(
        children: children, defaultStyle: defaultStyle);
  }
}

class WeightDecoratedText extends _DecoratedText {
  final TextStyle thinStyle;

  WeightDecoratedText({required String text, required this.thinStyle}) : super(text: text);

  addSection({required String text, bool thin = false}) {
    final section = _WeightTextSection(text: text, thin: thin);
    super._addSection(section);
  }

  RichText generateWidget(
      {required TextStyle defaultStyle,
      required TextStyle thinStyle,
      double textScaleFactor = 1}) {
    final children = _sections.map((section) {
      return TextSpan(
          text: section.text,
          style:
              (section as _WeightTextSection).thin ? thinStyle : defaultStyle);
    }).toList();
    return super._generateWidgetFromChildren(
        children: children,
        defaultStyle: defaultStyle,
        textScaleFactor: textScaleFactor);
  }
}

abstract class _DecoratedText {
  final String text;

  var _sections = <_TextSection>[];

  _DecoratedText({required this.text});

  RichText _generateWidgetFromChildren(
      {required List<TextSpan> children,
      required TextStyle defaultStyle,
       double? textScaleFactor}) {
    final spacedChildren = _addSpaces(children);
    final richTextWidget = RichText(
        textScaler: textScaleFactor != null ? TextScaler.linear(textScaleFactor) : TextScaler.noScaling,
        text:
            TextSpan(text: "", style: defaultStyle, children: spacedChildren));
    return richTextWidget;
  }

  List<TextSpan> _addSpaces(List<TextSpan> children) {
    List<TextSpan> newList = [];
    for (var child in children) {
      if (newList.isNotEmpty) {
        final spaceChild = TextSpan(text: " ");
        newList.add(spaceChild);
      }
      newList.add(child);
    }
    return newList;
  }

  _addSection(_TextSection section) {
    _sections.add(section);
  }
}

class _StyleTextSection extends _TextSection {
  final TextStyle style;

  _StyleTextSection({required String text, required this.style}) : super(text: text);
}

class _WeightTextSection extends _TextSection {
  final bool thin;

  _WeightTextSection({required String text, required this.thin}) : super(text: text);
}

abstract class _TextSection {
  final String text;

  _TextSection({required this.text});
}
