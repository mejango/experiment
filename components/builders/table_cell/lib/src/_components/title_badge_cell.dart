import 'package:flutter/material.dart';
import 'package:semantic_theme/index.dart';
import 'package:standard_icon_library/index.dart';
import 'package:vertically_centered_text_builder/index.dart';
import 'package:x_small_icon_library/index.dart';

import 'card_cell.dart';

class TitleBadgeCell extends StatelessWidget
    with VerticallyCenteredTextBuilder {
  final String title;
  final String? subtitle;
  final StandardIcon? icon;
  final String? badgeText;
  final void Function()? onTap;

  TitleBadgeCell({
    required this.title,
    this.subtitle,
    this.icon,
    this.badgeText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = SemanticTheme.of(context);

    final List<Widget> rowChildren = [];

    if (icon != null) {
      final iconWidget = Padding(
        padding: EdgeInsets.only(
          right: theme?.distance?.spacing?.horizontal?.medium ?? 0,
        ),
        child: icon!.buildWidget(
          color: theme?.color?.icon?.generalPrimary ?? Colors.black,
        ),
      );
      rowChildren.add(iconWidget);
    }

    final nameText = _titleHeightBaseline(
      context,
      Padding(
        child: Text(
          title,
          style: theme?.typography?.title?.textStyle(
            color: theme.color?.text?.generalPrimary ?? Colors.black,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        padding: EdgeInsets.only(
          right: theme?.distance?.spacing?.horizontal?.small ?? 0,
        ),
      ),
    );

    Widget subtitleText;
    if (subtitle != null) {
      subtitleText = _titleHeightBaseline(
        context,
        Padding(
          padding: EdgeInsets.only(
            right: theme?.distance?.spacing?.horizontal?.small ?? 0,
          ),
          child: Text(
            subtitle ?? "",
            style: theme?.typography?.body?.textStyle(
              color: theme.color?.text?.generalSecondary ?? Colors.black,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );
      rowChildren.add(
        Expanded(
          child: Wrap(
            children: [
              nameText,
              subtitleText,
            ],
          ),
        ),
      );
    } else {
      rowChildren.add(
        Expanded(child: nameText),
      );
    }

    if (badgeText != null) {
      final notificationText = buildVerticallyCenteredText(
        Text(
          badgeText ?? "",
          style: theme?.typography?.bodyHeavy?.textStyle(
            color: theme.color?.text?.generalSecondary ?? Colors.black,
          ),
        ),
      );
      rowChildren.add(notificationText);
    }

    final arrow = XSmallIcon.rightArrow.buildWidget(
      color: theme?.color?.icon?.generalSecondary ?? Colors.black,
    );
    rowChildren.add(arrow);

    return CardCell(
      child: Row(
        children: rowChildren,
      ),
      onTap: onTap,
    );
  }

  Baseline _titleHeightBaseline(BuildContext context, Widget child) => Baseline(
        baseline: SemanticTheme.of(context)?.typography?.title?.fontSize ?? 0,
        baselineType: TextBaseline.alphabetic,
        child: child,
      );
}
