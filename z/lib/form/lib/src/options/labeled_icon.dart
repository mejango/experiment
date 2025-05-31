import 'package:standard_icon_library/index.dart';
import 'package:labeled_value/index.dart';

class FormLabeledIcon extends LabeledValue<StandardIcon> {
  StandardIcon? get icon => super.value;

  FormLabeledIcon({
    required String title,
    required StandardIcon icon,
  }) : super(
          label: title,
          value: icon,
        );
}
