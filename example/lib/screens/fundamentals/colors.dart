import 'dart:math' as math;

import 'package:clipboard/clipboard.dart';
import 'package:example/widgets/card_highlight.dart';
import 'package:fluent_ui/fluent_ui.dart';

import 'iconography.dart';

const _primaryNames = [
  'Yellow',
  'Orange',
  'Red',
  'Magenta',
  'Purple',
  'Blue',
  'Teal',
  'Green',
];

class ColorShowcasePage extends StatelessWidget {
  const ColorShowcasePage({super.key});

  @override
  Widget build(final BuildContext context) {
    return ScaffoldPage.scrollable(
      children: [
        Text('Palettes', style: FluentTheme.of(context).typography.title),
        SizedBox(height: 10),
        const Text(
          'Fluent defines three color palettes: neutral, shared, and brand. '
          'Each palette performs specific functions. Read each section to learn about the specific roles of each one and how to apply them across products.',
        ),
        const SizedBox(height: 20),
        const SizedBox(
          width: double.infinity,
          child: InfoBar(
            title: Text('Tip:'),
            content: Text(
              'You can click on any icon to copy it to the clipboard!',
            ),
          ),
        ),
        SizedBox(height: 30),
        Text(
          'Neutral Colors',
          style: FluentTheme.of(context).typography.subtitle,
        ),
        SizedBox(height: 10),
        const Text(
          'The neutral palette consists of the black, white, and grays that ground an interface. '
          'These colors are used on surfaces, text, and layout elements. When used in components, they often connote a change in state. '
          'Use lighter neutrals on surfaces to highlight areas of primary focus and create a sense of hierarchy. '
          'This ensures a person’s eye is drawn to the areas of an interface that need the most attention or that will be most useful to them. ',
        ),
        SizedBox(height: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                ColorBlock(
                  name: 'Black',
                  color: Colors.black,
                  clipboard: 'Colors.black',
                ),
                ColorBlock(
                  name: 'White',
                  color: Colors.white,
                  clipboard: 'Colors.white',
                ),
              ],
            ),
            const SizedBox(height: 10),
            Wrap(
              children: List.generate(22, (final index) {
                final factor = (index + 1) * 10;
                return ColorBlock(
                  name: 'Grey#$factor',
                  color: Colors.grey[factor],
                  clipboard: 'Colors.grey[$factor]',
                );
              }),
            ),
          ],
        ),
        SizedBox(height: 30),
        Text(
          'Shared Colors',
          style: FluentTheme.of(context).typography.subtitle,
        ),
        SizedBox(height: 10),
        const Text(
          'Shared colors are aligned across the M365 suite of apps and are used in Fluent high-value, reusable components like avatars, calendars, and badges. '
          'Shared colors allow for quick mental recognition of components and functions across products. '
          'Use shared colors sparingly to accent and highlight important areas of an interface. ',
        ),
        SizedBox(height: 15),
        Wrap(runSpacing: 10, spacing: 10, children: accent),
        const SizedBox(height: 20),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            const ColorBlock(
              name: 'Warning 1',
              color: Colors.warningPrimaryColor,
              clipboard: 'Colors.warningPrimaryColor',
            ),
            ColorBlock(
              name: 'Warning 2',
              color: Colors.warningSecondaryColor,
              clipboard: 'Colors.warningSecondaryColor',
            ),
            const ColorBlock(
              name: 'Error 1',
              color: Colors.errorPrimaryColor,
              clipboard: 'Colors.errorPrimaryColor',
            ),
            ColorBlock(
              name: 'Error 2',
              color: Colors.errorSecondaryColor,
              clipboard: 'Colors.errorSecondaryColor',
            ),
            const ColorBlock(
              name: 'Success 1',
              color: Colors.successPrimaryColor,
              clipboard: 'Colors.successPrimaryColor',
            ),
            ColorBlock(
              name: 'Success 2',
              color: Colors.successSecondaryColor,
              clipboard: 'Colors.successSecondaryColor',
            ),
          ],
        ),

        SizedBox(height: 30),
        Text(
          'Brand Colors',
          style: FluentTheme.of(context).typography.subtitle,
        ),
        SizedBox(height: 10),
        const Text(
          'Color is key to the immediate brand recognition of our suite of products. '
          'Apply brand colors to different areas of an interface not only to create visual prominence, but also to anchor people in a specific product experience. '
          'Avoid overusing brand colors or using them on large surfaces as they can dilute a hierarchy and make an experience difficult to navigate.',
        ),
        SizedBox(height: 15),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: List.generate(Colors.accentColors.length, (final index) {
            final name = _primaryNames[index];
            final color = Colors.accentColors[index];
            return ColorBlock(
              name: name,
              color: color,
              clipboard: 'Colors.${name.toLowerCase()}',
            );
          }),
        ),
      ],
    );
  }

  List<Widget> get accent {
    final children = <Widget>[];
    for (var i = 0; i < Colors.accentColors.length; i++) {
      final accent = Colors.accentColors[i];
      final name = _primaryNames[i];
      children.add(
        Column(
          // mainAxisSize: MainAxisSize.min,
          children: List.generate(accent.swatch.length, (final index) {
            final variant = accent.swatch.keys.toList()[index];
            final color = accent.swatch[variant]!;
            return ColorBlock(
              name: name,
              color: color,
              variant: variant,
              clipboard: 'Colors.${name.toLowerCase()}.$variant',
            );
          }),
        ),
      );
    }
    return children;
  }
}

