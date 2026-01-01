import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/rendering.dart';

/// The default shape of a grid tile.
const kDefaultGridTileShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.all(Radius.circular(4)),
);

/// The default margin of a grid tile.
const kDefaultGridTileMargin = EdgeInsets.symmetric(
  horizontal: 4,
  vertical: 2,
);

/// The default padding of a grid tile.
const kDefaultGridTilePadding = EdgeInsets.all(8);

/// The selection mode of a grid tile.
enum GridTileSelectionMode {
  /// The grid tile is not selectable.
  none,

  /// Only one item can be selected at a time.
  single,

  /// Multiple items can be selected at a time.
  multiple,
}

/// The location of the checkbox in a selectable grid tile with multiple selection mode.
enum CheckboxLocation {
  /// The checkbox is located at the top right corner of the grid tile.
  topRight,

  /// The checkbox is located at the top left corner of the grid tile.
  topLeft,

  /// The checkbox is located at the bottom right corner of the grid tile.
  bottomRight,

  /// The checkbox is located at the bottom left corner of the grid tile.
  bottomLeft,
}

/// A windows-styled grid tile.
///
/// See also:
///
///  * [GridView], a scrollable grid of widgets arranged in a 2D array.
class GridTile extends StatelessWidget {
  /// A windows-styled grid tile
  const GridTile({
    super.key,
    this.tileColor,
    this.shape = kDefaultGridTileShape,
    this.child,
    this.onPressed,
    this.focusNode,
    this.autofocus = false,
    this.semanticLabel,
    this.cursor,
    this.padding = kDefaultGridTilePadding,
    this.margin = kDefaultGridTileMargin,
  })  : selected = false,
        selectionMode = GridTileSelectionMode.none,
        onSelectionChange = null,
        checkboxLocation = CheckboxLocation.topRight;

  /// A selectable grid tile.
  const GridTile.selectable({
    super.key,
    this.tileColor,
    this.shape = kDefaultGridTileShape,
    this.child,
    this.onPressed,
    this.focusNode,
    this.autofocus = false,
    this.selected = false,
    this.selectionMode = GridTileSelectionMode.single,
    this.onSelectionChange,
    this.semanticLabel,
    this.cursor,
    this.padding = kDefaultGridTilePadding,
    this.margin = kDefaultGridTileMargin,
    this.checkboxLocation = CheckboxLocation.topRight,
  });

  /// The background color of the tile.
  ///
  /// If null, [ButtonThemeData.uncheckedInputColor] is used by default
  final WidgetStateColor? tileColor;

  /// The tile shape.
  ///
  /// [kDefaultGridTileShape] is used by default
  final ShapeBorder shape;

  /// The primary content of the grid tile.
  final Widget? child;

  /// Called when the user taps this grid tile.
  ///
  /// If null, and [onSelectionChange] is also null, the tile does not perform
  /// any action
  final VoidCallback? onPressed;

  /// Whether this tile is selected within the grid.
  ///
  /// See also:
  ///
  ///  * [selectionMode], which changes how the tile behave within the grid
  ///  * [onSelectionChange], which is called when the selection changes
  final bool selected;

  /// How the tile selection will behave within the grid
  ///
  /// See also:
  ///
  ///  * [selected], which tells the widget whether it's selected or not
  ///  * [onSelectionChange], which is called when the selection changes
  final GridTileSelectionMode selectionMode;

  /// Called when the selection changes.
  ///
  /// If [selectionMode] is single, this is called when any unselected tile is
  /// pressed. If [selectionMode] is multiple, this is called when any tile is
  /// pressed
  ///
  /// See also:
  ///
  ///  * [selected], which tells the widget whether it's selected or not
  ///  * [selectionMode], which changes how the tile behave within the grid
  final ValueChanged<bool>? onSelectionChange;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  /// {@macro fluent_ui.controls.inputs.HoverButton.semanticLabel}
  final String? semanticLabel;

  /// Mouse Cursor to display
  ///
  /// If null, [MouseCursor.defer] is used by default
  ///
  /// See also cursors like:
  ///
  ///  * [SystemMouseCursors.click], which turns the mouse cursor to click
  final MouseCursor? cursor;

  /// Padding applied to grid tile content
  ///
  /// Defaults to [kDefaultGridTilePadding]
  final EdgeInsetsGeometry padding;

