import 'mixins/index.dart';

int revCron(TimeSortable a, TimeSortable b) =>
    (a.timestamp ?? 0) > (b.timestamp ?? 0) ? -1 : 1;

int cron(TimeSortable a, TimeSortable b) =>
    (a.timestamp ?? 0) < (b.timestamp ?? 0) ? -1 : 1;
