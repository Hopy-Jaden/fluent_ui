import 'package:clipboard/clipboard.dart';
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
        Text(
          'Palettes',
          style: FluentTheme.of(context).typography.title,
        ),
        SizedBox(height: 10),
        const Text(
          'Fluent defines three color palettes: neutral, shared, and brand. '
          'Each palette performs specific functions. Read each section to learn about the specific roles of each one and how to apply them across products.'
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

class ColorsPage extends StatelessWidget {
  const ColorsPage({super.key});

  @override
  Widget build(final BuildContext context) {
    const divider = Divider(
      style: DividerThemeData(
        verticalMargin: EdgeInsetsDirectional.all(10),
        horizontalMargin: EdgeInsetsDirectional.all(10),
      ),
    );
    return ScaffoldPage(
      header: const Column(
        children: [
          PageHeader(title: Text('Colors')),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              'Color is a tool used to express style, evoke emotion, and communicate meaning. A standardized color palette and its intentional application ensure a familiar, comfortable, and consistent experience.',
            ),
          ),
        ],
      ),
      content: NavigationView(
        pane: NavigationPane(
          displayMode: PaneDisplayMode.top,
          selected: 0,
          items: [
            PaneItem(
              icon: Icon(FluentIcons.color),
              title: Text('Palettes'),
              body: ColorShowcasePage(),
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
