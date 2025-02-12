import 'package:example/widgets/card_highlight.dart';
import 'package:example/widgets/page.dart';
import 'package:fluent_ui/fluent_ui.dart';

class FluentThemeBuilderPage extends StatefulWidget {
  const FluentThemeBuilderPage({super.key});

  @override
  State<FluentThemeBuilderPage> createState() => _FluentThemeBuilderPageState();
}

class _FluentThemeBuilderPageState extends State<FluentThemeBuilderPage>
    with PageMixin {
  static const double itemHeight = 500.0;

  int topIndex = 0;
  PaneDisplayMode displayMode = PaneDisplayMode.open;

  @override
  Widget build(BuildContext context) {
    var pageDescription = const Text(
        'Welcome to the Fluent Theme Builder! Effortlessly craft your perfect Fluent UI color theme that resonates with your brand or personal style! Additionally, you can copy the fluent theme data source code for future use, making it easier than ever to manage your themes.');
    var spacer = const SizedBox(
      height: 10.0,
    );
    var biggerSpacer = const SizedBox(
      height: 10.0,
    );
    var lightTheme = const CardHighlight(
      codeSnippet: '''
// Do not define the `items` inside the `Widget Build` function
// otherwise on running `setstate`, new item can not be added.
)''',
    );
    var darkTheme = const CardHighlight(
      codeSnippet: '''
// Do not define the `items` inside the `Widget Build` function
// otherwise on running `setstate`, new item can not be added.
)''',
    );
    var pageWidgetList = <Widget>[
      spacer,
      pageDescription,
      biggerSpacer,
      subtitle(content: Text('Light Mode FluentThemeData()')),
      spacer,
      lightTheme,
      biggerSpacer,
      subtitle(content: Text('Dark Mode FluentThemeData()')),
      spacer,
      darkTheme,
    ];
    var pageContent = ScaffoldPage.scrollable(
        header: const PageHeader(title: Text('Fluent Theme Builder')),
        children: pageWidgetList);
    return pageContent;
  }
}
