import 'package:date/index.dart';
import 'package:context/index.dart';
import 'package:name_context/index.dart';
import 'package:contract_user/index.dart';
import 'package:name_contract_domain/index.dart';
import 'package:fee_payer_type/index.dart';
import 'package:name_user/index.dart';
import 'package:schedule/index.dart';
import 'package:key/index.dart' as _key;

class Contract extends Context {
  final Date? startDate;
  final Date? endDate;
  final String? name;
  final int? amount;
  final Set<ContractUser>? users;
  final Set<ContractUser>? formerUsers;
  final Schedule? schedule;
  final NameContractDomain? domain;
  final int? invoiceCount;
  final FeePayerType? feePayerType;
  final bool? monthToMonth;

  @override
  Set<String> get userGuids => users?.map((user) => user.guid) as Set<String>? ?? Set<String>();

  @override
  Set<String> get formerUserGuids => formerUsers?.map((user) => user.guid) as Set<String>? ?? Set<String>();

  @override
  Set<NameUser> get nameUsers {
    return users?.followedBy(formerUsers ?? Set<ContractUser>()).toSet() as Set<NameUser>? ?? Set<NameUser>();
  }

  @override
  Set<NameContext> get nameContexts => Set.of([domain as NameContext]);

  Contract(
      { String? guid,
      Date? dateCreated,
      String? creatorGuid,
      int? unreadCommentableObjectCount,
      int? pinnedCommentableObjectCount,
      this.startDate,
      this.endDate,
      this.amount,
      this.name,
      this.users,
      this.formerUsers,
      this.schedule,
      this.domain,
      this.invoiceCount,
      this.feePayerType,
      this.monthToMonth})
      :
        //Contracts will always be user made.
        assert(creatorGuid != null),
        assert(startDate != null),
        assert(endDate != null),
        assert(amount != null),
        assert(users != null),
        assert(formerUsers != null),
        assert(schedule != null),
        assert(invoiceCount != null),
        assert(feePayerType != null),
        assert(monthToMonth != null),
        super(
          guid: guid,
          dateCreated: dateCreated,
          creatorGuid: creatorGuid,
          unreadCommentableObjectCount: unreadCommentableObjectCount,
          pinnedCommentableObjectCount: pinnedCommentableObjectCount,
        );

  factory Contract.fromMap(Map<String?, Object?> map) {
    final context = Context.fromMap(map);
    final counts = map[_key.counts] as Map;

    final users =
        (map[_key.users] as List? ?? []).map((map) => ContractUser.fromMap(map));

    final formerUsers = (map[_key.formerUsers] as List? ?? [])
        .map((map) => ContractUser.fromMap(map))
        .toSet();

    return Contract(
        guid: context.guid,
        dateCreated: context.dateCreated,
        creatorGuid: context.creatorGuid,
        unreadCommentableObjectCount: context.unreadCommentableObjectCount,
        pinnedCommentableObjectCount: context.pinnedCommentableObjectCount,
        invoiceCount: counts[_key.invoice] ?? 0,
        startDate: Date.fromSecondsSinceEpoch(map[_key.startTimestamp] as int),
        endDate: Date.fromSecondsSinceEpoch(map[_key.endTimestamp] as int),
        name: map[_key.name] as String?,
        amount: map[_key.amount] as int?,
        users: users.toSet(),
        formerUsers: formerUsers.toSet(),
        schedule: Schedule.fromMap(map[_key.schedule] as Map<String, Object>),
        domain: NameContractDomain.fromMap(map[_key.domain] as Map<String, Object>),
        feePayerType: FeePayerType.fromString(map[_key.feePayerKind] as String),
        monthToMonth: map[_key.monthToMonth] as bool?);
  }

  Map<String, Object?> toMap() {
    final map = super.toMap();
    (map[_key.counts] as Map).addAll({_key.invoice: invoiceCount});

    map.addAll({
      _key.startTimestamp: startDate?.secondsSinceEpoch,
      _key.endTimestamp: endDate?.secondsSinceEpoch,
      _key.name: name,
      _key.amount: amount,
      _key.users: users?.map((user) => user.toMap()) as Object,
      _key.formerUsers: users?.map((formerUsers) => formerUsers.toMap()) as Object,
      _key.schedule: schedule?.toMap() as Object,
      _key.domain: domain?.toMap() as Object,
      _key.feePayerKind: feePayerType.toString(),
      _key.monthToMonth: monthToMonth
    });

    return map;
  }
}