class ResourceDictionaryPage extends StatelessWidget {
  const ResourceDictionaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      children: [
        Text(
          'Resource Dictionary.light',
          style: FluentTheme.of(context).typography.subtitle,
        ),
        SizedBox(height: 10),
        const Text(
          'Resource dictionary is a dictionary of colors used by all the components. Use '
          '`ResourceDictionary.light` to get colors adapted to light mode.',
        ),
        SizedBox(height: 20),
        CardHighlight(
          child: SizedBox(height: 400, child: ResourceDictionaryEditor()),
          initiallyOpen: false,
          codeSnippet: '''
dependencies:
  fluent_ui: ^4.13.0''',
        ),
        SizedBox(height: 20),
        Text(
          'Resource Dictionary.dark',
          style: FluentTheme.of(context).typography.subtitle,
        ),
        SizedBox(height: 10),
        const Text(
          'In addition, Use `ResourceDictionary.dark` to get colors adapted to dark mode.',
        ),
        SizedBox(height: 20),
        CardHighlight(
          child: SizedBox(height: 400, child: ResourceDictionaryEditor()),
          initiallyOpen: false,
          codeSnippet: '''
dependencies:
  fluent_ui: ^4.13.0''',
        ),
        SizedBox(height: 20),
      ],
    );
  }
}

class ResourceDictionaryEditor extends StatelessWidget {
  const ResourceDictionaryEditor({super.key});

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      title: 'Resource Dictionary Example',
      theme: FluentThemeData(
        brightness: Brightness.light,
        accentColor: Colors.blue,
      ),
      home: NavigationView(
        pane: NavigationPane(
          displayMode: PaneDisplayMode.compact,
          selected: 0,
          items: [
            PaneItem(
              icon: Icon(WindowsIcons.font),
              title: Text('Text'),
              body: Placeholder(),
            ),
            PaneItem(
              icon: Icon(FluentIcons.format_painter),
              title: Text('Fill'),
              body: Placeholder(),
            ),
            PaneItem(
              icon: Icon(WindowsIcons.stroke_erase2),
              title: Text('Stroke'),
              body: Placeholder(),
            ),
            PaneItem(
              icon: Icon(WindowsIcons.background_toggle),
              title: Text('Background'),
              body: Placeholder(),
            ),
            PaneItem(
              icon: Icon(FluentIcons.info),
              title: Text('Signal'),
              body: Placeholder(),
            ),
          ],
        ),
      ),
    );
  }
}

