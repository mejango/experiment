import 'package:key/index.dart' as _key;
import 'package:mappable/index.dart';

class DateParts with Mappable {
  final int? time;
  final int? day;
  final int? month;
  final int? year;

  DateParts({this.time, this.day, this.month, this.year});

  factory DateParts.fromMap(Map<String?, Object?> map) {
    return DateParts(
        time: map[_key.time] as int?,
        day: map[_key.day] as int?,
        month: map[_key.month] as int?,
        year: map[_key.year] as int?);
  }

  @override
  Map<String, Object?> toMap() {
    return {_key.time: time, _key.day: day, _key.month: month, _key.year: year};
  }
}
