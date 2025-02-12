import 'package:clipboard/clipboard.dart';
import 'package:example/widgets/card_highlight.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:url_launcher/link.dart';

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
    return ScaffoldPage(
        header: PageHeader(
          title: Text('Colors'),
          commandBar: Link(
            // from the url_launcher package
            uri: Uri.parse('https://fluent2.microsoft.design/color'),
            builder: (Context, open) {
              return Button(
                child: Text('Documentation'),
                onPressed: open,
              );
            },
          ),
        ),
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
                    icon: Icon(FluentIcons.inking_tool),
                    title: Text('Fluent Theme Builder'),
                    body:
                        SingleChildScrollView(child: FluentThemeBuilderPage())),
                PaneItem(
                    icon: Icon(FluentIcons.contrast),
                    title: Text('Color Contrast'),
                    body: SingleChildScrollView(child: Container()))
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

class FluentThemeBuilderPage extends StatefulWidget {
  const FluentThemeBuilderPage({super.key});

  @override
  State<FluentThemeBuilderPage> createState() => _FluentThemeBuilderPageState();
}

class _FluentThemeBuilderPageState extends State<FluentThemeBuilderPage> {
  static const double itemHeight = 500.0;

  int topIndex = 0;
  PaneDisplayMode displayMode = PaneDisplayMode.open;

  @override
  Widget build(BuildContext context) {
    var pageDescription = Text(
        'Welcome to the Fluent Theme Builder! Effortlessly craft your perfect Fluent UI color theme that resonates with your brand or personal style! Additionally, you can copy the fluent theme data source code for future use, making it easier than ever to manage your themes.');
    var spacer = SizedBox(
      height: 10.0,
    );
    var sampleApp = CardHighlight(
      codeSnippet: '''
// Do not define the `items` inside the `Widget Build` function
// otherwise on running `setstate`, new item can not be added.
)''',
      child: SizedBox(
        height: itemHeight,
        child: NavigationView(
          appBar: const NavigationAppBar(
            title: Text('NavigationView'),
          ),
          onDisplayModeChanged: (mode) {
            debugPrint('Changed to $mode');
          },
          pane: NavigationPane(
            selected: topIndex,
            onItemPressed: (index) {
              // Do anything you want to do, such as:
              // if (index == topIndex) {
              //   if (displayMode == PaneDisplayMode.open) {
              //     setState(() => this.displayMode = PaneDisplayMode.compact);
              //   } else if (displayMode == PaneDisplayMode.compact) {
              //     setState(() => this.displayMode = PaneDisplayMode.open);
              //   }
              // }
            },

            onChanged: (index) {
              setState(() => topIndex = index);
              debugPrint(index.toString());
            },
            //displayMode: displayMode,
            //indicator: indicators[indicator],
            header: const Text('Pane Header'),
            //items: items,
            items: [
              PaneItemExpander(
                icon: const Icon(FluentIcons.account_management),
                title: const Text('Sample Page 1'),
                initiallyExpanded: true,
                body: Container(),
                onTap: () => debugPrint('Tapped account'),
                items: [
                  PaneItem(
                    icon: const Icon(FluentIcons.mail),
                    title: const Text('Sample Page 2'),
                    body: Container(),
                    onTap: () => debugPrint('Tapped mail'),
                  ),
                  PaneItem(
                    icon: const Icon(FluentIcons.calendar),
                    title: const Text('Sample Page 3'),
                    body: Container(),
                    onTap: () => debugPrint('Tapped calendar'),
                  ),
                ],
              ),
            ],
          ),
          /*transitionBuilder: pageTransition == 'Default'
                ? null
                : (child, animation) {
                    switch (pageTransition) {
                      case 'Entrance':
                        return EntrancePageTransition(
                          animation: animation,
                          child: child,
                        );
                      case 'Drill in':
                        return DrillInPageTransition(
                          animation: animation,
                          child: child,
                        );
                      case 'Horizontal':
                        return HorizontalSlidePageTransition(
                          animation: animation,
                          child: child,
                        );
                      default:
                        throw UnsupportedError(
                          '$pageTransition is not a supported transition',
                        );
                    }
                  },
          
          */
        ),
      ),
    );
    var pageWidgetList = <Widget>[
      spacer,
      pageDescription,
      spacer,
      spacer,
      sampleApp
    ];
    var pageContent = Padding(
      padding: EdgeInsets.all(12.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: pageWidgetList),
    );
    return pageContent;
  }
}