class ContrastCheckerPage extends StatefulWidget {
  const ContrastCheckerPage({super.key});

  @override
  State<ContrastCheckerPage> createState() => _ContrastCheckerPageState();
}

class _ContrastCheckerPageState extends State<ContrastCheckerPage> {
  Color color1 = Colors.black;
  Color color2 = Colors.white;
  double ratio = 21.00;
  final splitButtonKey = GlobalKey<SplitButtonState>();
  final splitButtonKey2 = GlobalKey<SplitButtonState>();

  double calculateContrastRatio(Color color1, Color color2) {
    final luminance1 = color1.computeLuminance();
    final luminance2 = color2.computeLuminance();
    final lighter = math.max(luminance1, luminance2);
    final darker = math.min(luminance1, luminance2);
    return (lighter + 0.05) / (darker + 0.05);
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      children: [
        Text(
          'Contrast Checker',
          style: FluentTheme.of(context).typography.subtitle,
        ),
        SizedBox(height: 10),
        const Text(
          'To ensure optimal accessibility and usability, apps should strive to use high-contrast and easy-to-read color combinations for text and its background. '
          'Not only will this benefit users with lower visual acuity, but this will also ensure visibility and legibility under a wide range of lighting conditions, screens, and device settings. '
          'Use this contrast checker to calculate the contrast ratio of two colors and measure them against the Web Content Accessibility Guidelines. ',
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Flex(
              direction: Axis.vertical,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    'Color 1',
                    style: FluentTheme.of(context).typography.bodyStrong,
                  ),
                ),
                SplitButton(
                  key: splitButtonKey,
                  flyout: FlyoutContent(
                    //constraints: BoxConstraints(maxWidth: 200.0),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: ColorPicker(
                          color: color1,
                          onChanged: (final color) {
                            setState(() {
                              color1 = color;
                              ratio = calculateContrastRatio(color1, color2);
                            });
                          },
                          isMoreButtonVisible: false,
                        ),
                      ),
                    ),
                  ),
                  child: SizedBox(
                    width: 36.0,
                    height: 32.0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: color1,
                        borderRadius: const BorderRadiusDirectional.horizontal(
                          start: Radius.circular(4.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: 20),
            Flex(
              direction: Axis.vertical,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    'Color 2',
                    style: FluentTheme.of(context).typography.bodyStrong,
                  ),
                ),
                SplitButton(
                  key: splitButtonKey2,
                  flyout: FlyoutContent(
                    //constraints: BoxConstraints(maxWidth: 200.0),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: ColorPicker(
                          color: color2,
                          onChanged: (final color) {
                            setState(() {
                              color2 = color;
                              ratio = calculateContrastRatio(color1, color2);
                            });
                          },
                          isMoreButtonVisible: false,
                        ),
                      ),
                    ),
                  ),
                  child: SizedBox(
                    width: 36.0,
                    height: 32.0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: color2,
                        borderRadius: const BorderRadiusDirectional.horizontal(
                          start: Radius.circular(4.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Contrast Ratio',
                  style: FluentTheme.of(context).typography.bodyStrong,
                ),
                SizedBox(height: 4),
                Text(
                  ratio.toStringAsFixed(2) + " : 1",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 20),
        Card(
          child: ListBody(
            children: [
              ListTile(
                title: Text('Regular Text', style: FluentTheme.of(context).typography.bodyStrong),
                subtitle: Text('required at least 4.5 : 1', style: FluentTheme.of(context).typography.body),
                leading: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 4),
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: ratio >= 4.5
                            ? Colors.successPrimaryColor
                            : Colors.errorPrimaryColor,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        ratio >= 4.5 ? FluentIcons.check_mark : FluentIcons.cancel,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                    ratio >= 4.5
                  ? Text('Passed', style: FluentTheme.of(context).typography.bodyStrong)
                  : Text('Failed', style: FluentTheme.of(context).typography.bodyStrong),
                  ],
                ),
              ),
              ListTile(
                title: Text('Large Text (14pt. bold or 18pt. regular)', style: FluentTheme.of(context).typography.bodyStrong),
                subtitle: Text('required at least 3 : 1', style: FluentTheme.of(context).typography.body),
                leading: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 4),
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: ratio >= 3
                            ? Colors.successPrimaryColor
                            : Colors.errorPrimaryColor,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        ratio >= 3 ? FluentIcons.check_mark : FluentIcons.cancel,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                    ratio >= 3
                  ? Text('Passed', style: FluentTheme.of(context).typography.bodyStrong)
                  : Text('Failed', style: FluentTheme.of(context).typography.bodyStrong),
                  ],
                ),
              ),
              ListTile(
                title: Text('Graphical objects and UI components', style: FluentTheme.of(context).typography.bodyStrong),
                subtitle: Text('required at least 3 : 1', style: FluentTheme.of(context).typography.body),
                leading: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 4),
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: ratio >= 3
                            ? Colors.successPrimaryColor
                            : Colors.errorPrimaryColor,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        ratio >= 3 ? FluentIcons.check_mark : FluentIcons.cancel,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                    ratio >= 3
                  ? Text('Passed', style: FluentTheme.of(context).typography.bodyStrong)
                  : Text('Failed', style: FluentTheme.of(context).typography.bodyStrong),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ColorsPage extends StatefulWidget {
  const ColorsPage({super.key, this.selectedIndex = 0});
  final int selectedIndex;

  @override
  State<ColorsPage> createState() => _ColorsPageState();
}

