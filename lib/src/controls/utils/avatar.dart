import 'package:fluent_ui/fluent_ui.dart';

class StatusRing extends StatelessWidget {
  const StatusRing({
    super.key,
    this.size = 40.0,
    this.thickness = 2.0,
    this.color,
    this.decoration,
    this.shape,
  });

  // Size of the status ring.
  final double size;

  // Thickness of the status ring.
  final double thickness;

  // Color of the status ring.
  final Color? color;

  // Shape of the status ring.
  final BoxShape? shape;

  // Decoration of the status ring, which can be used for gradients and other effects. If provided, it overrides [color] and [thickness].
  final BoxDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    return Container(
      height: size,
      width: size,
      decoration:
          decoration ??
          BoxDecoration(
            color: Colors.transparent,
            shape: shape ?? BoxShape.circle,
            border: Border.all(
              color: color ?? theme.accentColor,
              width: thickness,
            ),
          ),
    );
  }
}

class Avatar extends StatelessWidget {
  const Avatar({
    super.key,
    this.name,
    this.size = 30.0,
    this.margin,
    this.style,
    this.child,
    this.image,
    this.decoration = const BoxDecoration(shape: BoxShape.circle),
    this.foregroundDecoration,
    this.statusRing,
    this.children = const <Widget>[],
    this.autoTextSize = false,
    this.color,
  });

  /// Avatar size (width = height).
  final double size;

  /// Avatar margin.
  final EdgeInsetsGeometry? margin;

  /// Used for creating initials.
  /// Avatar choose to display content based on piority: [image] > [child] > [name].
  /// If both [image], [child] and [name] are not provided, a default person icon is shown.
  final String? name;

  /// Initials text style.
  final TextStyle? style;

  /// Child widget to display inside the avatar.
  /// Avatar choose to display content based on piority: [image] > [child] > [name].
  /// If both [image], [child] and [name] are not provided, a default person icon is shown.
  final Widget? child;

  /// Image Source for the avatar.
  /// Avatar choose to display content based on piority: [image] > [child] > [name].
  /// If both [image], [child] and [name] are not provided, a default person icon is shown.
  final ImageProvider<Object>? image;

  /// Avatar decoration.
  /// By default, it's a circular shape, which represent standard avatar according to Fluent UI guidelines.
  /// Adjust [decoration] to represent a Group.
  /// Group avatars are square containers and represent many people, like teams, organizations, or companies.
  final BoxDecoration decoration;

  /// Optional override for the decoration color.
  /// If provided, this color will be applied instead of [decoration.color].
  final Color? color;

  /// Avatar foreground decoration.
  final BoxDecoration? foregroundDecoration;

  /// Children widgets, which can be used to add Infobadges() or other widgets on top of the avatar.
  final List<Widget> children;

  /// Status ring around the avatar.
  final StatusRing? statusRing;

  /// Whether the [name] text should dynamically changes according to [size].
  final bool autoTextSize;

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    final dynamicTextSize = 15.0 * (size / 40.0);
    final textStyle = TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w500,
      color: theme.typography.body!.color,
    ).merge(style);
    final boxdecoration = decoration.copyWith(
      color: color ?? decoration.color ?? theme.cardColor,
      border:
          decoration.border ??
          Border.all(
            color: theme.resources.controlStrokeColorDefault,
            //width: 0.5,
          ),
    );

    final sourceChild = DefaultTextStyle(
      style: autoTextSize
          ? textStyle.copyWith(fontSize: dynamicTextSize)
          : textStyle,
      child: image == null
          ? child == null
                ? name == null
                      ? Icon(FluentIcons.contact)
                      : Text(name.toAbbreviation())
                : child!
          : Image(
              image: image!,
              width: size,
              height: size,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
                  child ?? Text(name.toAbbreviation()),
            ),
    );

    final avatar = Container(
      width: size,
      height: size,
      margin: margin,
      child: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            clipBehavior: Clip.antiAlias,
            decoration: boxdecoration,
            foregroundDecoration: foregroundDecoration,
            child: sourceChild,
          ),
          for (final child in children) child,
        ],
      ),
    );

    return UnconstrainedBox(
      child: statusRing != null
          ? Stack(alignment: Alignment.center, children: [statusRing!, avatar])
          : avatar,
    );
  }
}

enum AvatarMinLength {
  one,
  two;

  bool get isOne => this == one;

  bool get isTwo => this == two;
}

extension InitialsStringExtension on String? {
  String toAbbreviation([AvatarMinLength minLength = AvatarMinLength.one]) {
    final trimmed = this?.trim();
    if (trimmed == null || trimmed.isEmpty) {
      return '';
    }

    final nameParts = trimmed.toUpperCase().split(RegExp(r'[\s/]+'));

    if (nameParts.length > 1) {
      return nameParts.first.characters.first + nameParts[1].characters.first;
    }

    return nameParts.first.characters.length > 1
        ? nameParts.first.characters.take(2).string
        : nameParts.first.characters.first;
  }
}

