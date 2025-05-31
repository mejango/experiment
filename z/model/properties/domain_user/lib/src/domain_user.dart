import 'package:name_user/index.dart';
import 'package:domain/index.dart';
import 'package:key/index.dart' as _key;

class DomainUser extends NameUser {
  final Domain? domain;
  final Domain? formerDomain;
  final String? nickname;

  DomainUser(
      {String? guid,
      String? firstName,
      String? lastName,
      this.domain,
      this.formerDomain,
      this.nickname})
      : super(guid: guid, firstName: firstName, lastName: lastName);

  factory DomainUser.fromMap(Map<String?, Object?> map) {
    final superMap = NameUser.fromMap(map);
    return DomainUser(
        guid: superMap.guid,
        firstName: superMap.firstName,
        lastName: superMap.lastName,
        domain: Domain.fromMap(map[_key.domain] as Map<String, Object>),
        formerDomain: Domain.fromMap(map[_key.formerDomain] as Map<String, Object>),
        nickname: map[_key.nickname] as String?);
  }

  @override
  Map<String, Object?> toMap() {
    final map = super.toMap();
    map.addAll({
      _key.domain: domain?.toMap(),
      _key.formerDomain: formerDomain?.toMap(),
      _key.nickname: nickname
    });

    return map;
  }
}
