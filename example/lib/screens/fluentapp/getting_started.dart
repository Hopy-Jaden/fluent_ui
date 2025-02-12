import 'package:example/theme.dart';
import 'package:example/widgets/card_highlight.dart';
import 'package:example/widgets/page.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/link.dart';

const _kSplitButtonHeight = 32.0;
const _kSplitButtonWidth = 36.0;

class GettingStartedPage extends StatefulWidget {
  const GettingStartedPage({super.key});

  @override
  State<GettingStartedPage> createState() => _GettingStartedPageState();
}

class _GettingStartedPageState extends State<GettingStartedPage>
    with PageMixin {
  int topIndex = 0;
  @override
  Widget build(BuildContext context) {
    final pageDescription = Text(
      'Start implementing Fluent UI into flutter to achieve more through functional, emotional, focused, seamless experiences across all platforms.',
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
              const Text(
                'Getting Started',
              ),
              Link(
                // from the url_launcher package
                uri: Uri.parse(
                    'https://fluent2.microsoft.design/design-principles'),
                builder: (Context, open) {
                  return Button(
                    child: const Text('Documentation'),
                    onPressed: open,
                  );
                },
              ),
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
          pageDescription,
        ],
      )),
      content: NavigationView(
        pane: NavigationPane(
            selected: topIndex,
            onChanged: (index) {
              setState(() => topIndex = index);
            },
            displayMode: PaneDisplayMode.top,
            items: [
              PaneItem(
                  icon: const Icon(FluentIcons.info),
                  title: const Text('Overview'),
                  body: const GettingStartedOverviewPage()),
              PaneItem(
                  icon: const Icon(FluentIcons.brush),
                  title: const Text('Specs'),
                  body: const GettingStartedSpecsPage()),
              PaneItem(
                  icon: const Icon(FluentIcons.code),
                  title: const Text('Sample Code'),
                  body: const GettingStartedSampleCodePage()),
            ]),
      ),
    );
  }
}

class GettingStartedOverviewPage extends StatefulWidget {
  const GettingStartedOverviewPage({super.key});

  @override
  State<GettingStartedOverviewPage> createState() =>
      _GettingStartedOverviewPageState();
}

class _GettingStartedOverviewPageState extends State<GettingStartedOverviewPage>
    with PageMixin {
  @override
  Widget build(BuildContext context) {
    final appTheme = context.watch<AppTheme>();
    const smallerSpacer = SizedBox(
      height: 10.0,
    );
    const spacer = SizedBox(
      height: 20.0,
    );
    const biggerSpacer = SizedBox(
      height: 40.0,
    );
    const step1codeA = CardHighlight(
      header: Text('Method 1'),
      codeSnippet: '''\$ flutter pub add fluent_ui''',
    );
    const step1codeB = CardHighlight(
      header: Text('Method 2'),
      codeSnippet: '''dependencies: 
      fluent_ui: ^3.9.1''',
    );
    const step1codeC = CardHighlight(
      header: Text('Method 3'),
      codeSnippet: '''dependencies:
        fluent_ui:
          git: https://github.com/bdlukaa/fluent_ui.git''',
    );
    const step2code = CardHighlight(
      codeSnippet: '''import 'package:fluent_ui/fluent_ui.dart';''',
    );
    const step3code = CardHighlight(
      codeSnippet: '''import 'package:fluent_ui/fluent_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FluentApp();
  }
}''',
    );
    var step4code = CardHighlight(
      child: SizedBox(
        height: 500,
        child: FluentApp(
          debugShowCheckedModeBanner: false,
          title: 'Fluent App',
          home: NavigationView(
            appBar: NavigationAppBar(title: Text("Getting Started Fluent UI")),
            content: Container(),
          ),
        ),
      ),
      codeSnippet: '''return FluentApp(
  title: 'Fluent App',
  home: NavigationView(
    appBar: NavigationAppBar(title: Text("Getting Started Fluent UI")),
    content: Container(), //Remember, either 'pane' or 'content' properties must be provided with widget in NavigationView()
  ),
);''',
    );
    var step5code = const CardHighlight(
      child: SizedBox(
        height: 500,
        child: FluentApp(
          debugShowCheckedModeBanner: false,
          title: 'Fluent App',
          home: NavigationView(
            appBar: NavigationAppBar(title: Text("Getting Started Fluent UI")),
            content: ScaffoldPage(
              header: PageHeader(
                title: Text('This is a Page Header'),
              ),
              content: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text('body text here!')),
            ),
          ),
        ),
      ),
      codeSnippet: '''return FluentApp(
  title: 'Fluent App',
  home: NavigationView(
    appBar: NavigationAppBar(title: Text("Getting Started Fluent UI")),
    content: ScaffoldPage(
      header: PageHeader(
        title: Text('This is a Page Header'),
      ),
      content: Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Text('body text here!')
      ),
    ),
  ),
);''',
    );
    var step6code = const CardHighlight(
      codeSnippet: '''return FluentApp(
  theme: FluentThemeData(),
  darkTheme: FluentThemeData(),
  themeMode: ThemeMode.system, //There are ThemeMode.dark, ThemeMode.light, and ThemeMode.system to choose
  ...
);''',
    );
    final pageWidgetsList = <Widget>[
      //Step 1
      Text(
        '1. Installating Fluent UI Package',
        style: FluentTheme.of(context).typography.subtitle,
      ),
      smallerSpacer,
      const Text('Run this command:'),
      smallerSpacer,
      step1codeA,
      spacer,
      const Text(
          'This will add a line like this to your package\'s pubspec.yaml (and run an implicit flutter pub get):'),
      smallerSpacer,
      step1codeB,
      smallerSpacer,
      step1codeC,

      //Step 2
      biggerSpacer,
      Text(
        '2. Importing Library',
        style: FluentTheme.of(context).typography.subtitle,
      ),
      smallerSpacer,
      step2code,

      //Step 3
      biggerSpacer,
      Text(
        '3. Return a FluentApp() Widget',
        style: FluentTheme.of(context).typography.subtitle,
      ),
      smallerSpacer,
      const Text(
          'Similar to MaterialApp providing Material UI design, FluentApp provide Fluent UI design too.'),
      smallerSpacer,
      step3code,

      //Step 4
      biggerSpacer,
      Text(
        '4. Add a Navigation View',
        style: FluentTheme.of(context).typography.subtitle,
      ),
      smallerSpacer,
      const Text(
          '''You can add a navigation view in home properties of FluentApp() for starter. Next, add a NavigationAppBar() in appBar properties of NavigationView().'''),
      smallerSpacer,
      step4code,

      //Step 5
      biggerSpacer,
      Text(
        '5. Add a ScaffoldPage',
        style: FluentTheme.of(context).typography.subtitle,
      ),
      smallerSpacer,
      const Text(
          '''Instead of Container(), you can create a fluent styled page with ScaffoldPage(). Add a PageHeader() for the page title and Text() for some body text.'''),
      smallerSpacer,
      step5code,

      // Step 6
      biggerSpacer,
      Text(
        '6. Customize your Fluent Theme',
        style: FluentTheme.of(context).typography.subtitle,
      ),
      smallerSpacer,
      const Text(
          '''Furthermore, you can customize your fluent theme with FluentThemeData() in 'theme' and 'darkTheme' properties. You can even control which mode the app is going to display.'''),
      const Text(
          '''Go and explore different widgets in this app and customize them in the Specs tab. To easier craft your perfect Fluent UI Theme, you can later copy the FluentThemeData source code based on your customization in Fluent Theme Builder Page.'''),
      smallerSpacer,
      step6code
    ];

    final pageContent = SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: pageWidgetsList,
        ),
      ),
    );
    return pageContent;
  }
}

