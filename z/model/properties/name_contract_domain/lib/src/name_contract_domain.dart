import 'package:context_type/index.dart';
import 'package:name_domain/index.dart';

import 'package:key/index.dart' as _key;

class NameContractDomain extends NameDomain {
  final String? phoneNumber;
  final bool? allowPartialPayments;
  final int? invoicePaymentBuffer;

  NameContractDomain(
      {String? guid,
      String? name,
      ContextType? type,
      this.phoneNumber,
      this.allowPartialPayments,
      this.invoicePaymentBuffer})
      : super(guid: guid, name: name, type: type);

  factory NameContractDomain.fromMap(Map<String?, Object?> map) {
    final nameDomain = NameDomain.fromMap(map);
    return NameContractDomain(
        guid: nameDomain.guid,
        name: nameDomain.name,
        type: nameDomain.type,
        phoneNumber: map[_key.phoneNumber] as String?,
        allowPartialPayments: map[_key.allowPartialPayments] as bool?,
        invoicePaymentBuffer: map[_key.invoicePaymentBuffer] as int?);
  }

  @override
  Map<String, Object?> toMap() {
    final map = super.toMap();
    map.addAll({
      _key.phoneNumber: phoneNumber,
      _key.allowPartialPayments: allowPartialPayments,
      _key.invoicePaymentBuffer: invoicePaymentBuffer
    });

    return map;
  }
}
