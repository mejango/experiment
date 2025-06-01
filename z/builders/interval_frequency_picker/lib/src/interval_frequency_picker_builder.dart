import 'package:flutter/material.dart';
import 'package:artboard/index.dart';
import 'package:period_type/index.dart';
import 'package:haptics/index.dart';
import 'package:frequency_type/index.dart';
import 'package:labeled_value/index.dart';

import '_components/interval_frequency_picker.dart';

mixin IntervalFrequencyPickerArtboardBuilder
    implements Artboard<FrequencyType> {
  FrequencyType? get selectedValue;
  List<LabeledValue<int>>? get intervalList;
  List<LabeledValue<PeriodType>>? get periodList;
}

mixin IntervalFrequencyPickerArtboardBuilderState<
    T extends IntervalFrequencyPickerArtboardBuilder> implements ArtboardState<T> {
  FrequencyType? _selectedSchedule;

  FrequencyType? get selectedSchedule => _selectedSchedule;
  set selectedSchedule(FrequencyType? newValue) => _selectedSchedule = newValue;

  Widget buildIntervalFrequencyPicker(BuildContext context) {
    return IntervalFrequencyPicker(
      selectedValue: widget.selectedValue,
      intervalList: widget.intervalList,
      periodList: widget.periodList,
      onChanged: _onChanged,
    );
  }

  void _onChanged(FrequencyType newValue) {
    triggerHaptic(HapticOption.click);
    selectedSchedule = newValue;
  }
}
