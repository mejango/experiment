import '_components/page_header.dart';

mixin PageHeaderBuilder {
  PageHeader buildPageHeader({
    required String text,
    double? horizontalGutter,
  }) =>
      PageHeader(
        text: text,
        horizontalGutter: horizontalGutter,
      );
}
