import 'package:flutter/material.dart';
import 'package:haptics/index.dart';
import 'package:artboard/index.dart';
import 'package:labeled_icon/index.dart';

import '_components/icon_picker.dart';

//Icon picker must be an artboard
mixin IconPickerArtboardBuilder implements Artboard<LabeledIcon> {
  String? get title;
  LabeledIcon? get selectedOption;
  List<LabeledIcon>? get options;
}

mixin IconPickerBuilderArtboardState<U extends IconPickerArtboardBuilder>
    implements ArtboardState<U> {
  late LabeledIcon? _selectedOption;

  LabeledIcon? get selectedOption => _selectedOption;
  set selectedOption(LabeledIcon? newOption) => _selectedOption = newOption;

  Widget buildIconPicker(BuildContext context) {
    return IconPicker(
      title: widget.title,
      options: widget.options ?? [],
      selectedOption: selectedOption ?? widget.selectedOption,
      onChanged: _onOptionTap,
    );
  }

  void _onOptionTap(LabeledIcon newOption) {
    triggerHaptic(HapticOption.click);
    selectedOption = newOption;
  }
}
