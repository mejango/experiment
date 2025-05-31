import 'package:key/index.dart' as _key;
import 'package:mappable/index.dart';

class NamePaymentProfile with Mappable {
  final String? guid;
  final String? nickname;
  final String? bankNickname;
  final String? bankGuid;
  final String? bankStatusType;
  final String? authorizationEmail;
  final bool? authorizationCompleted;

  NamePaymentProfile(
      {this.guid,
      this.nickname,
      this.bankNickname,
      this.bankGuid,
      this.bankStatusType,
      this.authorizationEmail,
      this.authorizationCompleted});

  factory NamePaymentProfile.fromMap(Map<String?, Object?> map) {
    return NamePaymentProfile(
        guid: map[_key.guid] as String?,
        nickname: map[_key.nickname] as String?,
        bankNickname: map[_key.bankNickname] as String?,
        bankGuid: map[_key.bankGuid] as String?,
        bankStatusType: map[_key.bankStatusKind] as String?,
        authorizationEmail: map[_key.authorizationEmail] as String?);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      _key.guid: guid,
      _key.nickname: nickname,
      _key.bankNickname: bankNickname,
      _key.bankGuid: bankGuid,
      _key.bankStatusKind: bankStatusType,
      _key.authorizationEmail: authorizationEmail
    };
  }
}
