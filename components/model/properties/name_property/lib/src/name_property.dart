import 'package:key/index.dart' as _key;
import 'package:mappable/index.dart';

class NameProperty with Mappable {
  final String? name;

  NameProperty({this.name});

  factory NameProperty.fromMap(Map<String?, Object?> map) {
    return NameProperty(name: map[_key.name] as String?);
  }

  @override
  Map<String, Object?> toMap() {
    return {_key.name: name};
  }
}