class AvatarGroup extends StatelessWidget {
  /// Children widgets (usually [Avatar]) to display in the group.
  final List<Widget> children;

  /// Fraction of each avatar's width that will overlap the previous avatar.
  /// Range: 0.0 (no overlap) .. 1.0 (complete overlap). Default 0.3.
  final double overlapPercent;

  /// Additional space (in logical pixels) inserted between adjacent avatars.
  /// Useful when [overlapPercent] is 0 to create a gap. Defaults to 0.0.
  final double spacing;

  /// Fallback size used to compute overlap for children that are not [Avatar].
  /// Defaults to 40.0.
  final double fallbackAvatarSize;

  /// The alignment of the group along the cross axis.
  final CrossAxisAlignment crossAxisAlignment;

  /// If true, the whole group takes the minimum width required.
  final MainAxisSize mainAxisSize;

  /// Maximum number of avatars to display. When specified and the number of
  /// children exceeds this value, the group will show (maxDisplayed - 1)
  /// original children plus a final Avatar that displays the remaining count
  /// (for example: "+8"). If null, all children are shown.
  final int? maxDisplayed;

  const AvatarGroup({
    super.key,
    required this.children,
    this.overlapPercent = 0.3,
    this.spacing = 0.0,
    this.fallbackAvatarSize = 40.0,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.min,
    this.maxDisplayed,
  }) : assert(overlapPercent >= 0 && overlapPercent <= 1.0),
       assert(spacing >= 0.0);

  double _childWidth(Widget child) {
    if (child is Avatar) {
      // Account for a possible StatusRing that may be larger than the avatar's base size.
      final avatarBase = child.size;
      final srSize = child.statusRing?.size ?? 0.0;
      return avatarBase >= srSize ? avatarBase : srSize;
    }
    return fallbackAvatarSize;
  }

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);

    // Build effective children according to maxDisplayed.
    final effectiveChildren = <Widget>[];
    if (maxDisplayed != null && children.length > maxDisplayed!) {
      final display = maxDisplayed!.clamp(0, children.length);
      final remaining = children.length - (display > 0 ? (display - 1) : 0);

      if (display <= 0) {
        // No room for originals, just show the overflow avatar
        effectiveChildren.add(
          Avatar(
            size: fallbackAvatarSize,
            child: Text(
              '+${children.length}',
              style: TextStyle(color: theme.typography.body!.color),
            ),
          ),
        );
      } else if (display == 1) {
        // Only one slot: show the overflow avatar (all are remaining)
        effectiveChildren.add(
          Avatar(
            size: fallbackAvatarSize,
            child: Text(
              '+${children.length}',
              style: TextStyle(color: theme.typography.body!.color),
            ),
          ),
        );
      } else {
        // Show first (display - 1) avatars and one overflow avatar
        effectiveChildren.addAll(children.take(display - 1));
        effectiveChildren.add(
          Avatar(
            size: // try to match typical avatar size: take size from first child if available
            (children.first is Avatar)
                ? (children.first as Avatar).size
                : fallbackAvatarSize,
            child: Text(
              '+$remaining',
              style: TextStyle(color: theme.typography.body!.color),
            ),
          ),
        );
      }
    } else {
      effectiveChildren.addAll(children);
    }

    // Compute left positions and sizes for each child so we can use a Stack.
    final lefts = <double>[];
    final widths = <double>[];
    double left = 0.0;
    double maxHeight = 0.0;

    for (var i = 0; i < effectiveChildren.length; i++) {
      final child = effectiveChildren[i];
      final w = _childWidth(child);
      lefts.add(left);
      widths.add(w);
      if (w > maxHeight) maxHeight = w;
      final overlapPx = w * overlapPercent;
      // Advance left by avatar width minus overlap, plus optional spacing.
      left += w - overlapPx + spacing;
    }

    final totalWidth = effectiveChildren.isEmpty
        ? 0.0
        : (lefts.last + widths.last);

    // Build positioned children with vertical alignment based on crossAxisAlignment.
    final positioned = <Widget>[];
    for (var i = 0; i < effectiveChildren.length; i++) {
      final w = widths[i];
      double top;
      switch (crossAxisAlignment) {
        case CrossAxisAlignment.start:
          top = 0.0;
          break;
        case CrossAxisAlignment.end:
          top = maxHeight - w;
          break;
        case CrossAxisAlignment.center:
        default:
          top = (maxHeight - w) / 2.0;
      }

      positioned.add(
        Positioned(left: lefts[i], top: top, child: effectiveChildren[i]),
      );
    }

    // Constrain the Stack to the computed size so layout behaves correctly.
    return SizedBox(
      width: totalWidth,
      height: maxHeight,
      child: Stack(clipBehavior: Clip.none, children: positioned),
    );
  }
}
