import 'package:bank_owner_reference/index.dart';
import 'package:mappable/index.dart';
import 'package:key/index.dart' as _key;

class Balance with Mappable {
  final int? aOwesB;
  final BankOwnerReference? bankOwnerA;
  final BankOwnerReference? bankOwnerB;

  Balance({this.aOwesB, this.bankOwnerA, this.bankOwnerB});

  factory Balance.fromMap(Map<String?, Object?> map) {
    return Balance(
        aOwesB: map[_key.guid] as int?,
        bankOwnerA: BankOwnerReference.fromMap(map[_key.bankOwnerA] as Map<String, Object>),
        bankOwnerB: BankOwnerReference.fromMap(map[_key.bankOwnerB] as Map<String, Object>));
  }

  @override
  Map<String, Object?> toMap() {
    return {
      _key.aOwesB: aOwesB,
      _key.bankOwnerA: bankOwnerA?.toMap(),
      _key.bankOwnerB: bankOwnerB?.toMap()
    };
  }
}
