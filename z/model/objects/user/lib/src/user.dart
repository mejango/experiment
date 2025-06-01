import 'package:date/index.dart';
import 'package:privacy_type/index.dart';
import 'package:notification_category_type/index.dart';
import 'package:email_category_type/index.dart';
import 'package:model_object/index.dart';
import 'package:name_domain/index.dart';
import 'package:name_contract/index.dart';
import 'package:name_payment_profile/index.dart';
import 'package:payment_default/index.dart';
import 'package:billing/index.dart';
import 'package:key/index.dart' as _key;

class User extends ModelObject {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phoneNumber;
  final Set<NameDomain>? nameDomains;
  final Set<NameContract>? nameContracts;
  final Set<NamePaymentProfile>? namePaymentProfiles;
  final Set<PaymentDefault>? paymentDefaults;
  final PrivacyType? privacyType;
  final bool? tfaEnabled;
  final bool? textNotificationsEnabled;
  final int? badgeCount;
  final Set<NotificationCategoryType>? notificationUnsubscribes;
  final Set<EmailCategoryType>? emailUnsubscribes;
  final Billing? billing;

  const User(
      {required String guid,
      required Date dateCreated,
      required String creatorGuid,
      required this.firstName,
      required this.lastName,
      required this.email,
      this.phoneNumber,
      required this.nameDomains,
      required this.nameContracts,
      required this.namePaymentProfiles,
      required this.paymentDefaults,
      required this.privacyType,
      required this.tfaEnabled,
      required this.textNotificationsEnabled,
      required this.badgeCount,
      required this.notificationUnsubscribes,
      required this.emailUnsubscribes,
      required this.billing})
      : assert(firstName != null),
        assert(lastName != null),
        assert(email != null),
        assert(nameDomains != null),
        assert(nameContracts != null),
        assert(namePaymentProfiles != null),
        assert(paymentDefaults != null),
        assert(privacyType != null),
        assert(tfaEnabled != null),
        assert(textNotificationsEnabled != null),
        assert(badgeCount != null),
        assert(notificationUnsubscribes != null),
        assert(emailUnsubscribes != null),
        assert(billing != null),
        super(guid: guid, dateCreated: dateCreated, creatorGuid: creatorGuid);

  static User fromMap(Map<String?, Object?> map) {
    final object = ModelObject.fromMap(map);
    final name = map[_key.name] as Map;
    final nameDomains =
        (map[_key.domains] as List).map((map) => NameDomain.fromMap(map));
    final nameContracts =
        (map[_key.domains] as List).map((map) => NameContract.fromMap(map));
    final namePaymentProfiles = (map[_key.paymentProfiles] as List)
        .map((map) => NamePaymentProfile.fromMap(map));
    final paymentDefaults = (map[_key.paymentDefaults] as List)
        .map((map) => PaymentDefault.fromMap(map));
    final emailUnsubscribes = (map[_key.emailUnsubscribes] as List).map(
        (emailUnsubscribe) => EmailCategoryType.fromString(emailUnsubscribe));
    final notificationUnsubscribes =
        (map[_key.notificationUnsubscribes] as List).map(
            (notificationUnsubscribe) =>
                NotificationCategoryType.fromString(notificationUnsubscribe));
    final billing = Billing.fromMap(map[_key.billing] as Map<String, Object>);

    return User(
        guid: object.guid,
        dateCreated: object.dateCreated,
        creatorGuid: object.creatorGuid,
        firstName: name[_key.first],
        lastName: name[_key.last],
        email: map[_key.email] as String?,
        phoneNumber: map[_key.phoneNumber] as String?,
        nameDomains: nameDomains.toSet(),
        nameContracts: nameContracts.toSet(),
        namePaymentProfiles: namePaymentProfiles.toSet(),
        paymentDefaults: paymentDefaults.toSet(),
        privacyType: PrivacyType.fromString(map[_key.defaultPrivacyKind] as String),
        tfaEnabled: map[_key.tfaEnabled] as bool?,
        textNotificationsEnabled: map[_key.textNotificationsEnabled] as bool?,
        badgeCount: map[_key.badgeCount] as int?,
        notificationUnsubscribes: notificationUnsubscribes.toSet(),
        emailUnsubscribes: emailUnsubscribes.toSet(),
        billing: billing);
  }

  @override
  Map<String, Object?> toMap() {
    final map = super.toMap();
    map.addAll({
      _key.name: {_key.first: firstName, _key.last: lastName},
      _key.email: email as Object,
      _key.phoneNumber: phoneNumber as Object,
      _key.domains: nameDomains?.map((nameDomain) => nameDomain.toMap()) as Object,
      _key.contracts: nameContracts?.map((nameContract) => nameContract.toMap()) as Object,
      _key.paymentProfiles: namePaymentProfiles
          ?.map((namePaymentProfile) => namePaymentProfile.toMap()) as Object,
      _key.paymentDefaults:
          paymentDefaults?.map((paymentDefaults) => paymentDefaults.toMap()) as Object,
      _key.defaultPrivacyKind: privacyType?.toString() as Object,
      _key.tfaEnabled: tfaEnabled as Object,
      _key.textNotificationsEnabled: textNotificationsEnabled as Object,
      _key.badgeCount: badgeCount as Object,
      _key.notificationUnsubscribes: notificationUnsubscribes
          ?.map((notificationUnsubscribe) => notificationUnsubscribe.toString()) as Object,
      _key.emailUnsubscribes: emailUnsubscribes
          ?.map((emailUnsubscribe) => emailUnsubscribe.toString()) as Object,
      _key.billing: billing?.toMap() as Object
    });

    return map;
  }
}
