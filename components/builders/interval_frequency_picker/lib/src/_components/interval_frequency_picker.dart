import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:period_type/index.dart';
import 'package:labeled_value/index.dart';
import 'package:roller_column_builder/index.dart';
import 'package:frequency_type/index.dart';
import 'package:semantic_theme/index.dart';

class IntervalFrequencyPicker extends StatefulWidget {
  final FrequencyType? selectedValue;
  final List<LabeledValue<int>>? intervalList;
  final List<LabeledValue<PeriodType>>? periodList;
  final Function(FrequencyType)? onChanged;

  IntervalFrequencyPicker({
    this.selectedValue,
    this.intervalList,
    this.periodList,
    this.onChanged,
  });

  IntervalFrequencyPickerState createState() => IntervalFrequencyPickerState();
}

class IntervalFrequencyPickerState extends State<IntervalFrequencyPicker>
    with RollerColumnBuilder {
  FrequencyType? _selectedSchedule;

  @override
  void initState() {
    _selectedSchedule = widget.selectedValue ??
        FrequencyType(
          interval: widget.intervalList?.first.value ?? 0,
          frequency: widget.periodList?.first.value ?? PeriodType.fromString('week'),
        );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = SemanticTheme.of(context);

    final double columnSpacing = theme?.distance?.spacing?.horizontal?.large ?? 0;

    final Widget intervalColumn = Flexible(
      child: Container(
        padding: EdgeInsets.only(right: columnSpacing / 2),
        child: buildRollerColumn<int>(
          context,
          list: widget.intervalList ?? [],
          selectedValue: _rollerColumnDataFromInterval(
            _selectedSchedule?.interval ?? 0,
          ),
          crossAxisAlignment: CrossAxisAlignment.end,
          onChange: _onIntervalChange,
        ),
      ),
    );

    final Widget frequencyColumn = Flexible(
      child: Container(
        padding: EdgeInsets.only(left: columnSpacing / 2),
        child: buildRollerColumn<PeriodType>(
          context,
          list: widget.periodList ?? [],
          selectedValue: _rollerColumnDataFromFrequency(
            _selectedSchedule?.frequency ?? PeriodType.fromString('week'),
          ),
          crossAxisAlignment: CrossAxisAlignment.start,
          onChange: _onFrequencyChange,
        ),
      ),
    );

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: theme?.distance?.padding?.vertical?.medium ?? 0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          intervalColumn,
          frequencyColumn,
        ],
      ),
    );
  }

  LabeledValue<int>? _rollerColumnDataFromInterval(int val) {
    for (LabeledValue<int> data in widget.intervalList ?? []) {
      if (data.value == val) return data;
    }
    return null;
  }

  LabeledValue<PeriodType>? _rollerColumnDataFromFrequency(PeriodType val) {
    for (LabeledValue<PeriodType> data in widget.periodList ?? []) {
      if (data.value.toString() == val.toString()) return data;
    }
    return null;
  }

  void _onIntervalChange(LabeledValue<int> newVal) {
    if (_selectedSchedule?.interval != newVal.value) {
      setState(() {
        _selectedSchedule = FrequencyType(
          interval: newVal.value,
          frequency: _selectedSchedule?.frequency ?? PeriodType.fromString('week'),
        );
      });
      widget.onChanged?.call(_selectedSchedule!);
    }
  }

  void _onFrequencyChange(LabeledValue<PeriodType> newVal) {
    if (_selectedSchedule?.frequency != newVal.value) {
      setState(() {
        _selectedSchedule = FrequencyType(
          interval: _selectedSchedule?.interval ?? 0,
          frequency: newVal.value,
        );
      });
      widget.onChanged?.call(_selectedSchedule!);
    }
  }
}
