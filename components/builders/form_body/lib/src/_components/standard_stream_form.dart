import 'package:button_builder/index.dart';
import 'package:flutter/material.dart';
import 'package:form/index.dart';
import 'package:form_body_builder/src/_components/fields/interval_frequency_picker_field.dart';
import 'package:form_body_builder/src/_components/fields/meta_form_field.dart';
import 'package:form_body_builder/src/_components/removable_field_container.dart';
import 'package:frequency_type/index.dart';
import 'package:period_type/index.dart';
import 'package:standard_icon_library/index.dart';
import 'package:header_builder/index.dart';
import 'package:labeled_icon/index.dart';
import 'package:keyboard_accessory/index.dart';
import 'package:keyboard_accessory_bar_builder/index.dart';
import 'package:labeled_value/index.dart';
import 'keyboard_accessory_buttons/index.dart';
import 'field_container.dart';
import 'fields/text_area.dart';
import 'fields/text_field.dart';
import 'fields/switch_field.dart';
import 'fields/date_picker_field.dart';
import 'fields/time_picker_field.dart';
import 'fields/option_picker_field.dart';
import 'fields/icon_picker_field.dart';
import 'package:semantic_theme/index.dart';
import 'fields/roller_column_picker_field.dart';
import 'fields/tag_field.dart';

