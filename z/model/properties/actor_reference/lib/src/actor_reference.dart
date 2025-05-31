import 'package:meta/meta.dart';
import 'package:domain_type/index.dart';
import 'package:mappable/index.dart';
import 'package:key/index.dart' as _key;

class ActorReference with Mappable {
  final String? guid;
  final String? domainGuid;
  final DomainType? domainType;

  ActorReference({required this.guid, this.domainGuid, this.domainType})
      : assert(guid == null);

  factory ActorReference.fromMap(Map<String?, Object?> map) {
    return ActorReference(
        guid: map[_key.guid] as String?,
        domainGuid: map[_key.domainGuid] as String?,
        domainType: DomainType.fromString(map[_key.domainKind] as String));
  }

  @override
  Map<String, Object?> toMap() {
    return {
      _key.domainKind: domainType?.toString(),
      _key.domainGuid: domainGuid,
      _key.guid: guid
    };
  }
}
