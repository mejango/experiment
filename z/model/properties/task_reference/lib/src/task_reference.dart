import 'package:task_type/index.dart';
import 'package:date/index.dart';

import 'package:key/index.dart' as _key;
import 'package:mappable/index.dart';

class TaskReference with Mappable {
  final String? guid;
  final String? name;
  final TaskType? type;
  final Date? deadline;

  TaskReference({this.guid, this.name, this.type, this.deadline});

  factory TaskReference.fromMap(Map<String?, Object?> map) {
    return TaskReference(
        guid: map[_key.guid] as String?,
        name: map[_key.name] as String?,
        type: TaskType.fromString(map[_key.kind] as String),
        deadline: Date.fromSecondsSinceEpoch(map[_key.deadline] as int));
  }

  @override
  Map<String, Object?> toMap() {
    return {
      _key.guid: guid,
      _key.name: name,
      _key.kind: type?.toString(),
      _key.deadline: deadline?.secondsSinceEpoch
    };
  }
}
