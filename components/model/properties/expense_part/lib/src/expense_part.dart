import 'package:name_formatter/index.dart';
import 'package:key/index.dart' as _key;
import 'package:bank_owner_reference/index.dart';
import 'package:mappable/index.dart';
import 'package:name_defining_object/index.dart';

class ExpensePart with Mappable {
  final int? amount;
  final BankOwnerReference? splitter;
  final BankOwnerReference? payer;

  ExpensePart({this.amount, this.splitter, this.payer});

  factory ExpensePart.fromMap(Map<String?, Object?> map) {
    return ExpensePart(
        amount: map[_key.amount] as int?,
        splitter: BankOwnerReference.fromMap(map[_key.splitter] as Map<String, Object>),
        payer: BankOwnerReference.fromMap(map[_key.payer] as Map<String, Object>));
  }

  @override
  Map<String, Object?> toMap() {
    return {
      _key.amount: amount,
      _key.splitter: splitter?.toMap(),
      _key.payer: payer?.toMap()
    };
  }

  String? formattedPayer({
    required String sessionOwnerGuid,
    required NameDefiningObject nameDefiningObject,
    bool? firstPerson = false,
  }) {
    return payer?.guid == null ? null : formatNames(
        guids: [payer!.guid!],
        sessionOwnerGuid: sessionOwnerGuid,
        nameDefiningObject: nameDefiningObject,
        firstPerson: firstPerson);
  }

  String? formattedSplitter({
    required String sessionOwnerGuid,
    required NameDefiningObject nameDefiningObject,
    bool? firstPerson = false,
  }) {
    return splitter?.guid == null ? null : formatNames(
        guids: [splitter!.guid!],
        sessionOwnerGuid: sessionOwnerGuid,
        nameDefiningObject: nameDefiningObject,
        firstPerson: firstPerson);
  }
}
