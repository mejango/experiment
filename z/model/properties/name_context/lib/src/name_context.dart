import 'package:context_type/index.dart';
import 'package:key/index.dart' as _key;
import 'package:mappable/index.dart';

class NameContext with Mappable {
  final String? guid;
  final String? name;
  final ContextType? type;

  NameContext({this.guid, this.name, this.type});

  factory NameContext.fromMap(Map<String?, Object?> map) {
    return NameContext(
        guid: map[_key.guid] as String?,
        name: map[_key.name] as String?,
        type: map[_key.kind] as ContextType?);
  }

  @override
  Map<String, Object?> toMap() {
    return {_key.guid: guid, _key.name: name, _key.kind: type};
  }
}
