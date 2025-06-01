import 'package:flutter/material.dart';
import 'package:button_builder/index.dart';
import 'package:form_body_builder/index.dart';
import 'package:button_status_option/index.dart';
import 'package:semantic_theme/index.dart';

mixin FormBuilder implements FormBodyBuilder, PrimaryCenterButtonBuilder {
  String get title;
  String? get subtitle => null;
  String? get auxiliaryDescription => null;
  String? get auxiliaryButtonText => null;
}

mixin FormBuilderState<T extends FormBuilder>
    implements FormBodyBuilderState<T> {
  Widget get submitButton {
    return widget.buildPrimaryCenterButton(
      context,
      text: submitButtonText,
      onTap: () => onSubmitButtonTap(context),
      status: _submitButtonState,
    );
  }

  ButtonStatusOption get _submitButtonState {
    switch (formSubmitState) {
      case FormSubmitStatus.loading:
        return ButtonStatusOption.loading;
      case FormSubmitStatus.exception:
      case FormSubmitStatus.ready:
        return ButtonStatusOption.ready;
    }
  }

  String get submitButtonText {
    switch (formSubmitState) {
      case FormSubmitStatus.loading:
        return "Loading";
      case FormSubmitStatus.exception:
      case FormSubmitStatus.ready:
        return widget.submitButtonText;
    }
  }

  Widget buildForm(BuildContext context) {
    addFocusChangedListeners();
    final theme = SemanticTheme.of(context);

    final headerStyle = theme?.typography.title.textStyle(
      color: theme.color.text.generalPrimary,
    );
    final subtitleStyle = theme?.typography.subtitle.textStyle(
      color: theme.color.text.generalSecondary,
    );

    final formWidgets = <Widget>[];
    final headerWidgets = <Widget>[];

    if (widget.title.isNotEmpty) {
      headerWidgets.add(
        Text(
          widget.title,
          style: headerStyle,
          textAlign: TextAlign.center,
        ),
      );
    }

    if (widget.subtitle != null) {
      final subtitleTextWidget = Text(
        widget.subtitle!,
        style: subtitleStyle,
      );
      headerWidgets.add(
        Padding(
          padding: EdgeInsets.all(
            theme?.distance.spacing.vertical.medium ?? 0,
          ),
          child: subtitleTextWidget,
        ),
      );
    }

    if (headerWidgets.isNotEmpty) {
      formWidgets.add(
        Padding(
          padding: EdgeInsets.only(top: theme?.distance.gutter.vertical.medium ?? 0),
          child: Column(
            children: headerWidgets,
          ),
        ),
      );
    }

    formWidgets.add(
      Padding(
        padding: EdgeInsets.symmetric(
          vertical: theme?.distance.spacing.vertical.large ?? 0,
          horizontal: theme?.distance.gutter.horizontal.medium ?? 0,
        ),
        child: buildFormBody(context),
      ),
    );

    if (validationException != null) {
      formWidgets.add(
        Container(
          margin: EdgeInsets.symmetric(
            vertical: theme?.distance.spacing.vertical.medium ?? 0,
          ),
          child: Text(
            validationException!.message,
            style: theme?.typography.detailHeavy.textStyle(
              color: theme.color.text.warn,
            ),
          ),
        ),
      );
    }

    if (submissionException != null) {
      formWidgets.add(
        Container(
          margin: EdgeInsets.symmetric(
            vertical: theme?.distance.spacing.vertical.medium ?? 0,
          ),
          child: Text(
            submissionException!.message,
            style: theme?.typography.detailHeavy.textStyle(
              color: theme.color.text.warn,
            ),
          ),
        ),
      );
    }

    if (!shouldHideButtons) {
      formWidgets.add(
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: theme?.distance.padding.horizontal.medium ?? 0,
          ),
          child: submitButton,
        ),
      );
    }

    return Column(children: formWidgets);
  }
}
