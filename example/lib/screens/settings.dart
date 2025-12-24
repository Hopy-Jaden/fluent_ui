// ignore_for_file: constant_identifier_names

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:provider/provider.dart';

import '../theme.dart';
import '../widgets/page.dart';

const List<String> accentColorNames = [
  'System',
  'Yellow',
  'Orange',
  'Red',
  'Magenta',
  'Purple',
  'Blue',
  'Teal',
  'Green',
];

bool get kIsWindowEffectsSupported {
  return !kIsWeb &&
      [
        TargetPlatform.windows,
        TargetPlatform.linux,
        TargetPlatform.macOS,
      ].contains(defaultTargetPlatform);
}

const _LinuxWindowEffects = [WindowEffect.disabled, WindowEffect.transparent];

const _WindowsWindowEffects = [
  WindowEffect.disabled,
  WindowEffect.solid,
  WindowEffect.transparent,
  WindowEffect.aero,
  WindowEffect.acrylic,
  WindowEffect.mica,
  WindowEffect.tabbed,
];

const _MacosWindowEffects = [
  WindowEffect.disabled,
  WindowEffect.titlebar,
  WindowEffect.selection,
  WindowEffect.menu,
  WindowEffect.popover,
  WindowEffect.sidebar,
  WindowEffect.headerView,
  WindowEffect.sheet,
  WindowEffect.windowBackground,
  WindowEffect.hudWindow,
  WindowEffect.fullScreenUI,
  WindowEffect.toolTip,
  WindowEffect.contentBackground,
  WindowEffect.underWindowBackground,
  WindowEffect.underPageBackground,
];

