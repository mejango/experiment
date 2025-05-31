import 'package:billing_type/index.dart';
import 'package:billing_status_type/index.dart';
import 'package:mappable/index.dart';
import 'package:key/index.dart' as _key;

class Billing with Mappable {
  final String? email;
  final bool? isEmailVerified;
  final String? firstName;
  final String? lastName;
  final BillingStatusType? statusType;
  final BillingType? type;
  final String? address1;
  final String? address2;
  final String? city;
  final String? postalCode;

  Billing(
      {this.email,
      this.isEmailVerified,
      this.firstName,
      this.lastName,
      this.statusType,
      this.type,
      this.address1,
      this.address2,
      this.city,
      this.postalCode});

  factory Billing.fromMap(Map<String?, Object?> map) {
    return Billing(
        email: map[_key.email] as String?,
        isEmailVerified: map[_key.isEmailVerified] as bool?,
        firstName: map[_key.firstName] as String?,
        lastName: map[_key.lastName] as String?,
        statusType: BillingStatusType.fromString(map[_key.statusKind] as String),
        type: BillingType.fromString(map[_key.kind] as String),
        address1: map[_key.address1] as String?,
        address2: map[_key.address2] as String?,
        city: map[_key.city] as String?,
        postalCode: map[_key.postalCode] as String?);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      _key.email: email,
      _key.isEmailVerified: isEmailVerified,
      _key.firstName: firstName,
      _key.lastName: lastName,
      _key.statusKind: statusType.toString(),
      _key.kind: type.toString(),
      _key.address1: address1,
      _key.address2: address2,
      _key.city: city,
      _key.postalCode: postalCode
    };
  }
}
