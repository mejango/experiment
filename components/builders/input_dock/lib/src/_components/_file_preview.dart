import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:semantic_theme/index.dart';
import 'package:standard_icon_library/index.dart';
import 'package:haptics/index.dart';

import '../input_dock.dart';

class DockFilePreview extends StatefulWidget {
  DockFilePreviewState createState() => DockFilePreviewState();
}

class DockFilePreviewState extends State<DockFilePreview>
    with SingleTickerProviderStateMixin {
  final ScrollController _listViewController = ScrollController();

  @override
  void didChangeDependencies() {
    final theme = SemanticTheme.of(context);

    Future.delayed(theme?.duration?.short ?? Duration.zero, () {
      _listViewController.animateTo(
        _listViewController.position.maxScrollExtent,
        duration: theme?.duration?.short ?? Duration.zero,
        curve: theme?.curve?.hurried ?? Curves.linear,
      );
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final dock = InputDock.of(context);
    final theme = SemanticTheme.of(context);

    final previews = <Widget>[];

    for (final file in dock?.files ?? []) {
      final preview = _FilePreview(
        key: ObjectKey(file),
        file: file,
        isRightPadded: (file != dock!.files.last),
        animateOnRemove: (dock.files.length > 1),
        previewWidth: dock.previewWidth,
        removeFile: () => dock.removeFile(file),
      );
      previews.add(preview);
    }

    final previewRow = Container(
      height: dock?.files.isNotEmpty == true ? dock?.previewHeight ?? 0 : 0,
      child: ListView(
        controller: _listViewController,
        padding: EdgeInsets.symmetric(
          horizontal: theme?.distance?.padding?.horizontal?.medium ?? 0,
        ),
        scrollDirection: Axis.horizontal,
        children: previews,
      ),
    );

    return AnimatedSize(
      curve: theme?.curve?.hurried ?? Curves.linear,
      duration: theme?.duration?.short ?? Duration.zero,
      child: previewRow,
    );
  }
}

class _FilePreview extends StatefulWidget {
  final AssetEntity file;
  final bool isRightPadded;
  final bool animateOnRemove;
  final double previewWidth;
  final VoidCallback removeFile;

  _FilePreview({
    Key? key,
    required this.file,
    required this.isRightPadded,
    required this.animateOnRemove,
    required this.previewWidth,
    required this.removeFile,
  })  : super(key: key);

  _FilePreviewState createState() => _FilePreviewState();
}

class _FilePreviewState extends State<_FilePreview>
    with SingleTickerProviderStateMixin {
  bool _show = true;

  _remove() {
    final theme = SemanticTheme.of(context);

    triggerHaptic(HapticOption.click);

    if (widget.animateOnRemove) {
      setState(() => _show = false);
      Future.delayed(
        theme?.duration?.short ?? Duration.zero,
        () {
          widget.removeFile();
        },
      );
    } else {
      widget.removeFile();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = SemanticTheme.of(context);

    final removeIcon = StandardIcon.close.buildWidget(
      color: Colors.black.withAlpha(180),
    );

    final removeButton = GestureDetector(
      onTap: _remove,
      child: Container(
        width: _show ? null : 0,
        padding: EdgeInsets.all(
          theme?.distance?.padding?.horizontal?.small ?? 0,
        ),
        child: removeIcon,
      ),
    );

    final thumbnail = FutureBuilder<Uint8List?>(
      future: widget.file.thumbnailData,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
            width: widget.previewWidth,
            height: widget.previewWidth,
            color: Colors.grey[200],
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return Image.memory(
          snapshot.data!,
          fit: BoxFit.cover,
          gaplessPlayback: true,
        );
      },
    );

    final imageWidget = ClipRRect(
      borderRadius: BorderRadius.all(theme?.radius?.small ?? Radius.zero),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: thumbnail,
    );

    final animatedWidthContainer = AnimatedSize(
      curve: theme?.curve?.hurried ?? Curves.linear,
      duration: theme?.duration?.short ?? Duration.zero,
      alignment: Alignment.topLeft,
      child: Container(
        width: _show ? widget.previewWidth : 0,
        child: imageWidget,
      ),
    );

    return AnimatedOpacity(
      opacity: _show ? 1 : 0,
      curve: theme?.curve?.hurried ?? Curves.linear,
      duration: theme?.duration?.short ?? Duration.zero,
      child: Container(
        margin: EdgeInsets.only(
          top: theme?.distance?.spacing?.vertical?.medium ?? 0,
          right:
              widget.isRightPadded ? theme?.distance?.spacing?.horizontal?.min ?? 0 : 0,
        ),
        child: Stack(
          children: [
            animatedWidthContainer,
            removeButton,
          ],
        ),
      ),
    );
  }
}
