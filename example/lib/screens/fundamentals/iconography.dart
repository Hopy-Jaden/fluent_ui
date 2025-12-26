import 'dart:math';

import 'package:clipboard/clipboard.dart';
import 'package:collection/collection.dart';
import 'package:example/screens/settings.dart';
import 'package:example/screens/fundamentals/typography.dart';
import 'package:example/widgets/card_highlight.dart';
import 'package:fluent_ui/fluent_ui.dart';

Future<void> showCopiedSnackbar(
  final BuildContext context,
  final String copiedText,
) {
  return displayInfoBar(
    context,
    builder: (final context, final close) => InfoBar(
      title: RichText(
        text: TextSpan(
          text: 'Copied ',
          style: const TextStyle(color: Colors.white),
          children: [
            TextSpan(
              text: copiedText,
              style: TextStyle(
                color: FluentTheme.of(context).accentColor.defaultBrushFor(
                  FluentTheme.of(context).brightness,
                ),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class IconographyPage extends StatefulWidget {
  const IconographyPage({super.key});

  @override
  State<IconographyPage> createState() => _IconographyPageState();
}

class _IconographyPageState extends State<IconographyPage> {
  String filterText = '';
  Color? color;
  double? size;
  int setSelection = 0;

  @override
  Widget build(final BuildContext context) {
    assert(debugCheckHasFluentTheme(context));
    final theme = FluentTheme.of(context);

    return ScaffoldPage(
      header: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageHeader(
            title: RichText(
              text: TextSpan(
                style: theme.typography.title,
                children: [
                  const TextSpan(text: 'Icongraphy'),
                  /*TextSpan(
                    text: '(${widget.set.length})',
                    style: theme.typography.caption,
                  ),*/
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              'Icons represent concepts, objects, or actions, and have semantic purpose within a layout. They should always be recognizable, functional, and easily understood. Segoe Fluent Icons are used on Windows 11 and Segoe MDL2 Assets are used on Windows 10.',
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: SizedBox(
                  width: 240,
                  child: Tooltip(
                    message: 'Filter by name',
                    child: TextBox(
                      suffix: Padding(
                        padding: const EdgeInsetsDirectional.only(end: 4),
                        child: IconButton(
                          icon: WindowsIcon(WindowsIcons.search),
                          onPressed: () {},
                        ),
                      ),
                      placeholder: 'Type to filter icons by name (e.g "logo")',
                      onChanged: (final value) => setState(() {
                        filterText = value;
                      }),
                    ),
                  ),
                ),
              ),
              Token(
                isTogglable: true,
                selected: setSelection == 0,
                child: Text('Fluent (${WindowsIcons.allIcons.length})'),
                onSelected: (final v) => setState(() {
                  if (setSelection != 0) {
                    setSelection = 0;
                  }
                }),
              ),
              SizedBox(width: 10),
              Token(
                isTogglable: true,
                selected: setSelection == 1,
                child: Text('MDL2 (${FluentIcons.allIcons.length})'),
                onSelected: (final v) => setState(() {
                  if (setSelection != 1) {
                    setSelection = 1;
                  }
                }),
              ),
              /*ToggleButton(
                style: ToggleButtonThemeData(
                  checkedButtonStyle: ButtonStyle(
                        borderRadius: WidgetStatePropertyAll(BorderRadius.circular(50)),
                    backgroundColor: WidgetStateProperty.resolveWith(
                      (states) =>
                          ButtonThemeData.checkedInputColor(theme, states),
                    ),
                    foregroundColor: WidgetStateProperty.resolveWith(
                      (states) => FilledButton.foregroundColor(theme, states),
                    ),
                  ),
                  uncheckedButtonStyle: ButtonStyle(
                    borderRadius: WidgetStatePropertyAll(BorderRadius.circular(50)),
                  ),
                ),
                checked: setSelection == 0,
                onChanged: (final v) => setState(() {
                  if (setSelection != 0) {
                    setSelection = 0;
                  }
                }),
                child: Text('Fluent (${WindowsIcons.allIcons.length})'),
              ),
              SizedBox(width: 10),
              ToggleButton(
                style: ToggleButtonThemeData(
                  checkedButtonStyle: ButtonStyle(
                    borderRadius: WidgetStatePropertyAll(BorderRadius.circular(50)),
                    backgroundColor: WidgetStateProperty.resolveWith(
                      (states) =>
                          ButtonThemeData.checkedInputColor(theme, states),
                    ),
                    foregroundColor: WidgetStateProperty.resolveWith(
                      (states) => FilledButton.foregroundColor(theme, states),
                    ),
                  ),
                  uncheckedButtonStyle: ButtonStyle(
                    borderRadius: WidgetStatePropertyAll(BorderRadius.circular(50)),
                  ),
                ),
                checked: setSelection == 1,
                onChanged: (final v) => setState(() {
                  if (setSelection != 1) {
                    setSelection = 1;
                  }
                }),
                child: Text('MDL2 (${FluentIcons.allIcons.length})'),
              ),*/
            ],
          ),
          const SizedBox(height: 10),
          const SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: InfoBar(
                title: Text('Tip:'),
                content: Text(
                  'You can click on any icon to copy its name to the clipboard!',
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
      content: Container(
        child: setSelection == 0
            ? IconsGrids(set: WindowsIcons.allIcons, filterText: filterText)
            : IconsGrids(set: FluentIcons.allIcons, filterText: filterText),
      ),
    );
  }
}

class IconsGrids extends StatefulWidget {
  final Map<String, IconData> set;
  final String filterText;

  const IconsGrids({
    Key? key,
    required this.set,
    required this.filterText,
  }) : super(key: key);

  @override
  State<IconsGrids> createState() => _IconsGridsState();
}

class _IconsGridsState extends State<IconsGrids> {
  Color? color;
  double? size;

  late final IconData icon = widget.set.values.elementAt(
    Random().nextInt(widget.set.length),
  );

  @override
  Widget build(final BuildContext context) {
    assert(debugCheckHasFluentTheme(context));

    final theme = FluentTheme.of(context);

    color ??= IconTheme.of(context).color;
    size ??= IconTheme.of(context).size;

    final entries = widget.set.entries.where(
      (final icon) =>
          widget.filterText.isEmpty ||
          // Remove '_'
          icon.key
              .replaceAll('_', '')
              // toLowerCase
              .toLowerCase()
              .contains(
                widget.filterText.toLowerCase()
                // Remove spaces
                .replaceAll(' ', ''),
              ),
    );

    final prefix = switch (icon.fontFamily) {
      'SegoeIcons' => 'WindowsIcons',
      'FluentIcons' => 'FluentIcons',
      _ => 'Icons',
    };
    final iconName = widget.set.entries
        .firstWhereOrNull((final e) => e.value == icon)
        ?.key;

    return Padding(
      padding: EdgeInsetsDirectional.only(
        start: PageHeader.horizontalPadding(context),
        end: PageHeader.horizontalPadding(context),
      ),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: CardHighlight(
                initiallyOpen: true,
                codeSnippet:
                    '''const WindowsIcon(
  $prefix.$iconName,
  size: ${size!.toInt()},
  color: Color(0x${color!.toARGB32().toRadixString(16).padLeft(8, '0')}),
),''',
                child: Row(
                  spacing: 8,
                  children: [
                    WindowsIcon(icon, size: size, color: color),
                    const Spacer(),
                    IntrinsicWidth(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          InfoLabel(
                            label: 'Icon Color',
                            child: ComboBox<Color>(
                              placeholder: const Text('Icon Color'),
                              onChanged: (final c) => setState(() => color = c),
                              value: color,
                              isExpanded: true,
                              items: [
                                ComboBoxItem(
                                  value: Colors.white,
                                  child: Row(
                                    children: [
                                      buildColorBox(Colors.white),
                                      const SizedBox(width: 10),
                                      const Text('White'),
                                    ],
                                  ),
                                ),
                                ComboBoxItem(
                                  value: const Color(0xE4000000),
                                  child: Row(
                                    children: [
                                      buildColorBox(const Color(0xE4000000)),
                                      const SizedBox(width: 10),
                                      const Text('Black'),
                                    ],
                                  ),
                                ),
                                ...List.generate(Colors.accentColors.length, (
                                  final index,
                                ) {
                                  final color = Colors.accentColors[index];
                                  return ComboBoxItem(
                                    value: color,
                                    child: Row(
                                      children: [
                                        buildColorBox(color),
                                        const SizedBox(width: 10),
                                        Text(accentColorNames[index + 1]),
                                      ],
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          InfoLabel(
                            label: 'Icon Size',
                            child: Slider(
                              value: size!,
                              onChanged: (final v) => setState(() {
                                size = v;
                              }),
                              min: 8,
                              max: 56,
                              label: '${size!.toInt()}',
                              style: const SliderThemeData(
                                margin: EdgeInsetsDirectional.zero,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverGrid.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 150,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemCount: entries.length,
            itemBuilder: (final context, final index) {
              final e = entries.elementAt(index);
              return HoverButton(
                onPressed: () async {
                  final copyText = '$prefix.${e.key}';
                  await FlutterClipboard.copy(copyText);
                  if (context.mounted) showCopiedSnackbar(context, copyText);
                },
                cursor: SystemMouseCursors.copy,
                builder: (final context, final states) {
                  return FocusBorder(
                    focused: states.isFocused,
                    renderOutside: false,
                    child: Tooltip(
                      useMousePosition: false,
                      message:
                          '\nWindowsIcons.${e.key}\n(tap to copy to clipboard)\n',
                      child: RepaintBoundary(
                        child: AnimatedContainer(
                          duration: theme.fasterAnimationDuration,
                          decoration: BoxDecoration(
                            color: ButtonThemeData.uncheckedInputColor(
                              theme,
                              states,
                              transparentWhenNone: true,
                            ),
                          ),
                          child: Card(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(e.value, size: 40),
                                Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                    top: 8,
                                  ),
                                  child: Text(
                                    snakeCasetoSentenceCase(e.key),
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.fade,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  static String snakeCasetoSentenceCase(final String original) {
    return '${original[0].toUpperCase()}${original.substring(1)}'.replaceAll(
      RegExp('(_|-)+'),
      ' ',
    );
  }
}
