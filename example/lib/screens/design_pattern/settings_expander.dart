import 'package:example/widgets/card_highlight.dart';
import 'package:fluent_ui/fluent_ui.dart';

import '../../../widgets/page.dart';

class SettingsExpanderPage extends StatefulWidget {
  const SettingsExpanderPage({super.key});

  @override
  State<SettingsExpanderPage> createState() => _SettingsExpanderPageState();
}

class _SettingsExpanderPageState extends State<SettingsExpanderPage>
    with PageMixin {
  static const double itemHeight = 500;
    bool selected = true;
    bool crostOpen = false;
    List<String> crosts = ['Classic', 'Whole wheat', 'Gluten free'];
  String crost = 'Whole wheat';
  List<String> sizes = ['Regular', 'Thin', 'Pan', 'Stuffed'];
  String size = 'Pan';

      String? comboboxValue;

  int topIndex = 0;

  PaneDisplayMode displayMode = PaneDisplayMode.expanded;
  String pageTransition = 'Default';

  String indicator = 'Sticky';
  bool hasTopBar = true;
  bool checked = false;
  
  List<NavigationPaneItem> items = [];

  @override
  Widget build(final BuildContext context) {
    return ScaffoldPage.scrollable(
      header: const PageHeader(title: Text('Create your first app')),
      children: [
        
        const Text(
          'Follow these steps to create your first Fluent UI app using the FluentApp() and ScaffoldPage() widgets:',
        ),
        const SizedBox(height: 30),
        Text('Installation', style: FluentTheme.of(context).typography.subtitle,),
        const SizedBox(height: 10,),
        Text( 
          'Before you begin, ensure you have Flutter installed on your machine. Then, add the '
          'fluent_ui package to your project by including it in your pubspec.yaml file:',
        ),
        const SizedBox(height: 20),
        CardHighlight(
          initiallyOpen: false,
          codeSnippet: '''
dependencies:
  fluent_ui: ^4.13.0''',
        ),
        const SizedBox(height: 30),
        Text('Step 1: Create a FluentApp() widget', style: FluentTheme.of(context).typography.subtitle,),
        const SizedBox(height: 10,),
        Text(
          'The FluentApp widget is the root of your application. It provides '
          'theming and navigation capabilities for Fluent UI apps.',
        ),
        const SizedBox(height: 20),
        CardHighlight(
          initiallyOpen: true,
          codeSnippet: '''
import 'package:fluent_ui/fluent_ui.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      title: 'Windows UI for Flutter',
      theme: FluentThemeData(
        brightness: Brightness.light,
        accentColor: Colors.blue,
      ),
      home: const HomePage(), //which is usually a ScaffoldPage() or NavigationView()
    );
  }
}
''', 
child: Expander(
  leading: RadioButton(
    checked: checked,
    onChanged: (v) => setState(() => checked = v),
  ),
  header: Text('This text is in header'),
  content: Text('This text is in content'),
),
        ),
        const SizedBox(height: 30,),
        Text('Step 2: Set ScaffoldPage() widget as the home of FluentApp()', style: FluentTheme.of(context).typography.subtitle,),
        const SizedBox(height: 10,),
        const Text(
          'The ScaffoldPage widget provides a basic structure for your app\'s '
          'UI, including a header and content area.',
        ),
        const SizedBox(height: 20),
        CardHighlight(
          initiallyOpen: false,
          codeSnippet: '''
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScaffoldPage(
      header: PageHeader(title: Text('My First Fluent App'),),
      content: Center(child: Text('Welcome to your first Fluent UI app!')), //or any widget you like
    );
  }
}
''',
          child: SizedBox(height: itemHeight, child: FluentApp(
      title: 'Windows UI for Flutter',
      theme: FluentThemeData(
        brightness: Brightness.light,
        accentColor: Colors.blue,
      ),
      home:  const ScaffoldPage(
        header: PageHeader(title: Text('My First Fluent App'),),
        content: Center(child: Text('Welcome to my first Fluent UI app!')), //or any widget you like
      ),
    ))
        ),
        const SizedBox(height: 30,),
        Text('Step 3: Continue your app development!', style: FluentTheme.of(context).typography.subtitle,),
        const SizedBox(height: 10,),
        Text(
          'Now that you have set up the basic structure of your Fluent UI app, '
          'you can start adding more features and functionality to it. Explore other '
          'pages to learn more about the available widgets and how to use them in your app.',
        ),
        const SizedBox(height: 20),
        Expander(header: Text('header'),content: Text('content'),),
        Expander(
            header: const Text('Choose your crost'),
            onStateChanged: (final open) => setState(() => crostOpen = open),
            trailing: crostOpen
                ? null
                : Text(
                    '$crost, $size',
                    style: FluentTheme.of(context).typography.caption,
                  ),
            content: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: crosts
                      .map(
                        (final e) => Padding(
                          padding: const EdgeInsetsDirectional.only(bottom: 8),
                          child: RadioButton(
                            checked: crost == e,
                            onChanged: (final selected) {
                              if (selected) setState(() => crost = e);
                            },
                            content: Text(e),
                          ),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: sizes
                      .map(
                        (final e) => Padding(
                          padding: const EdgeInsetsDirectional.only(bottom: 8),
                          child: RadioButton(
                            checked: size == e,
                            onChanged: (final selected) {
                              if (selected) setState(() => size = e);
                            },
                            content: Text(e),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
