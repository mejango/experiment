import 'package:period_type/index.dart';

import 'package:key/index.dart' as _key;
import 'package:mappable/index.dart';

class Schedule with Mappable {
  final PeriodType? periodType;
  final int? interval;
  final int? time;
  final Set<int>? days;
  final Set<int>? dates;

  Schedule(
      {this.periodType, this.interval, this.time, this.days, this.dates});

  factory Schedule.fromMap(Map<String?, Object?> map) {

    return Schedule(
      periodType: PeriodType.fromString(map[_key.frequencyKind] as String),
      interval: map[_key.interval] as int?,
      time: map[_key.time] as int?,
      days: map[_key.days] as Set<int>?,
      dates: map[_key.dates] as Set<int>?,
    );
  }

  @override
  Map<String, Object?> toMap() {
    return {
      _key.frequencyKind: periodType?.toString(),
      _key.interval: interval,
      _key.time: time,
      _key.days: days,
      _key.dates: dates
    };
  }
}
