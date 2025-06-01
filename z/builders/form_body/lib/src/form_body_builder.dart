import 'dart:async';

import 'package:flutter/material.dart';
import 'package:form/index.dart';
import 'package:form_submission_exception/index.dart';
import 'package:form_validation_exception/index.dart';
import 'package:haptics/index.dart';
import 'package:date/index.dart';
import 'package:date_picker_builder/index.dart';
import 'package:option_picker_builder/index.dart';
import 'package:labeled_value/index.dart';
import 'package:standard_icon_library/index.dart';
import 'package:icon_picker_builder/index.dart';
import 'package:labeled_icon/index.dart';
import 'package:time_picker_builder/index.dart';
import 'package:interval_frequency_picker_builder/index.dart';
import 'package:frequency_type/index.dart';
import 'package:roller_column_picker_builder/index.dart';
import 'package:artboard/index.dart';
import 'package:period_type/index.dart';
import 'package:tag_editor_builder/index.dart';
import 'package:meta_form_artboard_builder/index.dart';
import 'package:semantic_theme/index.dart';
import '_components/keyboard_accessory_buttons/index.dart';
import '_components/standard_stream_form.dart';
import 'form_status.dart';

mixin FormBodyBuilder implements StatefulWidget {
  /// Use buildInitialFieldData
  @deprecated
  Future<List<StreamableFormFieldData>> get initialFieldData async =>
      Future.value([]);

  Future<List<StreamableFormFieldData>> buildInitialFieldData(
          BuildContext context) async =>
      Future.value([]);

  /// Use buildInitialSectionData
  @deprecated
  Future<List<StreamableFormSectionData>> get initialSectionData async =>
      Future.value([]);

  Future<List<StreamableFormSectionData>> buildInitialSectionData(
          BuildContext context) async =>
      Future.value([]);

  Future<StreamableFormData>? get initialFormData => null;

  String get submitButtonText;
  bool get canSubmitWithKeyboardRaised => true;

  StreamFormBloc get form => _form.bloc;

  final _form = StandardStreamForm();

  // An opportunity for forms to throw an exception before being submitted.
  Future<void> validate() async {}
  Future<void> submit(BuildContext context);

  // An opportunity for forms to setup additional properties before building.
  void setupFields(
    BuildContext context, {
    required List<StreamableFormFieldData> fieldData,
  }) {}

  DatePickerBuilder buildDatePicker(
    BuildContext context, {
    @required Date selectedDate,
  });

  OptionPickerArtboardBuilder buildOptionPicker(
    BuildContext context, {
    String title,
    String emptyText,
    List<LabeledValue> selectedOptions,
    @required List<LabeledValue> options,
    bool isMultiSelect,
  });

  IconPickerArtboardBuilder buildIconPicker(
    BuildContext context, {
    String title,
    LabeledIcon selectedOption,
    List<LabeledIcon> options,
  });

  TimePickerArtboardBuilder buildTimePicker(
    BuildContext context, {
    TimeOfDay selectedTime,
  });

  IntervalFrequencyPickerArtboardBuilder buildIntervalFrequencyPicker(
    BuildContext context, {
    FrequencyType selectedSchedule,
    List<LabeledValue<int>> intervalList,
    List<LabeledValue<PeriodType>> periodList,
  });

  RollerColumnPickerArtboardBuilder buildRollerColumnPicker<T>(
    BuildContext context, {
    LabeledValue<T> selectedValue,
    List<LabeledValue<T>> options,
    bool infiniteScroll,
  });

  TagEditorArtboardBuilder buildTagEditor(
    BuildContext context, {
    List<String> tags,
  });

  MetaFormArtboardBuilder<T> buildMetaForm<T>(
    BuildContext context, {
    String title,
    Future<List<StreamableFormFieldData>> fieldsData,
    T Function(List<StreamableFormFieldData>) valueFromFieldsData,
    String submitButtonText,
    void Function() validateForm,
  });

  Future<T> goTo<T>({
    @required BuildContext context,
    @required Artboard<T> artboard,
  });

  void onFocusChanged({
    @required BuildContext context,
    @required bool isInFocus,
  });

  void setupFieldDataOnTapListeners(
    BuildContext context, {
    required List<StreamableFormFieldData> fieldData,
  }) async {
    for (final data in fieldData) {
      if (data is FormDatePickerFieldData)
        data.addOnTapListener(
          _dateFieldOnTap(context, data),
        );
      if (data is FormOptionPickerFieldData)
        data.addOnTapListener(
          _optionPickerFieldOnTap(context, data),
        );
      if (data is FormIconPickerFieldData)
        data.addOnTapListener(
          _iconPickerFieldOnTap(context, data),
        );
      if (data is FormTimePickerFieldData)
        data.addOnTapListener(
          _timePickerFieldOnTap(context, data),
        );
      if (data is FormIntervalFrequencyPickerFieldData)
        data.addOnTapListener(
          _intervalFrequencyPickerFieldOnTap(context, data),
        );
      if (data is FormRollerColumnPickerFieldData)
        data.addOnTapListener(
          _rollerColumnPickerFieldOnTap(context, data),
        );
      if (data is FormTagFieldData)
        data.addOnTapListener(
          _tagFieldOnTap(context, data),
        );
      if (data is MetaFormFieldData)
        data.addOnTapListener(
          _metaFormFieldOnTap(context, data),
        );
    }
  }

  Future<void> _validateFields() async {
    await Future.wait(
      form.formData.fieldData
          .where((data) => data.isVisible == true)
          .map((data) async => await data.validate())
          .toList(),
    );
  }

  Function _dateFieldOnTap(
    BuildContext context,
    FormDatePickerFieldData data,
  ) =>
      () async {
        final artboard = buildDatePicker(
          context,
          selectedDate: data.value ?? Date.now(),
        );
        final time = await goTo<Date>(
          context: context,
          artboard: artboard,
        );
        data.value = time;
        form.updateFieldData(data);
      };

  Function _optionPickerFieldOnTap<T>(
    BuildContext context,
    FormOptionPickerFieldData data,
  ) =>
      () async {
        final convertedOptions = data.options
            ?.map((option) => LabeledValue(
                  label: option.label,
                  value: option.value,
                ))
            .toList();
        final convertedSelectedOptions = data.selectedOptions
            ?.map((option) => LabeledValue(
                  label: option.label,
                  value: option.value,
                ))
            .toList();
        final artboard = buildOptionPicker(
          context,
          title: data.title,
          selectedOptions: convertedSelectedOptions ?? [],
          options: convertedOptions ?? [],
        );
        final newSelectedOptions = await goTo<List<LabeledValue>>(
          context: context,
          artboard: artboard,
        );
        data.selectedOptions = newSelectedOptions
            .map(
              (option) => FormLabeledValue(
                label: option.label,
                value: option.value,
              ),
            )
            .toList();
        form.updateFieldData(data);
      };

  Function _iconPickerFieldOnTap(
    BuildContext context,
    FormIconPickerFieldData data,
  ) =>
      () async {
        final artboard = buildIconPicker(
          context,
          title: data.title,
          options: data.options?.map(
                (option) => LabeledIcon(icon: option.icon ?? StandardIcon.add, label: option.label),
              )
              .toList() ?? [],
          selectedOption: data.selectedOption != null
              ? LabeledIcon(icon: data.selectedOption!.icon ?? StandardIcon.add, label: data.selectedOption!.label)
              : LabeledIcon(icon: StandardIcon.add, label: ""),
        );
        final newSelectedOption = await goTo<LabeledIcon>(
          context: context,
          artboard: artboard,
        );
        data.selectedOption = FormLabeledIcon(
          icon: newSelectedOption.icon,
          title: newSelectedOption.label,
        );
        form.updateFieldData(data);
      };

  Function _timePickerFieldOnTap(
    BuildContext context,
    FormTimePickerFieldData data,
  ) =>
      () async {
        final artboard = buildTimePicker(
          context,
          selectedTime: data.value ?? TimeOfDay.now(),
        );
        final newSelectedTime = await goTo<TimeOfDay>(
          context: context,
          artboard: artboard,
        );
        data.value = newSelectedTime;
        form.updateFieldData(data);
      };

  Function _intervalFrequencyPickerFieldOnTap(
    BuildContext context,
    FormIntervalFrequencyPickerFieldData data,
  ) =>
      () async {
        final artboard = buildIntervalFrequencyPicker(
          context,
          selectedSchedule: FrequencyType(
            interval: data.value?.interval ?? 0,
            frequency: data.value?.frequency ?? PeriodType.fromString('week'),
          ),
          periodList: data.periodList,
          intervalList: data.intervalList,
        );
        final newSelectedSchedule = await goTo<FrequencyType>(
          context: context,
          artboard: artboard,
        );
        data.value = FormIntervalFrequencyOptionData(
          frequency: newSelectedSchedule.frequency,
          interval: newSelectedSchedule.interval,
        );
        form.updateFieldData(data);
      };

  Function _rollerColumnPickerFieldOnTap(
    BuildContext context,
    FormRollerColumnPickerFieldData data,
  ) =>
      () async {
        final artboard = buildRollerColumnPicker(
          context,
          selectedValue: data.value ?? LabeledValue(label: "", value: ""),
          options: data.options,
          infiniteScroll: data.infiniteScroll,
        );
        final newSelectedValue = await goTo(
          context: context,
          artboard: artboard,
        );
        data.value = newSelectedValue;
        form.updateFieldData(data);
      };

  Function _tagFieldOnTap(
    BuildContext context,
    FormTagFieldData data,
  ) =>
      () async {
        final artboard = buildTagEditor(
          context,
          tags: data.tags ?? [],
        );
        final newSelectedValue = await goTo(
          context: context,
          artboard: artboard,
        );
        data.tags = newSelectedValue;
        form.updateFieldData(data);
      };

  Function _metaFormFieldOnTap(
    BuildContext context,
    MetaFormFieldData data,
  ) =>
      () async {
        final artboard = buildMetaForm(
          context,
          title: data.title,
          fieldsData: data.fieldsData,
          valueFromFieldsData: data.valueFromFieldsData,
        );
        final newFormResult = await goTo(
          context: context,
          artboard: artboard,
        );
        if (newFormResult == null) return;
        data.value = newFormResult;
        form.updateFieldData(data);
      };

  void disposeOfForm() => _form.dispose();
}