class _ColorsPageState extends State<ColorsPage> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedIndex;
  }

  @override
  Widget build(final BuildContext context) {
    return ScaffoldPage(
      header: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageHeader(title: Text('Colors')),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              'Color is a tool used to express style, evoke emotion, and communicate meaning. A standardized color palette and its intentional application ensure a familiar, comfortable, and consistent experience.',
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
      content: NavigationView(
        pane: NavigationPane(
          displayMode: PaneDisplayMode.top,
          selected: selectedIndex,
          onItemPressed: (value) => setState(() {
            selectedIndex = value;
          }),
          items: [
            PaneItem(
              icon: Icon(FluentIcons.color),
              title: Text('Palettes'),
              body: ColorShowcasePage(),
            ),
            PaneItem(
              icon: Icon(WindowsIcons.dictionary),
              title: Text('Resource Dictionary'),
              body: ResourceDictionaryPage(),
            ),
            PaneItem(
              icon: Icon(WindowsIcons.ease_of_access),
              title: Text('Contrast Checker'),
              body: ContrastCheckerPage(),
            ),
          ],
        ),
      ),
    );
  }
}

class ColorBlock extends StatelessWidget {
  const ColorBlock({
    required this.name,
    required this.color,
    required this.clipboard,
    super.key,
    this.variant,
  });

  final String name;
  final Color color;
  final String? variant;
  final String clipboard;

  @override
  Widget build(final BuildContext context) {
    final textColor = color.basedOnLuminance();
    return Tooltip(
      message: '\n$clipboard\n(tap to copy to clipboard)\n',
      child: HoverButton(
        onPressed: () async {
          await FlutterClipboard.copy(clipboard);
          // ignore: use_build_context_synchronously
          showCopiedSnackbar(context, clipboard);
        },
        cursor: SystemMouseCursors.copy,
        builder: (final context, final states) {
          return FocusBorder(
            focused: states.isFocused,
            renderOutside: false,
            child: Container(
              height: 85,
              width: 85,
              padding: const EdgeInsetsDirectional.all(6),
              color: color,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const Spacer(),
                  if (variant != null)
                    Text(variant!, style: TextStyle(color: textColor)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
