import 'package:domain/index.dart';
import 'package:date/index.dart';
import 'package:balance/index.dart';
import 'package:domain_user/index.dart';
import 'package:location/index.dart';
import 'package:key/index.dart' as _key;

class Roof extends Domain {
  final Set<Balance>? balances;
  final int? reminderCompletionCount;
  final int? assignedReminderCount;
  final int? dueReminderCount;
  final int? outOfStockShoppingItemCount;
  final int? shoppingItemCompletionCount;

  Roof(
      {String? guid,
      Date? dateCreated,
      String? creatorGuid,
      int? unreadCommentableObjectCount,
      int? pinnedCommentableObjectCount,
      String? name,
      Set<DomainUser>? users,
      Set<DomainUser>? formerUsers,
      Location? location,
      int? expenseCount,
      int? reminderCount,
      int? transferCount,
      this.balances,
      this.reminderCompletionCount,
      this.assignedReminderCount,
      this.dueReminderCount,
      this.outOfStockShoppingItemCount,
      this.shoppingItemCompletionCount})
      : super(
            guid: guid,
            dateCreated: dateCreated,
            creatorGuid: creatorGuid,
            unreadCommentableObjectCount: unreadCommentableObjectCount,
            pinnedCommentableObjectCount: pinnedCommentableObjectCount,
            name: name,
            users: users,
            formerUsers: formerUsers,
            location: location,
            expenseCount: expenseCount,
            reminderCount: reminderCount,
            transferCount: transferCount);

  factory Roof.fromMap(Map<String?, Object?> map) {
    final domain = Domain.fromMap(map);
    final counts = map[_key.counts] as Map? ?? {};

    final balances =
        (map[_key.balances] as List? ?? []).map((map) => Balance.fromMap(map));

    return Roof(
        guid: domain.guid,
        dateCreated: domain.dateCreated,
        creatorGuid: domain.creatorGuid,
        unreadCommentableObjectCount: domain.unreadCommentableObjectCount,
        pinnedCommentableObjectCount: domain.pinnedCommentableObjectCount,
        expenseCount: domain.expenseCount,
        reminderCount: domain.reminderCount,
        transferCount: domain.transferCount,
        name: domain.name,
        users: domain.users,
        formerUsers: domain.formerUsers,
        location: domain.location,
        balances: balances.toSet(),
        reminderCompletionCount: counts[_key.reminderCompletion] ?? 0,
        assignedReminderCount: counts[_key.assignedReminder] ?? 0,
        dueReminderCount: counts[_key.dueReminder] ?? 0,
        outOfStockShoppingItemCount: counts[_key.outOfStockShoppingItem] ?? 0,
        shoppingItemCompletionCount: counts[_key.shoppingItemCompletion] ?? 0);
  }

  Map<String, Object?> toMap() {
    final map = super.toMap();
    (map[_key.counts] as Map? ?? {}).addAll({
      _key.reminderCompletion: reminderCompletionCount,
      _key.assignedReminder: assignedReminderCount,
      _key.dueReminder: dueReminderCount,
      _key.outOfStockShoppingItem: outOfStockShoppingItemCount,
      _key.shoppingItemCompletion: shoppingItemCompletionCount
    });

    map.addAll({_key.balances: balances?.map((balance) => balance.toMap())});

    return map;
  }
}
