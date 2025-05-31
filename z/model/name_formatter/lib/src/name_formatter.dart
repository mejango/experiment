import 'package:strings/strings.dart';
import 'package:stringify_names/index.dart';
import 'package:name_defining_object/index.dart';

String formatNames(
    {required List<String> guids,
    required String sessionOwnerGuid,
    NameDefiningObject? nameDefiningObject,
    bool useNicknames = true,
    bool useAllText = true,
    bool firstPerson = false}) {
  final orderedGuids = nameDefiningObject?.orderedUserGuids(
        guids: guids,
        sessionOwnerGuid: sessionOwnerGuid,
        useNicknames: useNicknames,
      )
      .toSet()
      .toList();

  final orderedNames = [];

  final allUserGuids = nameDefiningObject?.userGuids;
  if (orderedGuids != null &&
      orderedGuids.isNotEmpty &&
      useAllText &&
      allUserGuids != null &&
      allUserGuids.every((guid) => orderedGuids.contains(guid))) {
    orderedNames.add(Strings.toCapitalised(nameDefiningObject!.allText));
    orderedGuids.removeWhere((guid) => allUserGuids.contains(guid));
  }

  final orderedUserNames = orderedGuids?.map((guid) {
    return nameDefiningObject?.nameForGuid(
        guid: guid,
        sessionOwnerGuid: sessionOwnerGuid,
        useNickname: useNicknames,
        firstPerson: firstPerson);
  }).toList();

  orderedNames.addAll(orderedUserNames ?? []);

  return stringifyNames(orderedNames as List<String>);
}
