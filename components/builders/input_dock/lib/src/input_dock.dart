import 'package:flutter/material.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:semantic_theme/index.dart';

import '_components/_file_preview.dart';
import '_components/_input_field.dart';

class DockSubmitData {
  String? text;
  List<String>? files;

  DockSubmitData({
    this.text,
    this.files,
  });
}

typedef DockDataHandler = void Function(DockSubmitData data);

class InputDock extends StatefulWidget {
  final Widget? actionButton;
  final DockDataHandler? onSubmit;
  final List<Widget>? auxiliaryWidgets;

  InputDock({
    this.actionButton,
    this.onSubmit,
    this.auxiliaryWidgets,
  });

  @override
  State<StatefulWidget> createState() => InheritedInputDock();

  static InheritedInputDock? of(
    BuildContext context, {
    bool shouldRebuild = true,
  }) {
    final inheritedWidget = (shouldRebuild
        ? context.dependOnInheritedWidgetOfExactType<_InheritedInputDock>()
        : context.findAncestorWidgetOfExactType<_InheritedInputDock>());

    return inheritedWidget?.data;
  }
}

class InheritedInputDock extends State<InputDock> {
  final double baseHeight = 40;
  final double previewHeight = 100;
  final double previewWidth = 140;

  String _text = '';
  List<AssetEntity> files = [];

  bool get showSubmitButton => _text.isNotEmpty || files.isNotEmpty;
  set text(String text) => setState(() => _text = text);

  void addFiles(List<AssetEntity> newFiles) => setState(() => files.addAll(newFiles));
  void removeFile(AssetEntity file) => setState(() => files.remove(file));

  void onSubmit() {
    _showDialogDev();

    // Format data and make API call
    final data = DockSubmitData(
      text: _text,
      // files: _files,
    );
    widget.onSubmit?.call(data);

    _resetDock();
  }

  void _resetDock() {
    setState(() {
      files = [];
      _text = "";
    });
  }

  void _showDialogDev() {
    String displayText = "";
    if (_text.isNotEmpty) {
      displayText += "\nText: " + _text;
    }
    if (files.isNotEmpty) {
      displayText += "\nFiles: " + files.length.toString();
    }
    showDialog(
      builder: (context) => AlertDialog(
        title: Text("submit:"),
        content: Text(displayText),
      ),
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = SemanticTheme.of(context);

    final columnChildren = <Widget>[];

    columnChildren.add(DockFilePreview());

    final rowChildren = <Widget>[];

    if (widget.auxiliaryWidgets != null) {
      rowChildren.addAll(widget.auxiliaryWidgets!);
    }

    rowChildren.add(DockInputField(onSubmit: onSubmit));

    if (widget.actionButton != null) rowChildren.add(widget.actionButton!);

    final Widget fieldRow = Container(
      padding: EdgeInsets.symmetric(
        horizontal: theme?.distance?.padding?.horizontal?.medium ?? 0,
        vertical: theme?.distance?.padding?.vertical?.medium ?? 0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: rowChildren,
      ),
    );
    columnChildren.add(fieldRow);

    final safeArea = MediaQuery.of(context).padding.bottom;
    final bottomPadding = EdgeInsets.only(bottom: safeArea);
    final backgroundColor = theme?.color?.background?.general ?? Colors.transparent;
    final topBorderColor = theme?.color?.stroke?.medium ?? Colors.transparent;

    final Widget dock = Container(
      padding: bottomPadding,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border(
          top: BorderSide(color: topBorderColor),
        ),
      ),
      child: Column(
        children: columnChildren,
      ),
    );

    return _InheritedInputDock(data: this, child: dock);
  }
}

class _InheritedInputDock extends InheritedWidget {
  final InheritedInputDock data;

  _InheritedInputDock({
    required this.data,
    required Widget child,
  }) : super(child: child);

  @override
  bool updateShouldNotify(_InheritedInputDock old) => true;
}
