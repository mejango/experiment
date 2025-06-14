import 'package:artboard/index.dart';
import 'package:date/index.dart';
import 'package:flutter/material.dart';
import 'package:haptics/index.dart';

import '_components/date_picker.dart';

//Date pickers must be an artboard
mixin DatePickerBuilder implements Artboard<Date> {
  Date? get selectedDate;
  Date? get startBound;
  Date? get endBound;
}

mixin DatePickerBuilderState<T extends DatePickerBuilder>
    implements ArtboardState<T> {
  Date? _date;

  Date? get date => _date;
  set date(Date? newDate) => _date = newDate;

  Widget buildDatePicker(BuildContext context) {
    return CalDatePicker(
      selectedDate: date ?? widget.selectedDate,
      onDayPressed: _onDayPressed,
      startBound: widget.startBound,
      endBound: widget.endBound,
    );
  }

  void _onDayPressed(Date newDate) {
    triggerHaptic(HapticOption.click);
    date = newDate;
  }
}
