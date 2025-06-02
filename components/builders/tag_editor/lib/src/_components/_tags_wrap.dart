import 'package:flutter/material.dart';
import 'package:semantic_theme/index.dart';
import 'package:small_icon_library/index.dart';
import 'package:haptics/index.dart';

class TagsWrap extends StatelessWidget {
  final List<String>? tags;
  final void Function(String)? tagRemoveCallback;

  TagsWrap({
    tags,
    this.tagRemoveCallback,
  }) : this.tags = tags ?? [];

  final _emptyText = "No tags selected";

  @override
  Widget build(BuildContext context) {
    final theme = SemanticTheme.of(context);

    List<Widget> selectedTagWidgets = [];

    selectedTagWidgets = tags?.map(
          (tag) => _RemoveableAnimatedTag(
            key: ObjectKey(tag),
            label: tag,
            removeCallback: () => tagRemoveCallback?.call(tag),
          ),
        )
        .toList() ?? [];

    final emptyText = Text(
      _emptyText,
      style: theme?.typography?.body?.textStyle(
        color: theme.color?.text?.generalSecondary ?? Colors.black,
      ),
    );

    return Container(
      margin: EdgeInsets.only(
        bottom: theme?.distance?.spacing?.vertical?.medium ?? 0,
      ),
      child: tags?.isNotEmpty ?? false
          ? Wrap(
              children: selectedTagWidgets,
              runSpacing: theme?.distance?.spacing?.vertical?.small ?? 0,
              spacing: theme?.distance?.spacing?.horizontal?.small ?? 0,
            )
          : emptyText,
    );
  }
}

class _RemoveableAnimatedTag extends StatefulWidget {
  final String? label;
  final VoidCallback? removeCallback;

  _RemoveableAnimatedTag({
    Key? key,
    this.label,
    this.removeCallback,
  }) : super(key: key);

  @override
  _RemoveableAnimatedTagState createState() => _RemoveableAnimatedTagState();
}

class _RemoveableAnimatedTagState extends State<_RemoveableAnimatedTag>
    with SingleTickerProviderStateMixin {
  bool _show = true;

  _remove() {
    triggerHaptic(HapticOption.light);

    Future.delayed(SemanticTheme.of(context)?.duration?.short ?? Duration.zero, () {
      widget.removeCallback?.call();
    });
    setState(() => _show = false);
  }

  final double _height = 40;

  @override
  Widget build(BuildContext context) {
    final theme = SemanticTheme.of(context);

    final removeIcon = SmallIcon.x.buildWidget(
      color: theme?.color?.icon?.generalPrimary ?? Colors.black,
    );

    final textWidget = Text(
      widget.label ?? "",
      style: theme?.typography?.detail?.textStyle(
        color: theme.color?.text?.generalPrimary ?? Colors.black,
      ),
      overflow: TextOverflow.fade,
    );

    final backgroundColor = theme?.color?.background?.raised ?? Colors.white;

    final animatedTextContainer = AnimatedSize(
      curve: theme?.curve?.delayed ?? Curves.easeInOut,
      duration: theme?.duration?.short ?? Duration.zero,
      alignment: Alignment.centerLeft,
      child: Container(
        width: _show ? null : 0,
        child: textWidget,
      ),
    );

    final List<Widget> children = [];

    if (_show) children.add(removeIcon);
    children.add(animatedTextContainer);

    final animatedOpacityContainer = AnimatedOpacity(
      opacity: _show ? 1 : 0,
      curve: theme?.curve?.hurried ?? Curves.easeInOut,
      duration: theme?.duration?.short ?? Duration.zero,
      child: Container(
        height: _height,
        padding: _show
            ? EdgeInsets.only(
                left: theme?.distance?.padding?.horizontal?.min ?? 0,
                right: theme?.distance?.padding?.horizontal?.small ?? 0,
              )
            : EdgeInsets.all(0),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.all(
            Radius.circular(_height / 2),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: children,
        ),
      ),
    );

    return GestureDetector(
      onTap: _remove,
      child: animatedOpacityContainer,
    );
  }
}
