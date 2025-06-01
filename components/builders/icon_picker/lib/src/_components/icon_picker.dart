import 'package:flutter/material.dart';
import 'package:semantic_theme/index.dart';
import 'package:standard_icon_library/index.dart';
import 'package:labeled_icon/index.dart';

typedef SelectedIconPasser = Function(LabeledIcon);

class IconPicker extends StatelessWidget {
  final String? title;
  final LabeledIcon? selectedOption;
  final List<LabeledIcon> options;
  final SelectedIconPasser? onChanged;

  IconPicker({
    this.title,
    this.selectedOption,
    required this.options,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = SemanticTheme.of(context);

    final List<Widget> columnChildren = [];

    if (title != null && title!.isNotEmpty) {
      final titleWidget = Text(
        title!,
        style: theme?.typography?.headingSecondary?.textStyle(
          color: theme.color?.text?.generalPrimary ?? Colors.black,
        ),
      );
      columnChildren.add(titleWidget);
    }

    final iconsGrid = _IconsGrid(
      options: options,
      selectedOption: selectedOption,
      onTap: onChanged,
    );
    columnChildren.add(iconsGrid);

    return Container(
      child: Column(
        children: columnChildren,
      ),
    );
  }
}

class _IconsGrid extends StatelessWidget {
  final List<LabeledIcon>? options;
  final LabeledIcon? selectedOption;
  final SelectedIconPasser? onTap;

  _IconsGrid({
    this.options,
    this.selectedOption,
    this.onTap,
  });

  Widget build(BuildContext context) {
    final theme = SemanticTheme.of(context);

    final _selectedOption = selectedOption ?? options?.first;

    List<_IconOption>? optionsList = options?.map(
      (option) {
        return _IconOption(
          icon: option.icon,
          selected: _selectedOption == option,
          onTap: () => onTap?.call(option),
        );
      },
    ).toList();

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: theme?.distance?.spacing?.vertical?.medium ?? 0,
        horizontal: theme?.distance?.spacing?.horizontal?.small ?? 0,
      ),
      child: Column(
        children: [
          Wrap(children: optionsList ?? []),
        ],
      ),
    );
  }
}

class _IconOption extends StatelessWidget {
  final StandardIcon? icon;
  final GestureTapCallback? onTap;
  final bool? selected;

  _IconOption({
    this.icon,
    this.onTap,
    this.selected,
  });

  Widget build(BuildContext context) {
    final theme = SemanticTheme.of(context);

    final selectedColor = theme?.color?.icon?.action ?? Colors.transparent;
    final unselectedColor = theme?.color?.icon?.generalPrimary ?? Colors.transparent;

    final iconWidget = icon?.buildWidget(
      color: selected == true ? selectedColor : unselectedColor,
    );

    return Container(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: theme?.distance?.padding?.horizontal?.medium ?? 0,
            vertical: theme?.distance?.padding?.vertical?.medium ?? 0,
          ),
          child: iconWidget,
        ),
      ),
    );
  }
}
