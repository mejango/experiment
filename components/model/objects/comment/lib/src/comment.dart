import 'package:fee_payer_type/index.dart';
import 'package:feed_object/index.dart';
import 'package:user_reference/index.dart';
import 'package:name_user/index.dart';
import 'package:name_defining_object/index.dart';
import 'package:commentable_object_reference/index.dart';
import 'package:stub/index.dart';
import 'package:name_formatter/index.dart';
import 'package:key/index.dart' as _key;

class Comment extends FeedObject {
  final String? name;
  final String? body;
  final bool? edited;
  final bool? unread;
  final UserReference? user;
  final CommentableObjectReference? commentableObject;

  Comment(
      {Set<NameUser>? contractDomainUsers,
      Set<NameUser>? contractUsers,
      Set<NameUser>? formerContractUsers,
      Set<Stub>? contractStubs,
      Set<Stub>? formerContractStubs,
      String? contractPropertyName,
      FeePayerType? feePayerType,
      String? clientReferenceId,
      this.name,
      this.body,
      this.edited,
      this.unread,
      this.user,
      this.commentableObject})
      : super(
            contractDomainUsers: contractDomainUsers,
            contractUsers: contractUsers,
            formerContractUsers: formerContractUsers,
            contractStubs: contractStubs,
            formerContractStubs: formerContractStubs,
            contractPropertyName: contractPropertyName,
            feePayerType: feePayerType,
            clientReferenceId: clientReferenceId);

  factory Comment.fromMap(Map<String?, Object?> map) {
    final feedObject = FeedObject.fromMap(map);
    return Comment(
        contractDomainUsers: feedObject.contractDomainUsers,
        contractUsers: feedObject.contractUsers,
        formerContractUsers: feedObject.formerContractUsers,
        contractStubs: feedObject.contractStubs,
        formerContractStubs: feedObject.formerContractStubs,
        contractPropertyName: feedObject.contractPropertyName,
        feePayerType: feedObject.feePayerType,
        clientReferenceId: feedObject.clientReferenceId,
        name: map[_key.name] as String?,
        body: map[_key.body] as String?,
        edited: map[_key.edited] as bool?,
        unread: map[_key.unread] as bool?,
        user: UserReference.fromMap(map[_key.user] as Map<String, Object?>? ?? {}),
        commentableObject:
            CommentableObjectReference.fromMap(map[_key.object] as Map<String, Object?>? ?? {}));
  }

  Map<String, Object?> toMap() {
    final map = super.toMap();
    map.addAll({
      _key.name: name,
      _key.body: body,
      _key.edited: edited,
      _key.unread: unread,
      _key.user: user?.toMap(),
      _key.object: commentableObject?.toMap()
    });
    return map;
  }

  String? formattedUser(
      {String? sessionOwnerGuid,
      required NameDefiningObject nameDefiningObject,
      bool firstPerson = false}) {
    return formatNames(
        guids: [user?.guid ?? ''],
        sessionOwnerGuid: sessionOwnerGuid ?? '',
        nameDefiningObject: nameDefiningObject,
        firstPerson: firstPerson);
  }
}