class StandardStreamForm extends StreamForm
    with
        KeyboardAccessoryBarBuilder,
        SectionHeaderBuilder,
        SecondaryCenterButtonBuilder {
  static const _nextKeyboardTitle = "Next";
  static const _doneKeyboardTitle = "Done";

  final _focusNodeManager = _FocusNodeManager();
  final Map<FormCompositionFieldData, bool> _changingFocusMap = {};

  List<FormCompositionFieldData> get _allCompositionFieldData {
    final allFieldData = bloc.formData?.fieldData ?? [];
    final allTextFieldData = allFieldData
        .where((data) => data.isVisible)
        .whereType<FormTextFieldData>()
        .toList();
    final allTextAreaData = allFieldData
        .where((data) => data.isVisible)
        .whereType<FormTextAreaData>()
        .toList();
    List<FormCompositionFieldData> allCompositionFieldData = [];
    allCompositionFieldData.addAll(allTextFieldData);
    allCompositionFieldData.addAll(allTextAreaData);
    return allCompositionFieldData;
  }

  bool _isChangingFocus(FormCompositionFieldData fieldData) {
    return _changingFocusMap[fieldData] ?? false;
  }

  void _setChangingFocus(FormCompositionFieldData fieldData, bool value) {
    _changingFocusMap[fieldData] = value;
  }

  Widget buildTextField({
    required FormTextFieldData fieldData,
    required StreamableFormData formData,
    required int fieldIndex,
    required int sectionIndex,
    required BuildContext context,
  }) {
    final inputAction = _getInputActionForCompositionFieldData(fieldData);
    final focusNode = _focusNodeManager.nodeFor(fieldData, context);

    return StandardTextField(
      autofocus: fieldData.autofocus,
      fieldName: fieldData.title,
      placeholder: fieldData.placeholder,
      initialValue: fieldData.value,
      keyboardType: fieldData.keyboardType,
      textInputAction: inputAction,
      isPassword: fieldData.isPassword,
      mask: fieldData.mask,
      onChanged: (value) {
        _onCompositionViewChanged(fieldData, value);
        _updateKeyboardAccessoryButton(
          fieldData: fieldData,
          formData: formData,
          context: context,
        );
      },
      onSubmitted: (value, context) {
        _onCompositionViewSubmitted(fieldData, value, context);
      },
      onFocusChanged: (isInFocus) {
        if (isInFocus) {
          _updateKeyboardAccessoryButton(
            fieldData: fieldData,
            formData: formData,
            context: context,
          );
        }
        _onCompositionViewFocusChanged(fieldData, isInFocus, context);
      },
      focusNode: focusNode,
    );
  }

  Widget buildTextArea({
    required FormTextAreaData fieldData,
    required StreamableFormData formData,
    required int fieldIndex,
    required int sectionIndex,
    required BuildContext context,
  }) {
    final inputAction = _getInputActionForCompositionFieldData(fieldData);

    return TextArea(
      autofocus: fieldData.autofocus,
      fieldName: fieldData.title,
      placeholder: fieldData.placeholder,
      initialValue: fieldData.value,
      textInputAction: inputAction,
      keyboardType: fieldData.keyboardType,
      onChanged: (value) {
        _onCompositionViewChanged(fieldData, value);
        _updateKeyboardAccessoryButton(
          fieldData: fieldData,
          formData: formData,
          context: context,
        );
      },
      onSubmitted: (value, context) {
        _onCompositionViewSubmitted(fieldData, value, context);
      },
      onFocusChanged: (isInFocus) {
        if (isInFocus) {
          _updateKeyboardAccessoryButton(
            fieldData: fieldData,
            formData: formData,
            context: context,
          );
        }
        _onCompositionViewFocusChanged(fieldData, isInFocus, context);
      },
      focusNode: _focusNodeManager.nodeFor(fieldData, context),
    );
  }

  Widget buildSwitchField({
    required FormSwitchFieldData fieldData,
    required int fieldIndex,
    required int sectionIndex,
    required BuildContext context,
  }) {
      return SwitchField(
        title: fieldData.title,
        initialValue: fieldData.value ?? false,
        onChanged: (value) {
          resignFocus(context);
          fieldData.onChanged(value);
        },
      );
  }

  Widget buildDateField({
    required FormDatePickerFieldData fieldData,
    required StreamableFormData formData,
    required int fieldIndex,
    required int sectionIndex,
    required BuildContext context,
  }) =>
      DatePickerField(
        title: fieldData.title,
        initialValue: fieldData.value,
        startBound: fieldData.startBound,
        endBound: fieldData.endBound,
        onTap: fieldData.onTap,
      );

  Widget buildOptionPickerField<T>({
    required FormOptionPickerFieldData<T> fieldData,
    required int fieldIndex,
    required int sectionIndex,
  }) =>
      OptionPickerField<T>(
        title: fieldData.title,
        emptyText: fieldData.emptyText,
        isMultiSelect: fieldData.isMultiSelect,
        selectedOptions: fieldData.selectedOptions
            ?.map(
              (option) => LabeledValue(
                label: option.label,
                value: option.value,
              ),
            ).toList(),
        options: fieldData.options
            ?.map(
              (option) => LabeledValue(
                label: option.label,
                value: option.value,
              ),
            ).toList(),
        onTap: fieldData.onTap,
      );

  Widget buildTimeSelect({
    required FormTimePickerFieldData fieldData,
    required int fieldIndex,
    required int sectionIndex,
  }) =>
      TimePickerField(
        title: fieldData.title,
        initialValue: fieldData.value,
        onTap: fieldData.onTap,
      );

  Widget buildRollerColumnPickerField<T>({
    required FormRollerColumnPickerFieldData<T> fieldData,
    required int fieldIndex,
    required int sectionIndex,
  }) =>
      RollerColumnPickerField(
        title: fieldData.title,
        selectedValue: fieldData.value,
        onTap: fieldData.onTap,
      );

  Widget buildIntervalFrequencySelect({
    required FormIntervalFrequencyPickerFieldData fieldData,
    required int fieldIndex,
    required int sectionIndex,
  }) =>
      IntervalFrequencyPickerField(
        title: fieldData.title,
        selectedValue: FrequencyType(
          interval: fieldData.value?.interval ?? 0,
          frequency: fieldData.value?.frequency ?? PeriodType.fromString('week'),
        ),
        onTap: fieldData.onTap,
      );

  Widget buildIconOptionPickerField({
    required FormIconPickerFieldData fieldData,
    required int fieldIndex,
    required int sectionIndex,
  }) =>
      IconPickerField(
        title: fieldData.title,
        selectedOption: fieldData.selectedOption != null
            ? LabeledIcon(icon: fieldData.selectedOption!.icon ?? StandardIcon.add, label: fieldData.selectedOption!.label)
            : null,
        options: fieldData.options?.map(
          (option) {
            return LabeledIcon(
              icon: option.icon ?? StandardIcon.add,
              label: option.label,
            );
          },
        ).toList(),
        onTap: fieldData.onTap,
      );

  Widget buildTagEditor({
    required FormTagFieldData fieldData,
    required int fieldIndex,
    required int sectionIndex,
  }) =>
      TagField(
        title: fieldData.title,
        placeholder: fieldData.placeholder,
        tags: fieldData.tags,
        onTap: fieldData.onTap,
      );

  Widget buildMetaForm<T>({
    required MetaFormFieldData<T> fieldData,
    required int fieldIndex,
    required int sectionIndex,
  }) =>
      MetaFormField(
        title: fieldData.title,
        displayValues: fieldData.labeledValues,
        onTap: fieldData.onTap,
      );

  Widget buildFormSectionHeader<T extends StreamableFormSectionHeaderData>({
    required BuildContext context,
    required T headerData,
    required int sectionIndex,
  }) =>
      buildSectionHeader(
        title: headerData.title ?? "",
        subtitle: headerData.subtitle,
        withPadding: false,
      );

  @override
  Widget buildFormSectionButton<T extends StreamableFormSectionButtonData>({
    required T buttonData,
    required int sectionIndex,
    required BuildContext context,
  }) =>
      Padding(
        padding: EdgeInsets.only(
          top: SemanticTheme.of(context)?.distance?.spacing?.vertical?.small ?? 0,
        ),
        child: buildSecondaryCenterButton(
          context,
          onTap: buttonData.onTap as OnTap,
          text: buttonData.text,
        ),
      );

  @override
  Widget buildField<T extends StreamableFormFieldData>({
    required BuildContext context,
    required T fieldData,
    required StreamableFormData formData,
    required int fieldIndex,
    required int sectionIndex,
  }) {
    Widget? fieldBody;

    if (fieldData is FormTextFieldData) {
      fieldBody = buildTextField(
        fieldData: fieldData,
        formData: formData,
        fieldIndex: fieldIndex,
        sectionIndex: sectionIndex,
        context: context,
      );
    } else if (fieldData is FormTextAreaData) {
      fieldBody = buildTextArea(
        fieldData: fieldData,
        formData: formData,
        fieldIndex: fieldIndex,
        sectionIndex: sectionIndex,
        context: context,
      );
    } else if (fieldData is FormSwitchFieldData) {
      fieldBody = buildSwitchField(
        fieldData: fieldData,
        fieldIndex: fieldIndex,
        sectionIndex: sectionIndex,
        context: context,
      );
    } else if (fieldData is FormOptionPickerFieldData) {
      fieldBody = buildOptionPickerField(
        fieldData: fieldData,
        fieldIndex: fieldIndex,
        sectionIndex: sectionIndex,
      );
    } else if (fieldData is FormTimePickerFieldData) {
      fieldBody = buildTimeSelect(
        fieldData: fieldData,
        fieldIndex: fieldIndex,
        sectionIndex: sectionIndex,
      );
    } else if (fieldData is FormIconPickerFieldData) {
      fieldBody = buildIconOptionPickerField(
        fieldData: fieldData,
        fieldIndex: fieldIndex,
        sectionIndex: sectionIndex,
      );
    } else if (fieldData is FormDatePickerFieldData) {
      fieldBody = buildDateField(
        context: context,
        formData: formData,
        fieldData: fieldData,
        fieldIndex: fieldIndex,
        sectionIndex: sectionIndex,
      );
    } else if (fieldData is FormIntervalFrequencyPickerFieldData) {
      fieldBody = buildIntervalFrequencySelect(
        fieldData: fieldData,
        fieldIndex: fieldIndex,
        sectionIndex: sectionIndex,
      );
    } else if (fieldData is FormRollerColumnPickerFieldData) {
      fieldBody = buildRollerColumnPickerField(
        fieldData: fieldData,
        fieldIndex: fieldIndex,
        sectionIndex: sectionIndex,
      );
    } else if (fieldData is FormTagFieldData) {
      fieldBody = buildTagEditor(
        fieldData: fieldData,
        fieldIndex: fieldIndex,
        sectionIndex: sectionIndex,
      );
    } else if (fieldData is MetaFormFieldData) {
      fieldBody = buildMetaForm(
        fieldData: fieldData,
        fieldIndex: fieldIndex,
        sectionIndex: sectionIndex,
      );
    }

    return fieldData.isRemovable
        ? RemovableFieldContainer(
            child: fieldBody,
            onRemove: () => bloc.removeFieldData(fieldData),
          )
        : FieldContainer(
              child: fieldBody,
          );
  }

  void resignFocus(BuildContext context) {
    FocusScope.of(context).unfocus();
    KeyboardAccessory.of(context)?.hide();
  }

  void _changeFocus({
    required FormCompositionFieldData fieldData,
    required BuildContext context,
  }) {
    final nextInvalidFieldData = _nextInvalidCompositionFieldDataAfter(fieldData);

    if (nextInvalidFieldData != null) {
      final focusNode = _focusNodeManager.nodeFor(nextInvalidFieldData, context);
      if (focusNode.canRequestFocus) {
        FocusScope.of(context).requestFocus(focusNode);
        _setChangingFocus(fieldData, true);
      }
    } else {
      _resignFieldFocus(fieldData: fieldData, context: context);
    }
  }

  FormTextFieldData? _nextInvalidCompositionFieldDataAfter(
    FormCompositionFieldData fieldData,
  ) {
    final allCompositionFieldData = _allCompositionFieldData;

    final index = allCompositionFieldData.indexOf(fieldData);
    for (var i = index + 1; i < allCompositionFieldData.length; i++) {
      final subsequentFieldData = allCompositionFieldData[i];
      if (subsequentFieldData.value?.isEmpty ?? true && !(subsequentFieldData.isOptional ?? false) && !(subsequentFieldData.isCurrentlyValid))
        return subsequentFieldData as FormTextFieldData?;
    }
    for (var i = 0; i < index; i++) {
      final previousFieldData = allCompositionFieldData[i];
      if (previousFieldData.value?.isEmpty ?? true && !(previousFieldData.isOptional ?? false) && !(previousFieldData.isCurrentlyValid))
        return previousFieldData as FormTextFieldData?;
    }
    return null;
  }

  TextInputAction _getInputActionForCompositionFieldData(
    FormCompositionFieldData? fieldData,
  ) {
    if (fieldData?.inputAction != null) return fieldData!.inputAction!;
    final nextInvalid = _nextInvalidCompositionFieldDataAfter(fieldData!);

    return nextInvalid == null && (fieldData.value?.isNotEmpty ?? false) && fieldData.isCurrentlyValid ? TextInputAction.done : TextInputAction.next;
  }

  void _updateCompositionFieldData({required FormCompositionFieldData except}) {
    for (final fieldData in _allCompositionFieldData) {
      if (fieldData == except) continue;
      bloc.updateFieldData(fieldData);
    }
  }

  void _onCompositionViewFocusChanged(
    FormCompositionFieldData fieldData,
    bool isInFocus,
    BuildContext context,
  ) {
    fieldData.onFocusChanged(isInFocus);
    if (!isInFocus && !_isChangingFocus(fieldData)) {
      KeyboardAccessory.of(context)?.hide();
    }
    if (!isInFocus) _setChangingFocus(fieldData, false);
  }

  void _onCompositionViewSubmitted(
    FormCompositionFieldData fieldData,
    String value,
    BuildContext context,
  ) {
    fieldData.onSubmitted(value);
    _changeFocus(fieldData: fieldData, context: context);
  }

  void _onCompositionViewChanged(
    FormCompositionFieldData fieldData,
    String value,
  ) {
    final oldValue = fieldData.value;
    if (oldValue == value) return;
    fieldData.onChanged(value);
    //If the fieldValue is going from empty to not empty or vice versa.
    final emptyStateChanged = value.length + (oldValue?.length ?? 0) == 1;
    if (emptyStateChanged) {
      _updateCompositionFieldData(except: fieldData);
    }
  }

  void _resignFieldFocus({
    required FormCompositionFieldData fieldData,
    required BuildContext context,
  }) {
    final focusNode = _focusNodeManager.nodeFor(fieldData, context);
    if (focusNode.hasFocus) focusNode.unfocus();
    KeyboardAccessory.of(context)?.hide();
  }

  ActionKeyboardAccessoryButton _buttonFor({
    required FormCompositionFieldData fieldData,
    required StreamableFormData formData,
    required BuildContext context,
  }) {
    final _nextButton = SecondaryActionKeyboardAccessoryButton(
        title: _nextKeyboardTitle,
        onTap: () => _changeFocus(
              fieldData: fieldData,
              context: context,
            ));

    final _doneButton = PrimaryActionKeyboardAccessoryButton(
        title: _doneKeyboardTitle,
        onTap: () => _resignFieldFocus(
              fieldData: fieldData,
              context: context,
            ));

    switch (_getInputActionForCompositionFieldData(fieldData)) {
      case TextInputAction.next:
        return _nextButton;
      default:
        if (formData.canSubmitWithKeyboardRaised ?? false) {
          return formData.submitKeyboardAccessory as ActionKeyboardAccessoryButton;
        }
        return _doneButton;
    }
  }

  void _updateKeyboardAccessoryButton({
    required FormCompositionFieldData fieldData,
    required StreamableFormData formData,
    required BuildContext context,
  }) {
    final button = _buttonFor(
      fieldData: fieldData,
      formData: formData,
      context: context,
    );
    KeyboardAccessory.of(context)?.child = buildKeybordAccessoryShortBar(
      context,
      children: [button],
    );
  }

  void dispose() {
    _focusNodeManager.dispose();
    _changingFocusMap.clear();
  }
}

class _FocusNodeManager {
  Map<FormCompositionFieldData, FocusNode> _focusNodeMap = {};

  FocusNode nodeFor(
    FormCompositionFieldData fieldData,
    BuildContext context,
  ) {
    final node = _focusNodeMap[fieldData];
    if (node != null) return node;
    return _newNodeFor(fieldData, context);
  }

  FocusNode _newNodeFor(
    FormCompositionFieldData fieldData,
    BuildContext context,
  ) {
    final newNode = FocusNode();
    _focusNodeMap[fieldData] = newNode;
    return newNode;
  }

  void dispose() {
    _focusNodeMap.forEach((data, node) => node.dispose());
  }
}