  /// Padding applied between this tile's [FocusBorder] and outer decoration.
  ///
  /// Defaults to [kDefaultGridTileMargin].
  final EdgeInsetsGeometry? margin;

  /// The location of the checkbox when [selectionMode] is [GridTileSelectionMode.multiple].
  ///
  /// Defaults to [CheckboxLocation.topRight].
  final CheckboxLocation checkboxLocation;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(
        DiagnosticsProperty<ShapeBorder>(
          'shape',
          shape,
          defaultValue: kDefaultGridTileShape,
        ),
      )
      ..add(
        FlagProperty(
          'selected',
          value: selected,
          ifFalse: 'unselected',
          defaultValue: false,
        ),
      )
      ..add(
        EnumProperty(
          'selectionMode',
          selectionMode,
          defaultValue: GridTileSelectionMode.none,
        ),
      )
      ..add(
        FlagProperty(
          'enabled',
          value: onPressed != null || onSelectionChange != null,
          defaultValue: false,
          ifFalse: 'disabled',
        ),
      )
      ..add(
        DiagnosticsProperty<EdgeInsetsGeometry>(
          'padding',
          padding,
          defaultValue: kDefaultGridTilePadding,
        ),
      )
      ..add(
        DiagnosticsProperty<EdgeInsetsGeometry?>(
          'margin',
          margin,
          defaultValue: kDefaultGridTileMargin,
        ),
      );
  }

  void _onSelectionChange() {
    switch (selectionMode) {
      case GridTileSelectionMode.multiple:
        onSelectionChange!(!selected);
      case GridTileSelectionMode.single:
        if (!selected) onSelectionChange!(true);
      default:
        break;
    }
  }

  static Color backgroundColor(FluentThemeData theme, Set<WidgetState> states) {
    if (states.isDisabled) {
      return theme.resources.accentFillColorDisabled;
    } else if (states.isPressed) {
      return theme.accentColor.tertiaryBrushFor(theme.brightness);
    } else if (states.isHovered) {
      return theme.accentColor.secondaryBrushFor(theme.brightness);
    } else {
      return theme.accentColor.defaultBrushFor(theme.brightness);
    }
  }

  Alignment _getCheckboxAlignment() {
    switch (checkboxLocation) {
      case CheckboxLocation.topRight:
        return Alignment.topRight;
      case CheckboxLocation.topLeft:
        return Alignment.topLeft;
      case CheckboxLocation.bottomRight:
        return Alignment.bottomRight;
      case CheckboxLocation.bottomLeft:
        return Alignment.bottomLeft;
    }
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasFluentTheme(context));

    final theme = FluentTheme.of(context);

    return HoverButton(
      onPressed:
          onPressed ?? (onSelectionChange != null ? _onSelectionChange : null),
      focusNode: focusNode,
      autofocus: autofocus,
      cursor: cursor,
      semanticLabel: semanticLabel,
      builder: (context, states) {
        final tileColor = () {
          if (this.tileColor != null) {
            return this.tileColor!.resolve(states);
          }

          return ButtonThemeData.uncheckedInputColor(
            theme,
            selected ? {...states, WidgetState.hovered} : states,
            transparentWhenNone: true,
            transparentWhenDisabled: true,
          );
        }();

        Widget content = Padding(
          padding: padding,
          child: child,
        );

        if (selectionMode == GridTileSelectionMode.multiple) {
          content = Stack(
            alignment: _getCheckboxAlignment(),
            children: [
              content,
              Positioned(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: IgnorePointer(
                    child: ExcludeFocus(
                      child: Checkbox(
                        checked: selected,
                        onChanged: (v) {
                          onSelectionChange?.call(v ?? false);
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }

        return Semantics(
          container: true,
          selected: selectionMode == GridTileSelectionMode.none
              ? null
              : selected,
          child: FocusBorder(
            focused: selected,
            renderOutside: false,
            child: FocusTheme(
              data: FocusThemeData(
                borderRadius: BorderRadius.circular(8.0),
                glowFactor: 0,
                primaryBorder: BorderSide(
                        width: 1,
                        color: Colors.red,
                      ),
              ),
              child: Container(
                decoration: ShapeDecoration(shape: shape, color: tileColor),
                margin: margin,
                child: content,
              ),
            ),
          ),
        );
      },
    );
  }
}
