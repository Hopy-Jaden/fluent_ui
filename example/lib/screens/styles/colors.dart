import 'package:clipboard/clipboard.dart';
import 'package:example/widgets/page.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:url_launcher/link.dart';
import 'dart:math';
import 'dart:ui';

import 'icongraphy.dart';

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

class ColorsPage extends StatefulWidget {
  const ColorsPage({super.key});

  @override
  State<ColorsPage> createState() => _ColorsPageState();
}

class _ColorsPageState extends State<ColorsPage> {
  int topIndex = 0;
  @override
  Widget build(BuildContext context) {
    var pageDescription = Text(
      'Color is a tool used to express style, evoke emotion, and communicate meaning. A standardized color palette and its intentional application ensure a familiar, comfortable, and consistent experience.',
      style: FluentTheme.of(context).typography.body,
    );
    return ScaffoldPage(
        header: PageHeader(
            title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Colors',
                ),
                Link(
                  // from the url_launcher package
                  uri: Uri.parse('https://fluent2.microsoft.design/color'),
                  builder: (Context, open) {
                    return Button(
                      child: Text('Documentation'),
                      onPressed: open,
                    );
                  },
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            pageDescription,
          ],
        )),
        content: NavigationView(
          pane: NavigationPane(
              selected: topIndex,
              onChanged: (index) => setState(() => topIndex = index),
              displayMode: PaneDisplayMode.top,
              items: [
                PaneItem(
                    icon: Icon(FluentIcons.color),
                    title: Text('Default Color Set'),
                    body: SingleChildScrollView(child: ColorSetsPage())),
                PaneItem(
                    icon: Icon(FluentIcons.contrast),
                    title: Text('Color Contrast'),
                    body: ColorContrastPage())
              ]),
        ));
  }
}

class ColorSetsPage extends StatefulWidget {
  const ColorSetsPage({super.key});

  @override
  State<ColorSetsPage> createState() => _ColorSetsPageState();
}

