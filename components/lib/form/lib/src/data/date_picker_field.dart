import 'package:date/index.dart';
import 'package:form/index.dart';

import '_mixins/on_tap_listener_adder.dart';

class FormDatePickerFieldData extends StreamableFormFieldData<Date>
    with OnTapListenerAdder {
  DateTime? startBound;
  DateTime? endBound;

  FormDatePickerFieldData({
    required String title,
    DateTime? initialValue,
    this.startBound,
    this.endBound,
    double? size,
    bool? isVisible,
  }) : super(
          title: title,
          initialValue: initialValue != null ? Date.fromDateTime(initialValue) : null,
          size: size,
          isVisible: isVisible,
        );
}