mixin FormBodyBuilderState<T extends FormBodyBuilder> implements State<T> {
  FormValidationException? validationException;
  FormSubmissionException? submissionException;
  FormSubmitStatus formSubmitState = FormSubmitStatus.ready;

  bool _hasSetUp = false;

  bool _shouldHideButtons = false;
  bool get shouldHideButtons => _shouldHideButtons;
  set shouldHideButtons(bool shouldHide) {
    setState(
      () => _shouldHideButtons = shouldHide,
    );
  }

  StandardStreamForm buildFormBody(BuildContext context) {
    _load(context);
    widget.form.addOnValueChangedListener(_restoreState);
    return widget._form;
  }

  Future onSubmitButtonTap(BuildContext context) async {
    _clearExceptions(context);
    widget.form.disableFields();

    try {
      await widget._validateFields();
      await widget.validate();
    } on FormValidationException catch (e) {
      _handleException(context, e);
      widget.form.enableFields();

      return;
    }

    _handleLoading(context);

    try {
      await widget.submit(context);
    } on TimeoutException catch (_) {
      _handleException(context, FormSubmissionException.didTimeout());
      widget.form.enableFields();

      return;
    }

    widget.form.enableFields();
    _restoreState();
  }

  void addFocusChangedListeners() {
    widget.form.addOnFocusChangedListener(_focusChangedListener);
  }

  void removeFocusListeners() {
    widget.disposeOfForm();
  }

  void _load(BuildContext context) async {
    //No need to load twice. This line also allows artboards to
    //only need to define the formData that will initially be on screen

    final formData = await _createInitialFormData(context);
    _setupIfNeeded(
      context,
      fieldData: formData?.fieldData ?? [],
    );
    if (formData != null) widget.form.update(formData);
  }

  Widget _buildSubmitKeyboardAccessory(BuildContext context) {
    return PrimaryActionKeyboardAccessoryButton(
      onTap: () {
        widget._form.resignFocus(context);
        onSubmitButtonTap(context);
      },
      title: widget.submitButtonText,
    );
  }

  Future<StreamableFormData?> _createInitialFormData(
    BuildContext context,
  ) async {
    final formData = await widget.initialFormData;
    if (formData != null) return formData;

    final theme = SemanticTheme.of(context);

    final _builtSectionData = await widget.buildInitialSectionData(context);
    final sectionData = _builtSectionData;
    if (sectionData.isNotEmpty) {
      return StreamableFormData(
        sectionData: sectionData,
        fieldHorizontalSpacing: theme?.distance.spacing.horizontal.min ?? 0,
        fieldVerticalSpacing: theme?.distance.spacing.vertical.min ?? 0,
        sectionVerticalSpacing: theme?.distance.spacing.vertical.large ?? 0,
        submitKeyboardAccessory: _buildSubmitKeyboardAccessory(context),
        canSubmitWithKeyboardRaised: widget.canSubmitWithKeyboardRaised,
      );
    }

    final _builtFieldData = await widget.buildInitialFieldData(context);
    final fieldData = _builtFieldData;

    if (fieldData.isNotEmpty) {
      return StreamableFormData.withFields(
        fieldData: fieldData,
        fieldHorizontalSpacing: theme?.distance.spacing.horizontal.min ?? 0,
        fieldVerticalSpacing: theme?.distance.spacing.vertical.min ?? 0,
        sectionVerticalSpacing: theme?.distance.spacing.vertical.large ?? 0,
        submitKeyboardAccessory: _buildSubmitKeyboardAccessory(context),
        canSubmitWithKeyboardRaised: widget.canSubmitWithKeyboardRaised,
      );
    }

    return null;
  }

  void _setupIfNeeded(
    BuildContext context, {
    required List<StreamableFormFieldData> fieldData,
  }) {
    if (_hasSetUp) return;
    widget.setupFieldDataOnTapListeners(context, fieldData: fieldData);
    widget.setupFields(context, fieldData: fieldData);
    _hasSetUp = true;
  }

  void _handleException(
    BuildContext context,
    Exception exception,
  ) {
    setState(() {
      if (exception is FormValidationException) {
        validationException = exception;
      }
      if (exception is FormSubmissionException) {
        submissionException = exception;
      }
      formSubmitState = FormSubmitStatus.exception;
    });
    triggerHaptic(HapticOption.medium);
  }

  void _clearExceptions(BuildContext context) {
    setState(() {
      validationException = null;
      submissionException = null;
      formSubmitState = FormSubmitStatus.ready;
    });
  }

  void _handleLoading(BuildContext context) {
    if (formSubmitState == FormSubmitStatus.loading) return;
    setState(() => formSubmitState = FormSubmitStatus.loading);
  }

  void _restoreState() {
    if (formSubmitState == FormSubmitStatus.ready) return;
    setState(() => formSubmitState = FormSubmitStatus.ready);
  }

  void _focusChangedListener(bool isInFocus) {
    shouldHideButtons = isInFocus;
    widget.onFocusChanged(context: context, isInFocus: isInFocus);
  }
}
