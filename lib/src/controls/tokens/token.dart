//fix the code, context, I want to call the button class, Button (style: ButtonStyle(border radius:100)), 
//which should return the button in rounded corner of radius 100 and also border of radius 100. 
//However, only the button is rounded, but not the border. The RoundedRectangleBorder thing somehow only return radius 4. 
//I checked the debug line, the lines returned null for resolvedRadiusRaw and resolvedShape. 
/*
//theme.dart
import 'dart:ui' show lerpDouble;

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';

/// Defines the visual properties for a button widget.
///
/// Used to style buttons like [Button], [FilledButton], [HyperlinkButton],
/// and [IconButton].
/// Defines the visual properties for a button widget.
///
/// Used to style buttons like [Button], [FilledButton], [HyperlinkButton],
/// and [IconButton].
class ButtonStyle with Diagnosticable {
  /// Creates a button style.
  const ButtonStyle({
    this.textStyle,
    this.backgroundColor,
    this.foregroundColor,
    this.shadowColor,
    this.elevation,
    this.padding,
    this.shape,
    this.iconSize,
    this.borderRadius,
  });

  /// The text style for the button's child text widgets.
  final WidgetStateProperty<TextStyle?>? textStyle;

  /// The background color of the button.
  final WidgetStateProperty<Color?>? backgroundColor;

  /// The foreground color of the button (text and icon color).
  final WidgetStateProperty<Color?>? foregroundColor;

  /// The shadow color for the button's elevation.
  final WidgetStateProperty<Color?>? shadowColor;

  /// The elevation of the button.
  final WidgetStateProperty<double?>? elevation;

  /// The padding inside the button.
  final WidgetStateProperty<EdgeInsetsGeometry?>? padding;

  /// The shape of the button.
  final WidgetStateProperty<ShapeBorder?>? shape;

  /// The size of icons within the button.
  final WidgetStateProperty<double?>? iconSize;

  /// The border radius for the button. If provided, it takes precedence over
  /// [shape] when creating a rounded rectangle shape.
  final WidgetStateProperty<BorderRadius?>? borderRadius;

  /// Merges this [ButtonStyle] with another, with the other taking precedence.
  ButtonStyle? merge(ButtonStyle? other) {
    if (other == null) return this;
    return ButtonStyle(
      textStyle: other.textStyle ?? textStyle,
      backgroundColor: other.backgroundColor ?? backgroundColor,
      foregroundColor: other.foregroundColor ?? foregroundColor,
      shadowColor: other.shadowColor ?? shadowColor,
      elevation: other.elevation ?? elevation,
      padding: other.padding ?? padding,
      shape: other.shape ?? shape,
      iconSize: other.iconSize ?? iconSize,
      borderRadius: other.borderRadius ?? borderRadius,
    );
  }

  /// Linearly interpolates between two [ButtonStyle] objects.
  static ButtonStyle lerp(ButtonStyle? a, ButtonStyle? b, double t) {
    return ButtonStyle(
      textStyle: lerpWidgetStateProperty<TextStyle?>(
        a?.textStyle,
        b?.textStyle,
        t,
        TextStyle.lerp,
      ),
      backgroundColor: lerpWidgetStateProperty<Color?>(
        a?.backgroundColor,
        b?.backgroundColor,
        t,
        Color.lerp,
      ),
      foregroundColor: lerpWidgetStateProperty<Color?>(
        a?.foregroundColor,
        b?.foregroundColor,
        t,
        Color.lerp,
      ),
      shadowColor: lerpWidgetStateProperty<Color?>(
        a?.shadowColor,
        b?.shadowColor,
        t,
        Color.lerp,
      ),
      elevation: lerpWidgetStateProperty<double?>(
        a?.elevation,
        b?.elevation,
        t,
        lerpDouble,
      ),
      padding: lerpWidgetStateProperty<EdgeInsetsGeometry?>(
        a?.padding,
        b?.padding,
        t,
        EdgeInsetsGeometry.lerp,
      ),
      shape: lerpWidgetStateProperty<ShapeBorder?>(
        a?.shape,
        b?.shape,
        t,
        ShapeBorder.lerp,
      ),
      iconSize: lerpWidgetStateProperty<double?>(
        a?.iconSize,
        b?.iconSize,
        t,
        lerpDouble,
      ),
      borderRadius: lerpWidgetStateProperty<BorderRadius?>(
        a?.borderRadius,
        b?.borderRadius,
        t,
        BorderRadius.lerp,
      ),
    );
  }

  /// Creates a copy of this [ButtonStyle] with the given fields replaced.
  ButtonStyle copyWith({
    WidgetStateProperty<TextStyle?>? textStyle,
    WidgetStateProperty<Color?>? backgroundColor,
    WidgetStateProperty<Color?>? foregroundColor,
    WidgetStateProperty<Color?>? shadowColor,
    WidgetStateProperty<double?>? elevation,
    WidgetStateProperty<EdgeInsetsGeometry?>? padding,
    WidgetStateProperty<ShapeBorder?>? shape,
    WidgetStateProperty<double?>? iconSize,
    WidgetStateProperty<BorderRadius?>? borderRadius,
  }) {
    return ButtonStyle(
      textStyle: textStyle ?? this.textStyle,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      shadowColor: shadowColor ?? this.shadowColor,
      elevation: elevation ?? this.elevation,
      padding: padding ?? this.padding,
      shape: shape ?? this.shape,
      iconSize: iconSize ?? this.iconSize,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }
}

/// An inherited widget that defines the configuration for
/// [Button]s in this widget's subtree.
///
/// Values specified here are used for [Button] properties that are not
/// given an explicit non-null value.
class ButtonTheme extends InheritedTheme {
  /// Creates a theme that controls how descendant [Button]s should look like.
  const ButtonTheme({required super.child, required this.data, super.key});

  /// The properties for descendant [Button] widgets.
  final ButtonThemeData data;

  /// Creates a theme that merges the nearest [ButtonTheme] with [data].
  static Widget merge({
    required ButtonThemeData data,
    required Widget child,
    Key? key,
  }) {
    return Builder(
      builder: (context) {
        return ButtonTheme(
          key: key,
          data: ButtonTheme.of(context).merge(data),
          child: child,
        );
      },
    );
  }

  /// Returns the closest [ButtonThemeData] which encloses the given context.
  ///
  /// Resolution order:
  /// 1. Global theme from [FluentThemeData.buttonTheme]
  /// 2. Local [ButtonTheme] ancestor
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// ButtonThemeData theme = ButtonTheme.of(context);
  /// ```
  static ButtonThemeData of(BuildContext context) {
    assert(debugCheckHasFluentTheme(context));
    final theme = FluentTheme.of(context);
    final inheritedTheme = context.dependOnInheritedWidgetOfExactType<ButtonTheme>();
    // Merge the global theme with any local ButtonTheme if present.
    return theme.buttonTheme.merge(inheritedTheme?.data);
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return ButtonTheme(data: data, child: child);
  }

  @override
  bool updateShouldNotify(ButtonTheme oldWidget) => data != oldWidget.data;
}

/// Theme data for button widgets.
///
/// This class defines the default styles for different button types in the
/// Fluent UI design system.
@immutable
class ButtonThemeData with Diagnosticable {
  /// The style for default [Button] widgets.
  final ButtonStyle? defaultButtonStyle;

  /// The style for [FilledButton] widgets.
  final ButtonStyle? filledButtonStyle;

  /// The style for [HyperlinkButton] widgets.
  final ButtonStyle? hyperlinkButtonStyle;

  /// The style for outlined button widgets.
  final ButtonStyle? outlinedButtonStyle;

  /// The style for [IconButton] widgets.
  final ButtonStyle? iconButtonStyle;

  /// Creates button theme data with optional styles for each button type.
  const ButtonThemeData({
    this.defaultButtonStyle,
    this.filledButtonStyle,
    this.hyperlinkButtonStyle,
    this.outlinedButtonStyle,
    this.iconButtonStyle,
  });

  /// Creates button theme data with the same style for all button types.
  const ButtonThemeData.all(ButtonStyle? style)
    : defaultButtonStyle = style,
      filledButtonStyle = style,
      hyperlinkButtonStyle = style,
      outlinedButtonStyle = style,
      iconButtonStyle = style;

  /// Linearly interpolates between two [ButtonThemeData] objects.
  static ButtonThemeData lerp(
    ButtonThemeData? a,
    ButtonThemeData? b,
    double t,
  ) {
    return const ButtonThemeData();
  }

  /// Merges this [ButtonThemeData] with another, with the other taking
  /// precedence.
  ButtonThemeData merge(ButtonThemeData? style) {
    if (style == null) return this;
    return ButtonThemeData(
      outlinedButtonStyle: style.outlinedButtonStyle ?? outlinedButtonStyle,
      filledButtonStyle: style.filledButtonStyle ?? filledButtonStyle,
      hyperlinkButtonStyle: style.hyperlinkButtonStyle ?? hyperlinkButtonStyle,
      defaultButtonStyle: style.defaultButtonStyle ?? defaultButtonStyle,
      iconButtonStyle: style.iconButtonStyle ?? iconButtonStyle,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(
        DiagnosticsProperty<ButtonStyle>(
          'outlinedButtonStyle',
          outlinedButtonStyle,
        ),
      )
      ..add(
        DiagnosticsProperty<ButtonStyle>(
          'filledButtonStyle',
          filledButtonStyle,
        ),
      )
      ..add(
        DiagnosticsProperty<ButtonStyle>(
          'hyperlinkButtonStyle',
          hyperlinkButtonStyle,
        ),
      )
      ..add(
        DiagnosticsProperty<ButtonStyle>(
          'defaultButtonStyle',
          defaultButtonStyle,
        ),
      )
      ..add(
        DiagnosticsProperty<ButtonStyle>('iconButtonStyle', iconButtonStyle),
      );
  }

  /// Defines the default color used by [Button]s using the current brightness
  /// and state.
  static Color buttonColor(
    BuildContext context,
    Set<WidgetState> states, {
    bool transparentWhenNone = false,
  }) {
    final res = FluentTheme.of(context).resources;
    if (states.isPressed) {
      return res.controlFillColorTertiary;
    } else if (states.isHovered) {
      return res.controlFillColorSecondary;
    } else if (states.isDisabled) {
      return res.controlFillColorDisabled;
    }
    return transparentWhenNone
        ? res.subtleFillColorTransparent
        : res.controlFillColorDefault;
  }

  /// Defines the default foregournd color used by [Button]s using the current brightness
  /// and state.
  static Color buttonForegroundColor(
    BuildContext context,
    Set<WidgetState> states,
  ) {
    final res = FluentTheme.of(context).resources;
    if (states.isPressed) {
      return res.textFillColorSecondary;
    } else if (states.isDisabled) {
      return res.textFillColorDisabled;
    }
    return res.textFillColorPrimary;
  }

  /// Returns the default shape border for buttons based on the current state.
  static ShapeBorder shapeBorder(
    BuildContext context,
    Set<WidgetState> states,
  ) {
    final theme = FluentTheme.of(context);
    final buttonTheme = ButtonTheme.of(context);
    final btnStyle = buttonTheme.defaultButtonStyle ?? const ButtonStyle();
    debugPrint('Resolved ButtonStyle: $btnStyle');

    // Try to resolve a radius and a shape from the style. resolvedRadiusRaw
    // will be null when no borderRadius was provided by the style.
    final resolvedRadiusRaw = btnStyle.borderRadius?.resolve(states);
    debugPrint('Resolved BorderRadius (raw): $resolvedRadiusRaw');

    final resolvedShape = btnStyle.shape?.resolve(states);
    debugPrint('Resolved ShapeBorder: $resolvedShape');

    // Provide a non-null radius fallback to ensure we always return a valid
    // ShapeBorder; however, borderRadius provided in the style takes precedence
    // over a custom shape (per the original intent).
    final resolvedRadius = resolvedRadiusRaw ?? BorderRadius.circular(4);

    // If a borderRadius was explicitly provided in the ButtonStyle (i.e. the
    // resolved raw value is not null), it takes precedence and we create a
    // rounded rectangle using that radius.
    if (resolvedRadiusRaw != null) {
      if (states.isPressed || states.isDisabled) {
        debugPrint('Using RoundedRectangleBorder succcess with radius $resolvedRadius');
        return RoundedRectangleBorder(
          side: BorderSide(color: theme.resources.controlStrokeColorDefault),
          borderRadius: resolvedRadius,
        );
      } else {
        debugPrint('Using RoundedRectangleGradientBorder success with radius $resolvedRadius');
        return RoundedRectangleGradientBorder(
          borderRadius: resolvedRadius,
          gradient: LinearGradient(
            begin: Alignment.center,
            end: const Alignment(0, 3),
            colors: [
              theme.resources.controlStrokeColorSecondary,
              theme.resources.controlStrokeColorDefault,
            ],
            stops: const [0.3, 1.0],
          ),
        );
      }
    }

    // If no borderRadius was provided but a custom shape is provided, use it.
    if (resolvedShape != null) return resolvedShape;

    // Otherwise fallback to the original default radius of 4.
    if (states.isPressed || states.isDisabled) {
      return RoundedRectangleBorder(
        side: BorderSide(color: theme.resources.controlStrokeColorDefault),
        borderRadius: resolvedRadius,
      );
    } else {
      return RoundedRectangleGradientBorder(
        borderRadius: resolvedRadius,
        gradient: LinearGradient(
          begin: Alignment.center,
          end: const Alignment(0, 3),
          colors: [
            theme.resources.controlStrokeColorSecondary,
            theme.resources.controlStrokeColorDefault,
          ],
          stops: const [0.3, 1.0],
        ),
      );
    }
  }

  /// Defines the default color used for inputs when checked, such as checkbox,
  /// radio button and toggle switch. It's based on the current style and the
  /// current state.
  static Color checkedInputColor(
    FluentThemeData theme,
    Set<WidgetState> states,
  ) {
    return FilledButton.backgroundColor(theme, states);
  }

  /// Defines the default color used for unchecked inputs, such as checkbox,
  /// radio button and toggle switch, based on the current state.
  static Color uncheckedInputColor(
    FluentThemeData theme,
    Set<WidgetState> states, {
    bool transparentWhenNone = false,
    bool transparentWhenDisabled = false,
  }) {
    final res = theme.resources;
    if (states.isDisabled) {
      if (transparentWhenDisabled) return res.subtleFillColorTransparent;
      return res.controlAltFillColorDisabled;
    }
    if (states.isPressed) return res.subtleFillColorTertiary;
    if (states.isHovered) return res.subtleFillColorSecondary;
    return transparentWhenNone
        ? res.subtleFillColorTransparent
        : res.controlAltFillColorSecondary;
  }
}


//base.dart

/// {@template fluent_ui.buttons.base}
/// A button gives the user a way to trigger an immediate action. Some buttons
/// are specialized for particular tasks, such as navigation, repeated actions,
/// or presenting menus.
/// {@endtemplate}
///
/// {@tool snippet}
/// This example shows how to use a basic button:
///
/// ```dart
/// Button(
///   child: Text('Click me'),
///   onPressed: () {
///     print('Button pressed!');
///   },
/// )
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [HyperlinkButton], a borderless button with mainly text-based content
///  * [OutlinedButton], an outlined button
///  * [FilledButton], a colored button for primary actions
///  * [IconButton], a button that displays only an icon
///  * [ToggleButton], a button that can be toggled on and off
///  * <https://learn.microsoft.com/en-us/windows/apps/design/controls/buttons>
abstract class BaseButton extends StatefulWidget {
  /// Creates a base button.
  const BaseButton({
    required this.onPressed,
    required this.onLongPress,
    required this.onTapDown,
    required this.onTapUp,
    required this.style,
    required this.focusNode,
    required this.autofocus,
    required this.child,
    required this.focusable,
    super.key,
  });

  /// Called when the button is tapped or otherwise activated.
  ///
  /// If this callback, [onLongPress], [onTapDown], and [onTapUp] are null,
  /// then the button will be disabled.
  ///
  /// See also:
  ///
  ///  * [enabled], which is true if the button is enabled.
  final GestureTapCallback? onPressed;

  /// Called when the button is pressed.
  ///
  /// If this callback, [onLongPress], [onPressed] and [onTapUp] are null,
  /// then the button will be disabled.
  ///
  /// See also:
  ///
  ///  * [enabled], which is true if the button is enabled.
  final GestureTapDownCallback? onTapDown;

  /// Called when the button is released.
  ///
  /// If this callback, [onLongPress], [onPressed] and [onTapDown] are null,
  /// then the button will be disabled.
  ///
  /// See also:
  ///
  ///  * [enabled], which is true if the button is enabled.
  final GestureTapUpCallback? onTapUp;

  /// Called when the button is long-pressed.
  ///
  /// If this callback, [onPressed], [onTapDown] and [onTapUp] are null,
  /// then the button will be disabled.
  ///
  /// See also:
  ///
  ///  * [enabled], which is true if the button is enabled.
  final GestureLongPressCallback? onLongPress;

  /// Customizes this button's appearance.
  final ButtonStyle? style;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  /// Typically the button's label.
  ///
  /// Usually a [Text] widget
  final Widget child;

  /// Whether this button can be focused.
  final bool focusable;

  /// Returns the default style for this button type based on the context.
  @protected
  ButtonStyle defaultStyleOf(BuildContext context);

  /// Returns the theme style for this button type, if defined.
  @protected
  ButtonStyle? themeStyleOf(BuildContext context);

  /// Whether the button is enabled or disabled.
  ///
  /// Buttons are disabled by default. To enable a button, set its [onPressed],
  /// [onLongPress], [onTapDown] or [onTapUp] properties to a non-null value.
  bool get enabled =>
      onPressed != null ||
      onLongPress != null ||
      onTapDown != null ||
      onTapUp != null;

  @override
  State<BaseButton> createState() => _BaseButtonState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(FlagProperty('enabled', value: enabled, ifFalse: 'disabled'))
      ..add(
        DiagnosticsProperty<ButtonStyle>('style', style, defaultValue: null),
      )
      ..add(
        DiagnosticsProperty<FocusNode>(
          'focusNode',
          focusNode,
          defaultValue: null,
        ),
      )
      ..add(
        DiagnosticsProperty<bool>('autofocus', autofocus, defaultValue: false),
      );
  }
}

class _BaseButtonState extends State<BaseButton> {
  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasFluentTheme(context));
    final theme = FluentTheme.of(context);

    final widgetStyle = widget.style;
    final themeStyle = widget.themeStyleOf(context);
    final defaultStyle = widget.defaultStyleOf(context);

    T? effectiveValue<T>(T? Function(ButtonStyle? style) getProperty) {
      final widgetValue = getProperty(widgetStyle);
      final themeValue = getProperty(themeStyle);
      final defaultValue = getProperty(defaultStyle);
      return widgetValue ?? themeValue ?? defaultValue;
    }

    return HoverButton(
      autofocus: widget.autofocus,
      focusNode: widget.focusNode,
      onPressed: widget.onPressed,
      onLongPress: widget.onLongPress,
      focusEnabled: widget.focusable,
      onTapDown: widget.onTapDown,
      onTapUp: widget.onTapUp,
      builder: (context, states) {
        T? resolve<T>(
          WidgetStateProperty<T>? Function(ButtonStyle? style) getProperty,
        ) {
          return effectiveValue((style) => getProperty(style)?.resolve(states));
        }

        final resolvedElevation = resolve<double?>((style) => style?.elevation);
        final resolvedTextStyle = theme.typography.body?.merge(
          resolve<TextStyle?>((style) => style?.textStyle),
        );
        final resolvedBackgroundColor = resolve<Color?>(
          (style) => style?.backgroundColor,
        );
        final resolvedForegroundColor = resolve<Color?>(
          (style) => style?.foregroundColor,
        );
        final resolvedShadowColor = resolve<Color?>((style) => style?.shadowColor);
        final resolvedPadding =
            resolve<EdgeInsetsGeometry?>((style) => style?.padding) ??
            EdgeInsetsDirectional.zero;
        final resolvedShape =
            resolve<ShapeBorder?>((style) => style?.shape) ?? const RoundedRectangleBorder();
        final resolvedBorderRadius =
            resolve<BorderRadius?>((style) => style?.borderRadius);

        // If a border radius is provided directly by the style, prefer it over
        // any provided shape; create a gradient border when appropriate to match
        // the default theme border behavior.
        final resolvedShapeEffective = resolvedBorderRadius != null
            ? (states.isPressed || states.isDisabled
                ? RoundedRectangleBorder(
                    side: BorderSide(color: theme.resources.controlStrokeColorDefault),
                    borderRadius: resolvedBorderRadius,
                  )
                : RoundedRectangleGradientBorder(
                    borderRadius: resolvedBorderRadius,
                    gradient: LinearGradient(
                      begin: Alignment.center,
                      end: const Alignment(0, 3),
                      colors: [
                        theme.resources.controlStrokeColorSecondary,
                        theme.resources.controlStrokeColorDefault,
                      ],
                      stops: const [0.3, 1.0],
                    ),
                  ))
            : resolvedShape;

        final padding = resolvedPadding
            .add(
              EdgeInsetsDirectional.symmetric(
                horizontal: theme.visualDensity.horizontal,
                vertical: theme.visualDensity.vertical,
              ),
            )
            .clamp(EdgeInsetsDirectional.zero, EdgeInsetsGeometry.infinity);
        final iconSize = resolve<double?>((style) => style?.iconSize);
        final Widget result = PhysicalModel(
          color: Colors.transparent,
          shadowColor: resolvedShadowColor ?? Colors.black,
          elevation: resolvedElevation ?? 0.0,
          borderRadius: resolvedShapeEffective is RoundedRectangleBorder
              ? resolvedShapeEffective.borderRadius is BorderRadius
                    ? resolvedShapeEffective.borderRadius as BorderRadius
                    : BorderRadius.zero
              : BorderRadius.zero,
          child: AnimatedContainer(
            duration: theme.fasterAnimationDuration,
            curve: theme.animationCurve,
            decoration: ShapeDecoration(
              shape: resolvedShapeEffective,
              color: resolvedBackgroundColor,
            ),
            padding: padding,
            child: IconTheme.merge(
              data: IconThemeData(
                color: resolvedForegroundColor,
                size: iconSize ?? 14.0,
              ),
              child: AnimatedDefaultTextStyle(
                duration: theme.fastAnimationDuration,
                curve: theme.animationCurve,
                style: DefaultTextStyle.of(context).style.merge(
                  (resolvedTextStyle ?? const TextStyle()).copyWith(
                    color: resolvedForegroundColor,
                  ),
                ),
                textAlign: TextAlign.center,
                // used to align the child without expanding the button
                child: Center(
                  heightFactor: 1,
                  widthFactor: 1,
                  child: widget.child,
                ),
              ),
            ),
          ),
        );
        return Semantics(
          container: true,
          button: true,
          enabled: widget.enabled,
          child: FocusBorder(focused: states.isFocused, child: result),
        );
      },
    );
  }
}


//button.dart

/// The default padding applied to fluent-styled buttons.
///
/// This matches the padding used by WinUI button controls.
const kDefaultButtonPadding = EdgeInsetsDirectional.only(
  start: 11,
  top: 5,
  end: 11,
  bottom: 6,
);

/// A standard button control that triggers an immediate action when clicked.
///
/// The [Button] widget is the most common type of button in Windows applications.
/// It has a neutral appearance with a subtle background that responds to hover,
/// press, and focus states.
///
/// ![Button Example](https://learn.microsoft.com/en-us/windows/apps/design/controls/images/button.png)
///
/// {@tool snippet}
/// This example shows a basic button with a text label:
///
/// ```dart
/// Button(
///   child: Text('Click me'),
///   onPressed: () {
///     print('Button was pressed!');
///   },
/// )
/// ```
/// {@end-tool}
///
/// {@tool snippet}
/// This example shows a button with an icon and text:
///
/// ```dart
/// Button(
///   child: Row(
///     mainAxisSize: MainAxisSize.min,
///     children: [
///       Icon(FluentIcons.add),
///       SizedBox(width: 8),
///       Text('Add item'),
///     ],
///   ),
///   onPressed: () => addItem(),
/// )
/// ```
/// {@end-tool}
///
/// ## Button states
///
/// The button automatically updates its appearance based on its current state:
///
/// * **Rest**: The default appearance when not interacted with
/// * **Hover**: When the pointer is over the button
/// * **Pressed**: When the button is being pressed
/// * **Disabled**: When [onPressed] is null
/// * **Focused**: When the button has keyboard focus
///
/// ## Accessibility
///
/// The button is automatically accessible to screen readers. The [child] widget's
/// text content is used as the button's accessible label. For buttons with only
/// icons, consider wrapping the button in a [Tooltip] or using [Semantics] to
/// provide an accessible label.
///
/// See also:
///
///  * [FilledButton], an accent-colored button for primary actions
///  * [OutlinedButton], a button with an outlined border
///  * [HyperlinkButton], a borderless button styled like a hyperlink
///  * [IconButton], a button that displays only an icon
///  * [ToggleButton], a button that can be toggled on and off
///  * [SplitButton], a button with two parts - one for the action and one for a menu
///  * <https://learn.microsoft.com/en-us/windows/apps/design/controls/buttons>
class Button extends BaseButton {
  /// Creates a standard button.
  ///
  /// The [child] and [onPressed] arguments are required. Set [onPressed] to
  /// null to disable the button.
  const Button({
    required super.child,
    required super.onPressed,
    super.key,
    super.onLongPress,
    super.onTapDown,
    super.onTapUp,
    super.focusNode,
    super.autofocus = false,
    super.style,
    super.focusable = true,
  });

  @override
  ButtonStyle defaultStyleOf(BuildContext context) {
    assert(debugCheckHasFluentTheme(context));
    final theme = FluentTheme.of(context);
    return ButtonStyle(
      shadowColor: WidgetStatePropertyAll(theme.shadowColor),
      padding: const WidgetStatePropertyAll(kDefaultButtonPadding),
      shape: WidgetStateProperty.resolveWith((states) {
        return ButtonThemeData.shapeBorder(context, states);
      }),
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        return ButtonThemeData.buttonColor(context, states);
      }),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        return ButtonThemeData.buttonForegroundColor(context, states);
      }),
    );
  }

  @override
  ButtonStyle? themeStyleOf(BuildContext context) {
    assert(debugCheckHasFluentTheme(context));
    return ButtonTheme.of(context).defaultButtonStyle;
  }
}
*/
