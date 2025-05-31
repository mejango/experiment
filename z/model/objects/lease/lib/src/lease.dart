import 'package:contract/index.dart';
import 'package:fee_payer_type/index.dart';
import 'package:invoice_options/index.dart';
import 'package:contract_user/index.dart';
import 'package:name_contract_domain/index.dart';
import 'package:date/index.dart';
import 'package:name_property/index.dart';
import 'package:late_fee/index.dart';
import 'package:schedule/index.dart';
import 'package:key/index.dart' as _key;

class Lease extends Contract {
  final LateFee? lateFee;
  final NameProperty? property;
  final Date? nextInvoiceDeadline;
  final InvoiceType? nextInvoiceType;
  final int? openServiceRequestCount;
  final int? serviceRequestCompletionCount;
  final int? serviceRequestCount;

  Lease(
      { String? guid,
      Date? dateCreated,
      String? creatorGuid,
      int? unreadCommentableObjectCount,
      int? pinnedCommentableObjectCount,
      Date? startDate,
      Date? endDate,
      String? name,
      int? amount,
      Set<ContractUser>? users,
      Set<ContractUser>? formerUsers,
      Schedule? schedule,
      NameContractDomain? domain,
      int? invoiceCount,
      FeePayerType? feePayerType,
      bool? monthToMonth,
      this.lateFee,
      required this.property,
      this.nextInvoiceDeadline,
      this.nextInvoiceType,
      required this.openServiceRequestCount,
      required this.serviceRequestCompletionCount,
      this.serviceRequestCount})
      : super(
            guid: guid,
            dateCreated: dateCreated,
            creatorGuid: creatorGuid,
            unreadCommentableObjectCount: unreadCommentableObjectCount,
            pinnedCommentableObjectCount: pinnedCommentableObjectCount,
            startDate: startDate,
            endDate: endDate,
            name: name,
            amount: amount,
            users: users,
            formerUsers: formerUsers,
            schedule: schedule,
            domain: domain,
            invoiceCount: invoiceCount,
            feePayerType: feePayerType,
            monthToMonth: monthToMonth);

  factory Lease.fromMap(Map<String?, Object?> map) {

    final contract = Contract.fromMap(map);
    final counts = map[_key.counts] as Map? ?? {};

    return Lease(
        guid: contract.guid,
        dateCreated: contract.dateCreated,
        creatorGuid: contract.creatorGuid,
        unreadCommentableObjectCount: contract.unreadCommentableObjectCount,
        pinnedCommentableObjectCount: contract.pinnedCommentableObjectCount,
        startDate: contract.startDate,
        endDate: contract.endDate,
        name: contract.name,
        amount: contract.amount,
        users: contract.users,
        formerUsers: contract.formerUsers,
        schedule: contract.schedule,
        domain: contract.domain,
        invoiceCount: contract.invoiceCount,
        feePayerType: contract.feePayerType,
        monthToMonth: contract.monthToMonth,
        lateFee: LateFee.fromMap(map[_key.lateFee] as Map<String, Object?>? ?? {}),
        property: NameProperty.fromMap(map[_key.property] as Map<String, Object?>? ?? {}),
        nextInvoiceDeadline:
            Date.fromSecondsSinceEpoch(map[_key.nextInvoiceDeadline] as int? ?? 0),
        nextInvoiceType: InvoiceType.fromString(map[_key.nextInvoiceKind] as String? ?? ''),
        openServiceRequestCount: counts[_key.openServiceRequest] ?? 0,
        serviceRequestCompletionCount:
            counts[_key.serviceRequestCompletion] ?? 0,
        serviceRequestCount: counts[_key.serviceRequest] ?? 0);
  }

  Map<String, Object?> toMap() {
    final map = super.toMap();
    (map[_key.counts] as Map? ?? {}).addAll({
      _key.openServiceRequest: openServiceRequestCount,
      _key.serviceRequestCompletion: serviceRequestCompletionCount,
      _key.serviceRequest: serviceRequestCount
    });

    map.addAll({
      _key.lateFee: lateFee?.toMap(),
      _key.property: property?.toMap(),
      _key.nextInvoiceDeadline: nextInvoiceDeadline?.secondsSinceEpoch,
      _key.nextInvoiceKind: nextInvoiceType?.toString()
    });

    return map;
  }
}
