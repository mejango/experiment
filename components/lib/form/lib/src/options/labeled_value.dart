import 'package:stream/index.dart';

class FormLabeledValue<T> extends StreamableData {
  String label;
  T value;

  FormLabeledValue({required this.label, required this.value}) : super();
}
