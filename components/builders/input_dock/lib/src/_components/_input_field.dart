import 'package:flutter/material.dart';
import 'package:semantic_theme/index.dart';
import 'package:standard_icon_library/index.dart';
import 'package:haptics/index.dart';

import '../input_dock.dart';

class DockInputField extends StatefulWidget {
  final Function? onSubmit;

  DockInputField({this.onSubmit});

  @override
  _DockInputFieldState createState() => _DockInputFieldState();
}

class _DockInputFieldState extends State<DockInputField> {
  final double _maxHeight = 200;
  final int _maxCharCount = 750;
  final int _showCharCountAtLength = 720;

  final _textController = TextEditingController();

  InheritedInputDock? _dock;

  _textChanged() {
    _dock?.text = _textController.text;
    InputDock.of(context, shouldRebuild: false)?.text = _textController.text;
  }

  _resetText() {
    InputDock.of(context, shouldRebuild: false)?.text = _textController.text;
  }

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _textController.addListener(_textChanged);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _dock = InputDock.of(context);
  }

  @override
  Widget build(BuildContext context) {
    final paddedTextField = _TextFieldComponent(
      dock: _dock,
      controller: _textController,
      charShowCount: _showCharCountAtLength,
      maxCharCount: _maxCharCount,
    );

    final submitButton = _SubmitButton(
      submitCallback: _onSubmit,
      canSubmit: _textController.text.length <= _maxCharCount,
    );

    final constrainedInputStack = ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: _maxHeight,
        minHeight: _dock?.baseHeight ?? 0,
      ),
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        fit: StackFit.passthrough,
        children: [paddedTextField, submitButton],
      ),
    );

    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(child: constrainedInputStack),
        ],
      ),
    );
  }

  void _onSubmit() {
    _resetText();
    widget.onSubmit?.call(_textController.text);
  }
}

class _TextFieldComponent extends StatelessWidget {
  final InheritedInputDock? dock;
  final TextEditingController? controller;
  final int? charShowCount;
  final int? maxCharCount;

  _TextFieldComponent({
    this.dock,
    this.controller,
    this.charShowCount,
    this.maxCharCount,
  });

  static const String _hintText = "Add comment";

  final _enabledBorder =
      OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent));
  final _focusedBorder =
      OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent));

  @override
  Widget build(BuildContext context) {
    final theme = SemanticTheme.of(context);

    final textFieldDecoration = InputDecoration(
      contentPadding: EdgeInsets.all(0),
      hintText: _hintText,
      hintStyle: theme?.typography?.body?.textStyle(
        color: theme.color?.text?.inputPlaceholder ?? Colors.black,
      ),
      border: OutlineInputBorder(),
      enabledBorder: _enabledBorder,
      focusedBorder: _focusedBorder,
    );

    final textField = TextField(
      maxLines: null,
      style: theme?.typography?.body?.textStyle(
        color: theme.color?.text?.inputActive ?? Colors.black,
      ),
      textInputAction: TextInputAction.done,
      decoration: textFieldDecoration,
      controller: controller,
    );

    final double submitButtonPaddingBuffer = 50;
    final paddingWithBuffer = EdgeInsets.only(right: submitButtonPaddingBuffer);
    final paddingWithoutBuffer = EdgeInsets.all(0);

    return Padding(
      padding: dock?.showSubmitButton == true ? paddingWithBuffer : paddingWithoutBuffer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(child: textField),
          _TextCounter(
            charCount: controller?.text.length,
            charShowCount: charShowCount,
            charMaxCount: maxCharCount,
          )
        ],
      ),
    );
  }
}

class _TextCounter extends StatelessWidget {
  final int? charCount;
  final int? charShowCount;
  final int? charMaxCount;

  _TextCounter({Key? key, this.charCount, this.charShowCount, this.charMaxCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = SemanticTheme.of(context);

    final bool showTextCounter = charCount != null && charShowCount != null && charCount! > charShowCount!;
    final bool showAlert = charCount != null && charMaxCount != null && charCount! > charMaxCount!;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: theme?.distance?.padding?.vertical?.min ?? 0,
      ),
      height: showTextCounter ? null : 0,
      child: Text(
        showTextCounter ? "$charCount/$charMaxCount" : "",
        style: theme?.typography?.detail?.textStyle(
          color: showAlert == true
              ? theme.color?.text?.warn ?? Colors.black
              : theme.color?.text?.inputPlaceholder ?? Colors.black,
        ),
      ),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  final VoidCallback? submitCallback;
  final bool? canSubmit;

  _SubmitButton({this.submitCallback, this.canSubmit});

  @override
  Widget build(BuildContext context) {
    final dock = InputDock.of(context);
    final theme = SemanticTheme.of(context);

    final activeIconColor = theme?.color?.background?.actionPrimary ?? Colors.transparent;
    final inactiveIconColor = theme?.color?.background?.actionDisabled ?? Colors.transparent;
    final sendIcon = StandardIcon.send;
    final activeSendIcon = sendIcon.buildWidget(color: activeIconColor);
    final inactiveSendIcon = sendIcon.buildWidget(color: inactiveIconColor);

    final animatedSubmitButton = AnimatedCrossFade(
      duration: theme?.duration?.short ?? Duration.zero,
      firstCurve: theme?.curve?.delayed ?? Curves.linear,
      secondCurve: theme?.curve?.hurried ?? Curves.linear,
      crossFadeState:
          canSubmit == true ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      firstChild: activeSendIcon,
      secondChild: inactiveSendIcon,
    );

    void onTap() {
      triggerHaptic(HapticOption.light);
      submitCallback?.call();
    }

    void inactiveTap() {
      triggerHaptic(HapticOption.click);
    }

    final tapAction = dock?.showSubmitButton == true && canSubmit == true ? onTap : null;

    final tapDownAction =
        dock?.showSubmitButton == true && canSubmit == false ? (details) => inactiveTap() : null;

    return Container(
      alignment: Alignment.centerRight,
      margin: EdgeInsets.only(
        right: theme?.distance?.spacing?.horizontal?.medium ?? 0,
      ),
      height: dock?.baseHeight ?? 0,
      child: AnimatedOpacity(
        opacity: dock?.showSubmitButton == true ? 1 : 0,
        duration: theme?.duration?.short ?? Duration.zero,
        curve: theme?.curve?.delayed ?? Curves.linear,
        child: GestureDetector(
          onTap: tapAction,
          onTapDown: tapDownAction,
          child: animatedSubmitButton,
        ),
      ),
    );
  }
}
