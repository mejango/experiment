import 'package:standard_icon_library/index.dart';
import 'package:labeled_value/index.dart';

class LabeledIcon extends LabeledValue<StandardIcon> {
  StandardIcon get icon => super.value;

  LabeledIcon({
    required String label,
    required StandardIcon icon,
  }) : super(
          label: label,
          value: icon,
        );
}
