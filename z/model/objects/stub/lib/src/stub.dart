import 'package:date/index.dart';
import 'package:stub_type/index.dart';
import 'package:model_object/index.dart';
import 'package:key/index.dart' as _key;

class Stub extends ModelObject {
  final String? name;
  final StubType? type;
  final String? objectGuid;

  const Stub({
    String? guid,
    Date? dateCreated,
    String? creatorGuid,
    required this.name,
    required this.type,
    this.objectGuid,
  }) : super(guid: guid, dateCreated: dateCreated, creatorGuid: creatorGuid);

  factory Stub.fromMap(Map<String?, Object?> map) {
    final object = ModelObject.fromMap(map);
    final name = map[_key.name] as String?;
    final objectGuid = map[_key.object] as String?;

    return Stub(
        guid: object.guid,
        dateCreated: object.dateCreated,
        creatorGuid: object.creatorGuid,
        name: name,
        type: StubType.fromString(map[_key.kind] as String),
        objectGuid: objectGuid);
  }

  @override
  Map<String, Object?> toMap() {
    final map = super.toMap();
    map.addAll({
      _key.name: name,
      _key.kind: type.toString(),
      _key.object: objectGuid,
    });

    return map;
  }
}
