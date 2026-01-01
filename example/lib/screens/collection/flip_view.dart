import 'package:example/widgets/card_highlight.dart';
import 'package:fluent_ui/fluent_ui.dart';

import '../../../widgets/page.dart';

class FlipViewPage extends StatefulWidget {
  const FlipViewPage({super.key});

  @override
  State<FlipViewPage> createState() => _FlipViewPageState();
}

class _FlipViewPageState extends State<FlipViewPage>
    with PageMixin {
  static const double itemHeight = 500;
    bool selected = true;
      String? comboboxValue;

  int topIndex = 0;

  PaneDisplayMode displayMode = PaneDisplayMode.expanded;
  String pageTransition = 'Default';

  String indicator = 'Sticky';
  bool hasTopBar = true;

  List<NavigationPaneItem> items = [];

  @override
  Widget build(final BuildContext context) {
    return ScaffoldPage.scrollable(
      header: const PageHeader(title: Text('FlipView')),
      children: [
        const Text(
          'The FlipView lets you flip through a collection of items, one at a time. It\'s great for displaying images from a gallery, pages of a magazine, or similar items.',
        ),
        const SizedBox(height: 30),
        Text('A simple FlipView with items declared inline', style: FluentTheme.of(context).typography.subtitle,),
        const SizedBox(height: 20),
        const CardHighlight(
          codeSnippet: '''
dependencies:
  fluent_ui: ^4.13.0''',
        ),
        const SizedBox(height: 30),

        Text('Vertical FlipView', style: FluentTheme.of(context).typography.subtitle,),
        const SizedBox(height: 10,),
        const Text(
          "The ScaffoldPage widget provides a basic structure for your app's "
          'UI, including a header and content area.',
        ),
        const SizedBox(height: 20),
        CardHighlight(
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

        Scrollbar(
    child: InteractiveViewer(
      boundaryMargin: EdgeInsets.all(20.0),
      minScale: 0.1,
      maxScale: 4.0, // Allows zooming up to 4x the original size
      child: Image.network(
        'https://avatars.githubusercontent.com/u/9919?s=200&v=4', // Or use Image.asset
      ),
    ),),
      ],
    );
  }
}