class _ColorSetsPageState extends State<ColorSetsPage> {
  int topIndex = 0;
  @override
  Widget build(BuildContext context) {
    const Divider divider = Divider(
      style: DividerThemeData(
        verticalMargin: EdgeInsets.all(10),
        horizontalMargin: EdgeInsets.all(10),
      ),
    );
    var defaultColorSetPage = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 14.0),
          SizedBox(
            width: double.infinity,
            child: InfoBar(
              title: Text('Tip:'),
              content: Text(
                  'You can click on any color to copy it to the clipboard!'),
            ),
          ),
          const SizedBox(height: 14.0),
          InfoLabel(
            label: 'Primary Colors',
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: List.generate(Colors.accentColors.length, (index) {
                final name = _primaryNames[index];
                final color = Colors.accentColors[index];
                return ColorBlock(
                  name: name,
                  color: color,
                  clipboard: 'Colors.${name.toLowerCase()}',
                );
              }),
            ),
          ),
          divider,
          InfoLabel(
            label: 'Info Colors',
            child: Wrap(
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
          ),
          divider,
          InfoLabel(
            label: 'All Shades',
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Row(children: [
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
              ]),
              const SizedBox(height: 10),
              Wrap(
                children: List.generate(22, (index) {
                  final factor = (index + 1) * 10;
                  return ColorBlock(
                    name: 'Grey#$factor',
                    color: Colors.grey[factor],
                    clipboard: 'Colors.grey[$factor]',
                  );
                }),
              ),
              const SizedBox(height: 10),
              Wrap(
                runSpacing: 10,
                spacing: 10,
                children: accent,
              ),
            ]),
          ),
        ],
      ),
    );
    return SingleChildScrollView(child: defaultColorSetPage);
  }

  List<Widget> get accent {
    List<Widget> children = [];
    for (var i = 0; i < Colors.accentColors.length; i++) {
      final accent = Colors.accentColors[i];
      final name = _primaryNames[i];
      children.add(
        Column(
          // mainAxisSize: MainAxisSize.min,
          children: List.generate(accent.swatch.length, (index) {
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

class ColorBlock extends StatelessWidget {
  const ColorBlock({
    super.key,
    required this.name,
    required this.color,
    this.variant,
    required this.clipboard,
  });

  final String name;
  final Color color;
  final String? variant;
  final String clipboard;

  @override
  Widget build(BuildContext context) {
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
        builder: (context, states) {
          return FocusBorder(
            focused: states.isFocused,
            useStackApproach: true,
            renderOutside: false,
            child: Container(
              height: 85,
              width: 85,
              padding: const EdgeInsets.all(6.0),
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
                    Text(
                      variant!,
                      style: TextStyle(color: textColor),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ColorContrastPage extends StatefulWidget {
  const ColorContrastPage({super.key});

  @override
  State<ColorContrastPage> createState() => _ColorContrastPageState();
}

class _ColorContrastPageState extends State<ColorContrastPage> {
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(children: [
          Text(
              '''To ensure optimal accessibility and usability, apps should strive to use high-contrast and easy-to-read color combination for text and its background. Not only will this benefit users with lower visual acuity, but this will also ensure visibility and legibility under a wide range of lighting conditions, screens, and device settings.'''),
          SizedBox(height: 24),
          ColorContrastChecker(
            initiallyExpanded: true,
          )
        ]),
      ),
    );
  }
}

class ColorContrastChecker extends StatefulWidget {
  const ColorContrastChecker({super.key, this.initiallyExpanded});
  final bool? initiallyExpanded;

  @override
  State<ColorContrastChecker> createState() => _ColorContrastCheckerState();
}

class _ColorContrastCheckerState extends State<ColorContrastChecker>
    with PageMixin {
  Color textColor = const Color(0xFF000000);
  Color backgroundColor = const Color(0xFFFFFFFF);
  ColorSpectrumShape spectrumShape = ColorSpectrumShape.box;

  @override
  Widget build(BuildContext context) {
    var lum1 = textColor.computeLuminance();
    var lum2 = backgroundColor.computeLuminance();
    var brightest = max(lum1, lum2);
    var darkest = min(lum1, lum2);
    var smallTextContrastRequirement = 4.5;
    var ContrastRequirement = 3;
    double contrast = (brightest + 0.05) / (darkest + 0.05);

    final colorPickerFlyout = SplitButton(
      child: Container(
        decoration: BoxDecoration(
          color: textColor,
          borderRadius: const BorderRadiusDirectional.horizontal(
            start: Radius.circular(4.0),
          ),
        ),
        height: 32.0,
        width: 36.0,
      ),
      flyout: FlyoutContent(
          //constraints: BoxConstraints(maxWidth: 200.0),
          child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ColorPicker(
            color: textColor,
            onChanged: (color) => setState(() => textColor = color),
            colorSpectrumShape: spectrumShape,
            isMoreButtonVisible: false,
            isColorSliderVisible: true,
            isColorChannelTextInputVisible: true,
            isHexInputVisible: true,
            isAlphaEnabled: false,
          ),
        ],
      )),
    );
    final colorPickerFlyout2 = SplitButton(
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadiusDirectional.horizontal(
            start: Radius.circular(4.0),
          ),
        ),
        height: 32.0,
        width: 36.0,
      ),
      flyout: FlyoutContent(
          //constraints: BoxConstraints(maxWidth: 200.0),
          child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ColorPicker(
            color: textColor,
            onChanged: (color) => setState(() => backgroundColor = color),
            colorSpectrumShape: spectrumShape,
            isMoreButtonVisible: false,
            isColorSliderVisible: true,
            isColorChannelTextInputVisible: true,
            isHexInputVisible: true,
            isAlphaEnabled: false,
          ),
        ],
      )),
    );
    final colorContrastRequirement = [
      Row(
        children: [
          contrast > smallTextContrastRequirement
              ? Row(
                  children: [
                    Icon(
                      FluentIcons.skype_circle_check,
                      size: 32,
                      color: Colors.successPrimaryColor,
                    ),
                    SizedBox(width: 10),
                    Text('Pass')
                  ],
                )
              : Row(
                  children: [
                    Icon(
                      FluentIcons.status_error_full,
                      size: 32,
                      color: Colors.errorPrimaryColor,
                    ),
                    SizedBox(width: 10),
                    Text('Fail')
                  ],
                ),
          SizedBox(width: 40),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text('Regular Text'), Text('Require at least 4.5 : 1')],
          )
        ],
      ),
      Row(
        children: [
          contrast > ContrastRequirement
              ? Row(
                  children: [
                    Icon(
                      FluentIcons.skype_circle_check,
                      size: 32,
                      color: Colors.successPrimaryColor,
                    ),
                    SizedBox(width: 10),
                    Text('Pass')
                  ],
                )
              : Row(
                  children: [
                    Icon(
                      FluentIcons.status_error_full,
                      size: 32,
                      color: Colors.errorPrimaryColor,
                    ),
                    SizedBox(width: 10),
                    Text('Fail')
                  ],
                ),
          SizedBox(width: 40),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text('Large Text'), Text('Require at least 3 : 1')],
          )
        ],
      ),
    ];
    final colorContrastShowcase = SizedBox(
      width: double.infinity,
      height: 200,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
                //color: backgroundColor,
                padding: EdgeInsets.all(24.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: colorContrastRequirement)),
          ),
          Expanded(
            flex: 1,
            child: Container(
                color: backgroundColor,
                padding: EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('This is a small text!',
                        style: TextStyle(color: textColor)),
                    subtitle(
                      content: Text(
                        'This is a Large Text',
                        style: TextStyle(color: textColor),
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
    final colorPickersRow = Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Text Color:   ',
              style: FluentTheme.of(context).typography.bodyStrong,
            ),
            SizedBox(
              height: 10,
            ),
            colorPickerFlyout
          ],
        ),
        SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Background Color:   ',
              style: FluentTheme.of(context).typography.bodyStrong,
            ),
            SizedBox(
              height: 10,
            ),
            colorPickerFlyout2
          ],
        ),
        SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Contrast Ratio:',
              style: FluentTheme.of(context).typography.bodyStrong,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              contrast.toStringAsFixed(2) + ' : 1',
              style: FluentTheme.of(context).typography.subtitle,
            ),
          ],
        ),
      ],
    );
    final colorContrastContent = Column(children: [
      colorPickersRow,
      SizedBox(height: 24),
      colorContrastShowcase
    ]);
    final checkerCard = Expander(
      initiallyExpanded: widget.initiallyExpanded ?? false,
      header: Text('Color Contrast Checker'),
      content: colorContrastContent,
    );
    return checkerCard;
  }
}
