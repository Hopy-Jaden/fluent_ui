// ignore_for_file: constant_identifier_names

import 'package:flutter/foundation.dart';

import 'package:fluent_ui/fluent_ui.dart';
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

const _LinuxWindowEffects = [
  WindowEffect.disabled,
  WindowEffect.transparent,
];

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
  Widget build(BuildContext context) {
    assert(debugCheckHasMediaQuery(context));
    final appTheme = context.watch<AppTheme>();
    const spacer = SizedBox(height: 10.0);
    const biggerSpacer = SizedBox(height: 40.0);
    const supportedLocales = FluentLocalizations.supportedLocales;
    final currentLocale =
        appTheme.locale ?? Localizations.maybeLocaleOf(context);
    return ScaffoldPage.scrollable(
      header: const PageHeader(title: Text('Settings')),
      children: [
        Text('Appearance and Behavior',
            style: FluentTheme.of(context).typography.subtitle),
        spacer,
        Card(
          child: ListTile(
            leading: Icon(FluentIcons.color),
            title: Text('App Theme'),
            subtitle: Text('Select which app theme to display'),
            trailing: ComboBox<ThemeMode>(
              value: appTheme.mode,
              items: List.generate(ThemeMode.values.length, (index) {
                final mode = ThemeMode.values[index];
                return ComboBoxItem(
                    value: mode,
                    child: Text('$mode'.replaceAll('ThemeMode.', '')));
              }),
              onChanged: (mode) {
                setState(() {
                  appTheme.mode = mode as ThemeMode;
                  if (kIsWindowEffectsSupported) {
                    // some window effects require on [dark] to look good.
                    // appTheme.setEffect(WindowEffect.disabled, context);
                    appTheme.setEffect(appTheme.windowEffect, context);
                  }
                });
              },
            ),
          ),
        ),
        spacer,
        Card(
          child: ListTile(
            leading: Icon(FluentIcons.side_panel),
            title: Text('Navigation Style'),
            trailing: ComboBox<PaneDisplayMode>(
              value: appTheme.displayMode,
              items: List.generate(PaneDisplayMode.values.length, (index) {
                final mode = PaneDisplayMode.values[index];
                return ComboBoxItem(
                  value: mode,
                  child: Text(
                    mode.toString().replaceAll('PaneDisplayMode.', ''),
                  ),
                );
              }),
              onChanged: (mode) {
                setState(() {
                  appTheme.displayMode = mode as PaneDisplayMode;
                  if (kIsWindowEffectsSupported) {
                    // some window effects require on [dark] to look good.
                    // appTheme.setEffect(WindowEffect.disabled, context);
                    appTheme.setEffect(appTheme.windowEffect, context);
                  }
                });
              },
            ),
          ),
        ),
        spacer,
        Card(
          child: ListTile(
            leading: Icon(FluentIcons.collapse_menu),
            title: Text('Navigation Indicator'),
            trailing: ComboBox<NavigationIndicators>(
              value: appTheme.indicator,
              items: List.generate(NavigationIndicators.values.length, (index) {
                final mode = NavigationIndicators.values[index];
                return ComboBoxItem(
                  value: mode,
                  child: Text(
                    mode.toString().replaceAll('NavigationIndicators.', ''),
                  ),
                );
              }),
              onChanged: (mode) {
                setState(() {
                  appTheme.indicator = mode as NavigationIndicators;
                  if (kIsWindowEffectsSupported) {
                    // some window effects require on [dark] to look good.
                    // appTheme.setEffect(WindowEffect.disabled, context);
                    appTheme.setEffect(appTheme.windowEffect, context);
                  }
                });
              },
            ),
          ),
        ),
        spacer,
        Expander(
          header: Padding(
            padding: EdgeInsets.symmetric(vertical: 12.0),
            child: ListTile(
              leading: Icon(FluentIcons.format_painter),
              title: Text('Accent Color'),
            ),
          ),
          content: Wrap(children: [
            Tooltip(
              message: accentColorNames[0],
              child: _buildColorBlock(appTheme, systemAccentColor),
            ),
            ...List.generate(Colors.accentColors.length, (index) {
              final color = Colors.accentColors[index];
              return Tooltip(
                message: accentColorNames[index + 1],
                child: _buildColorBlock(appTheme, color),
              );
            }),
          ]),
        ),
        if (kIsWindowEffectsSupported) ...[
          spacer,
          Card(
            child: ListTile(
              leading: Icon(FluentIcons.glimmer),
              title: Text('Window Transparency'),
              subtitle: Text(
                'Running on ${defaultTargetPlatform.toString().replaceAll('TargetPlatform.', '')}',
              ),
              trailing: ComboBox<WindowEffect>(
                value: appTheme.windowEffect,
                items: List.generate(currentWindowEffects.length, (index) {
                  final mode = currentWindowEffects[index];
                  return ComboBoxItem(
                    value: mode,
                    child: Text(
                      mode.toString().replaceAll('WindowEffect.', ''),
                    ),
                  );
                }),
                onChanged: (mode) {
                  setState(() {
                    appTheme.windowEffect = mode as WindowEffect;
                    appTheme.setEffect(mode, context);
                    if (kIsWindowEffectsSupported) {
                      // some window effects require on [dark] to look good.
                      // appTheme.setEffect(WindowEffect.disabled, context);
                      appTheme.setEffect(appTheme.windowEffect, context);
                    }
                  });
                },
              ),
            ),
          ),
        ],
        biggerSpacer,
        Text('Text', style: FluentTheme.of(context).typography.subtitle),
        spacer,
        Card(
          child: ListTile(
            leading: Icon(FluentIcons.text_rotate_horizontal),
            title: Text('Text Direction'),
            trailing: ComboBox<TextDirection>(
              value: appTheme.textDirection,
              items: List.generate(TextDirection.values.length, (index) {
                final direction = TextDirection.values[index];
                return ComboBoxItem(
                  value: direction,
                  child: Text(
                    '$direction'
                        .replaceAll('TextDirection.', '')
                        .replaceAll('rtl', 'Right to left')
                        .replaceAll('ltr', 'Left to right'),
                  ),
                );
              }),
              onChanged: (direction) {
                setState(() {
                  appTheme.textDirection = direction as TextDirection;
                  if (kIsWindowEffectsSupported) {
                    // some window effects require on [dark] to look good.
                    // appTheme.setEffect(WindowEffect.disabled, context);
                    appTheme.setEffect(appTheme.windowEffect, context);
                  }
                });
              },
            ),
          ),
        ),
        spacer,
        Card(
          child: ListTile(
            leading: Icon(FluentIcons.locale_language),
            title: Text('Locale'),
            subtitle: Text(
              'The locale used by the fluent_ui widgets, such as TimePicker and '
              'DatePicker. This does not reflect the language of this showcase app.',
            ),
            trailing: ComboBox<Locale>(
              value: appTheme.locale ?? Locale('en'),
              items: List.generate(supportedLocales.length, (index) {
                final locale = supportedLocales[index];
                return ComboBoxItem(
                  value: locale,
                  child: Text('$locale'),
                );
              }),
              onChanged: (locale) {
                setState(() {
                  appTheme.locale = locale as Locale;
                  if (kIsWindowEffectsSupported) {
                    // some window effects require on [dark] to look good.
                    // appTheme.setEffect(WindowEffect.disabled, context);
                    appTheme.setEffect(appTheme.windowEffect, context);
                  }
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildColorBlock(AppTheme appTheme, AccentColor color) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Button(
        onPressed: () {
          appTheme.color = color;
        },
        style: ButtonStyle(
          padding: const WidgetStatePropertyAll(EdgeInsets.zero),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
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
                  size: 22.0,
                )
              : null,
        ),
      ),
    );
  }
}
