import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';

/// A compact "Token" widget used to represent an action, choice, filter or
/// input. It can be togglable, removable, and shows an optional icon.
class Token extends StatelessWidget {
  const Token({
    required this.child,
    super.key,
    this.icon,
    this.selected = false,
    this.onSelected,
    this.isRemovable = false,
    this.onRemoved,
    this.isTogglable = true,
    this.isEnabled = true,
    this.removeIcon,
    this.contentPadding = const EdgeInsets.symmetric(
      horizontal: 12,
      vertical: 6,
    ),
    this.style,
    this.focusNode,
    this.autofocus = false,
  });

  /// Primary content of the token (text or widget).
  final Widget child;

  /// Optional leading icon.
  final Widget? icon;

  /// Whether this token is selected (used when [isTogglable] is true).
  final bool selected;

  /// Called when the token is selected/deselected.
  final ValueChanged<bool>? onSelected;

  /// Whether a remove control is shown.
  final bool isRemovable;

  /// Called when the remove control is activated.
  final VoidCallback? onRemoved;

  /// Whether the token behaves like a toggle.
  final bool isTogglable;

  /// Whether the token is enabled.
  final bool isEnabled;

  /// The remove icon widget (shown when [isRemovable] is true).
  final Widget? removeIcon;

  /// Padding inside the token.
  final EdgeInsetsGeometry contentPadding;

  /// Optional ButtonStyle to customize appearance.
  final ButtonStyle? style;

  /// Focus node forwarded to the internal Button.
  final FocusNode? focusNode;

  /// Whether to autofocus the internal Button.
  final bool autofocus;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<Widget>('icon', icon))
      ..add(FlagProperty('selected', value: selected, ifTrue: 'selected'))
      ..add(
        ObjectFlagProperty<ValueChanged<bool>?>.has('onSelected', onSelected),
      )
      ..add(
        FlagProperty('isRemovable', value: isRemovable, ifTrue: 'removable'),
      )
      ..add(ObjectFlagProperty<VoidCallback?>.has('onRemoved', onRemoved))
      ..add(FlagProperty('togglable', value: isTogglable, ifTrue: 'togglable'))
      ..add(FlagProperty('isEnabled', value: isEnabled, ifFalse: 'disabled'))
      ..add(
        DiagnosticsProperty<EdgeInsetsGeometry>(
          'contentPadding',
          contentPadding,
        ),
      )
      ..add(DiagnosticsProperty<ButtonStyle>('style', style));
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasFluentTheme(context));
    final theme = FluentTheme.of(context);

    // Base pill-shaped style used for tokens.
    final basePillStyle = ButtonStyle(
      borderRadius: const WidgetStatePropertyAll(
        BorderRadius.all(Radius.circular(50)),
      ),
      padding: WidgetStatePropertyAll(contentPadding),
    );

    // If togglable, define checked and unchecked styles.
    ButtonStyle effectiveStyle;
    if (isTogglable) {
      final checkedStyle = ButtonStyle(
        borderRadius: const WidgetStatePropertyAll(
          BorderRadius.all(Radius.circular(50)),
        ),
        backgroundColor: WidgetStateProperty.resolveWith<Color?>(
          // ignore: prefer-trailing-comma
          (states) => ButtonThemeData.checkedInputColor(theme, states),
        ),
        foregroundColor: WidgetStateProperty.resolveWith<Color?>(
          (states) => FilledButton.foregroundColor(theme, states),
        ),
        padding: WidgetStatePropertyAll(contentPadding),
      );

      final uncheckedStyle = ButtonStyle(
        borderRadius: const WidgetStatePropertyAll(
          BorderRadius.all(Radius.circular(50)),
        ),
        padding: WidgetStatePropertyAll(contentPadding),
      );

      // merge may return a nullable ButtonStyle, provide a non-null fallback
      effectiveStyle =
          (selected ? checkedStyle : uncheckedStyle).merge(style) ??
          (selected ? checkedStyle : uncheckedStyle);
    } else {
      // Non-togglable: simple pill style, user-provided style overrides defaults.
      // ensure a non-null ButtonStyle by falling back to basePillStyle
      effectiveStyle = basePillStyle.merge(style) ?? basePillStyle;
    }

    // Build content (icon + child + optional remove control).
    final List<Widget> contents = [];
    if (icon != null) {
      contents.add(
        Padding(
          padding: const EdgeInsetsDirectional.only(end: 8.0),
          child: icon!,
        ),
      );
    }

    contents.add(
      DefaultTextStyle.merge(
        style: const TextStyle(fontSize: 13),
        child: child,
      ),
    );

    if (isRemovable) {
      final Widget rem = GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: isEnabled && onRemoved != null ? onRemoved : null,
        child: Padding(
          padding: const EdgeInsetsDirectional.only(start: 8.0),
          child: removeIcon ?? const Icon(WindowsIcons.remove, size: 12),
        ),
      );
      contents.add(rem);
    }

    // Decide on the press action.
    final VoidCallback? onPressed = isEnabled
        ? () {
            if (isTogglable) {
              onSelected?.call(!selected);
            } else {
              onSelected?.call(true);
            }
          }
        : null;

    // Semantics toggled only when acting as a toggle.
    final Widget button = _tokenButton(effectiveStyle, onPressed, contents);
    return isTogglable ? Semantics(toggled: selected, child: button) : button;
  }

  Widget _tokenButton(
    ButtonStyle effectiveStyle,
    VoidCallback? onPressed,
    List<Widget> contents,
  ) {
    // Use Button to keep consistent behavior with other controls.
    // Wrap the row in an UnconstrainedBox so its intrinsic width is respected.
    // To ensure the Row sizes to its intrinsic width inside the unconstrained
    // environment, wrap the Row with IntrinsicWidth.
    final Widget row = Row(mainAxisSize: MainAxisSize.min, children: contents);

    return Button(
      onPressed: onPressed,
      focusNode: focusNode,
      autofocus: autofocus,
      style: effectiveStyle,
      child: UnconstrainedBox(
        alignment: Alignment.center,
        child: IntrinsicWidth(child: row),
      ),
    );
  }
}