class GettingStartedSpecsPage extends StatefulWidget with PageMixin {
  const GettingStartedSpecsPage({super.key});

  @override
  State<GettingStartedSpecsPage> createState() =>
      _GettingStartedSpecsPageState();
}

class _GettingStartedSpecsPageState extends State<GettingStartedSpecsPage> {
  @override
  Widget build(BuildContext context) {
    final pageDescription = const Text(
      'You can restyle the buttons below to give it a new look. After customizating components, you can copy the source code of the theme data in fluent theme builder page to easily manage your theme.',
    );
    final pageWidgetsList = <Widget>[pageDescription];
    final pageContent = SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: pageWidgetsList,
        ),
      ),
    );
    return pageContent;
  }
}

class GettingStartedSampleCodePage extends StatefulWidget {
  const GettingStartedSampleCodePage({super.key});

  @override
  State<GettingStartedSampleCodePage> createState() =>
      _GettingStartedSampleCodePageState();
}

class _GettingStartedSampleCodePageState
    extends State<GettingStartedSampleCodePage> with PageMixin {
  bool simpleDisabled = false;
  bool filledDisabled = false;
  bool hyperlinkDisabled = false;
  bool iconDisabled = false;
  bool iconSmall = false;
  bool toggleDisabled = false;
  bool toggleState = false;
  bool splitButtonDisabled = false;
  bool splitButtonState = false;
  bool radioButtonDisabled = false;
  int radioButtonSelected = -1;

  AccentColor splitButtonColor = Colors.red;
  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);

    final splitButtonFlyout = FlyoutContent(
      constraints: BoxConstraints(maxWidth: 200.0),
      child: Wrap(
        runSpacing: 10.0,
        spacing: 8.0,
        children: Colors.accentColors.map((color) {
          return IconButton(
            autofocus: splitButtonColor == color,
            style: ButtonStyle(
              padding: WidgetStatePropertyAll(
                EdgeInsets.all(4.0),
              ),
            ),
            onPressed: () {
              setState(() => splitButtonColor = color);
              Navigator.of(context).pop(color);
            },
            icon: Container(
              height: _kSplitButtonHeight,
              width: _kSplitButtonHeight,
              color: color,
            ),
          );
        }).toList(),
      ),
    );
    var button = [
      Text(
        'Template of a simple Fluent App',
        style: FluentTheme.of(context).typography.subtitle,
      ),
      SizedBox(height: 10),
      CardHighlight(
        child: SizedBox(
          height: 500,
          child: FluentApp(
            debugShowCheckedModeBanner: false,
            title: 'Fluent App',
            home: NavigationView(
              appBar:
                  NavigationAppBar(title: Text("Getting Started Fluent UI")),
              content: ScaffoldPage(
                header: PageHeader(
                  title: Text('This is a Page Header'),
                ),
                content: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text('body text here!')),
              ),
            ),
          ),
        ),
        codeSnippet: '''import 'package:fluent_ui/fluent_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      title: 'Fluent App',
      home: NavigationView(
        appBar: NavigationAppBar(title: Text("Getting Started Fluent UI")),
        content: ScaffoldPage(
          header: PageHeader(
            title: Text('This is a Page Header'),
          ),
          content: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Text('body text here!')
          ),
        ),
      ),
    );
  }
}''',
      )
    ];
    //var pageWidgetsList = <Widget>[button];
    var pageContent = SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: button,
        ),
      ),
    );
    return pageContent;
  }
}