List<WindowEffect> get currentWindowEffects {
  if (kIsWeb) return [];

  if (defaultTargetPlatform == TargetPlatform.windows) {
    return _WindowsWindowEffects;
  } else if (defaultTargetPlatform == TargetPlatform.linux) {
    return _LinuxWindowEffects;
  } else if (defaultTargetPlatform == TargetPlatform.macOS) {
    return _MacosWindowEffects;
  }

  return [];
}

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> with PageMixin {
  @override
  Widget build(final BuildContext context) {
    assert(debugCheckHasMediaQuery(context));
    final appTheme = context.watch<AppTheme>();
    final expanderKey = GlobalKey<ExpanderState>(debugLabel: 'Expander key');
    const spacer = SizedBox(height: 10);
    const biggerSpacer = SizedBox(height: 40);

    const supportedLocales = FluentLocalizations.supportedLocales;
    final currentLocale =
        appTheme.locale ?? Localizations.maybeLocaleOf(context);
    return ScaffoldPage.scrollable(
      header: const PageHeader(title: Text('Settings')),
      children: [
        Card(
          padding: EdgeInsetsGeometry.symmetric(vertical: 8.0),
          child: ListTile(
            title: Text(
              'Theme',
            ), //Header of the settings //Description of the settings
            leading: Icon(WindowsIcons.blue_light), //Icon typically included in the card
            trailing: ComboBox<ThemeMode>(
              value: appTheme.mode,
              items: List.generate(ThemeMode.values.length, (final index) {
                final mode = ThemeMode.values[index];
                return ComboBoxItem(
                  value: mode,
                  child: Text('$mode'.replaceAll('ThemeMode.', '')),
                );
              }),
              onChanged: (final ThemeMode? value) => setState(() {
                if (value == null) return;
                debugPrint('ThemeMode.$value');
                appTheme.mode = value;
                if (kIsWindowEffectsSupported) {
                  appTheme.setEffect(appTheme.windowEffect, context);
                }
              }),
            ),
          ),
        ),
        spacer,
        Card(
          padding: EdgeInsetsGeometry.symmetric(vertical: 8.0),
          child: ListTile(
            title: Text(
              'Pane Mode',
            ), //Header of the settings //Description of the settings
            leading: Icon(WindowsIcons.open_pane_mirrored), //Icon typically included in the card
            trailing: ComboBox<PaneDisplayMode>(
              value: appTheme.displayMode,
              items: List.generate(PaneDisplayMode.values.length, (final index) {
                final mode = PaneDisplayMode.values[index];
                return ComboBoxItem(
                  value: mode,
                  child: Text('$mode'.replaceAll('PaneDisplayMode.', '')),
                );
              }),
              onChanged: (final PaneDisplayMode? value) => setState(() {
                if (value == null) return;
                appTheme.displayMode = value;
              }),
            ),
          ),
        ),
        spacer,
        Card(
          padding: EdgeInsetsGeometry.symmetric(vertical: 8.0),
          child: ListTile(
            title: Text(
              'Navigation Indicator',
            ), //Header of the settings //Description of the settings
            leading: Icon(WindowsIcons.text_navigate), //Icon typically included in the card
            trailing: ComboBox<NavigationIndicators>(
              value: appTheme.indicator,
              items: List.generate(NavigationIndicators.values.length, (final index) {
                final mode = NavigationIndicators.values[index];
                return ComboBoxItem(
                  value: mode,
                  child: Text('$mode'.replaceAll('NavigationIndicators.', '')),
                );
              }),
              onChanged: (final NavigationIndicators? value) => setState(() {
                if (value == null) return;
                appTheme.indicator = value;
              }),
            ),
          ),
        ),
        spacer,
        HoverButton(
          onPressed: () {
            //function when the settings card is clicked
          },
          builder: (final context, final states) {
            return FocusBorder(
              focused: states.isFocused,
              renderOutside: false,
              child: AnimatedContainer(
                duration: FluentTheme.of(context).fasterAnimationDuration,
                decoration: BoxDecoration(
                  color: ButtonThemeData.uncheckedInputColor(
                    FluentTheme.of(context),
                    states,
                    transparentWhenNone: true,
                  ),
                ),
                child: Expander(
                  key: expanderKey,
                  header: Padding(
                    padding: EdgeInsetsGeometry.symmetric(vertical: 8.0),
                    child: ListTile(
                      tileColor: WidgetStateColor.resolveWith(
                        (states) => Colors.transparent,
                      ), //to prevent hover color from showing when clicking on list tile region
                      onPressed: () {
                        final open =
                            expanderKey.currentState?.isExpanded ?? false;
                        expanderKey.currentState?.isExpanded = !open;
                      }, //to allow expander to expand when clicking on list tile region
                      title: Text('Accent Color'),
                      leading: Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Icon(WindowsIcons.color),
                      ),
                    ),
                  ),
                  content: Wrap(
                    children: [
                      Tooltip(
                        message: accentColorNames[0],
                        child: _buildColorBlock(appTheme, systemAccentColor),
                      ),
                      ...List.generate(Colors.accentColors.length, (
                        final index,
                      ) {
                        final color = Colors.accentColors[index];
                        return Tooltip(
                          message: accentColorNames[index + 1],
                          child: _buildColorBlock(appTheme, color),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        if (kIsWindowEffectsSupported) ...[
          spacer,
          Card(
          padding: EdgeInsetsGeometry.symmetric(vertical: 8.0),
          child: ListTile(
            title: Text(
              'Transparency Effect',
            ), //Header of the settings //Description of the settings
            subtitle: Text(
              'Only in windows effect supported platforms.',
            ),
            leading: Icon(WindowsIcons.effects), //Icon typically included in the card
            trailing: ComboBox<WindowEffect>(
              value: appTheme.windowEffect,
              items: List.generate(currentWindowEffects.length, (final index) {
                final mode = currentWindowEffects[index];
                return ComboBoxItem<WindowEffect>(
                  value: mode,
                  child: Text('$mode'.replaceAll('WindowEffect.', '')),
                );
              }),
              onChanged: (final WindowEffect? value) => setState(() {
                if (value == null) return;
                appTheme.windowEffect = value;
                appTheme.setEffect(value, context);
              }),
            ),
          ),
        ),
        ],
        spacer,
        Card(
          padding: EdgeInsetsGeometry.symmetric(vertical: 8.0),
          child: ListTile(
            title: Text(
              'Text Direction',
            ), //Header of the settings //Description of the settings
            leading: Icon(WindowsIcons.map_directions), //Icon typically included in the card
            trailing: ComboBox<TextDirection>(
              value: appTheme.textDirection,
              items: List.generate(TextDirection.values.length, (final index) {
                final mode = TextDirection.values[index];
                return ComboBoxItem(
                  value: mode,
                  child: Text(                '$mode'
                    .replaceAll('TextDirection.', '')
                    .replaceAll('rtl', 'Right to left')
                    .replaceAll('ltr', 'Left to right'),
              ),
                );
              }).reversed.toList(),
              onChanged: (final TextDirection? value) => setState(() {
                if (value == null) return;
                appTheme.textDirection = value;
              }),
            ),
          ),
        ),
        spacer,
        Card(
          padding: EdgeInsetsGeometry.symmetric(vertical: 8.0),
          child: ListTile(
            title: Text(
              'Locale',
            ), //Header of the settings //Description of the settings
            subtitle: Text('The locale used by the Windows UI widgets, such as TimePicker and '
            'DatePicker. This does not reflect the language of this showcase app.',),
            leading: Icon(WindowsIcons.globe), //Icon typically included in the card
            trailing: ComboBox<Locale>(
              value: appTheme.locale,
              items: List.generate(supportedLocales.length, (final index) {
                final locale = supportedLocales[index];
                return ComboBoxItem(
                  value: locale,
                  child: Text('$locale'),
                );
              }),
              onChanged: (final Locale? value) => setState(() {
                if (value == null) return;
                appTheme.locale = value;
              }),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildColorBlock(final AppTheme appTheme, final AccentColor color) {
    return Padding(
      padding: const EdgeInsetsDirectional.all(2),
      child: Button(
        onPressed: () {
          appTheme.color = color;
        },
        style: ButtonStyle(
          padding: const WidgetStatePropertyAll(EdgeInsetsDirectional.zero),
          backgroundColor: WidgetStateProperty.resolveWith((final states) {
            if (states.isPressed) {
              return color.light;
            } else if (states.isHovered) {
              return color.lighter;
            }
            return color;
          }),
        ),
        child: Container(
          height: 40,
          width: 40,
          alignment: AlignmentDirectional.center,
          child: appTheme.color == color
              ? Icon(
                  FluentIcons.check_mark,
                  color: color.basedOnLuminance(),
                  size: 22,
                )
              : null,
        ),
      ),
    );
  }
}
