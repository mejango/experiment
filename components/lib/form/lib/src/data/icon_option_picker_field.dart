import 'package:form/index.dart';

import '_mixins/on_tap_listener_adder.dart';

class FormIconPickerFieldData extends StreamableFormFieldData<FormLabeledIcon> with OnTapListenerAdder {
  List<FormLabeledIcon>? options;
  FormLabeledIcon? selectedOption;

  FormIconPickerFieldData({
    this.selectedOption,
    this.options,
    required String title,
    double? size,
    bool? isVisible,
  }) : super(
          title: title,
          initialValue: selectedOption,
          size: size,
          isVisible: isVisible,
        );
}
