import 'package:clipboard/clipboard.dart';
import 'package:example/widgets/card_highlight.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart' as ms;
import 'package:url_launcher/link.dart';

Future<void> showCopiedSnackbar(BuildContext context, String copiedText) {
  return displayInfoBar(
    context,
    builder: (context, close) => InfoBar(
      title: RichText(
        text: TextSpan(
          text: 'Copied ',
          style: const TextStyle(color: Colors.white),
          children: [
            TextSpan(
              text: copiedText,
              style: TextStyle(
                color: Colors.blue.defaultBrushFor(
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

class IcongraphyPage extends StatefulWidget {
  const IcongraphyPage({super.key});

  @override
  State<IcongraphyPage> createState() => _IcongraphyPageState();
}

class _IcongraphyPageState extends State<IcongraphyPage> {
  String filterText = '';
  int topIndex = 0;
  late CardHighlight code;

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasFluentTheme(context));

    return ScaffoldPage(
      header: PageHeader(
        title: const Text('Icongraphy'),
        commandBar: Link(
          // from the url_launcher package
          uri: Uri.parse('https://fluent2.microsoft.design/iconography'),
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
            onChanged: (index) {
              filterText = '';
              setState(() => topIndex = index);
            },
            displayMode: PaneDisplayMode.top,
            items: [
              PaneItem(
                  icon: Icon(FluentIcons.library),
                  title: Text('mdl2 Icon Library'),
                  body: Mdl2IconLibraryPage()),
              PaneItem(
                  icon: Icon(FluentIcons.grid_view_medium),
                  title: Text('Segoe Icon Library'),
                  body: FluentIconLibraryPage()),
            ]),
      ),
    );
  }

  static String snakeCasetoSentenceCase(String original) {
    return '${original[0].toUpperCase()}${original.substring(1)}'
        .replaceAll(RegExp(r'(_|-)+'), ' ');
  }
}

class Mdl2IconLibraryPage extends StatefulWidget {
  Mdl2IconLibraryPage({super.key});

  @override
  State<Mdl2IconLibraryPage> createState() => _Mdl2IconLibraryPageState();
}

class _Mdl2IconLibraryPageState extends State<Mdl2IconLibraryPage> {
  String filterText = '';

  late CardHighlight code;

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasFluentTheme(context));

    final entries = FluentIcons.allIcons.entries.where(
      (icon) =>
          filterText.isEmpty ||
          // Remove '_'
          icon.key
              .replaceAll('_', '')
              // toLowerCase
              .toLowerCase()
              .contains(filterText
                  .toLowerCase()
                  // Remove spaces
                  .replaceAll(' ', '')),
    );

    var searchbox = Tooltip(
      message: 'Filter by name',
      child: SizedBox(
        width: 240.0,
        child: TextBox(
          suffix: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: const Icon(
              FluentIcons.search,
              size: 12.0,
            ),
          ),
          placeholder: 'Type to filter icons by name (e.g "logo")',
          onChanged: (value) => setState(() {
            filterText = value;
          }),
        ),
      ),
    );

    var defaultGridView = Expanded(
      //height: 500,
      child: GridView.builder(
        padding: EdgeInsetsDirectional.only(
          //start: PageHeader.horizontalPadding(context),
          end: PageHeader.horizontalPadding(context),
        ),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 150,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          childAspectRatio: 4 / 5,
        ),
        itemCount: entries.length,
        itemBuilder: (context, index) {
          final e = entries.elementAt(index);
          return HoverButton(
            onPressed: () async {
              final copyText = 'FluentIcons.${e.key}';
              await FlutterClipboard.copy(copyText);
              if (context.mounted) showCopiedSnackbar(context, copyText);
            },
            cursor: SystemMouseCursors.copy,
            builder: (context, states) {
              return FocusBorder(
                focused: states.isFocused,
                renderOutside: false,
                child: Tooltip(
                  useMousePosition: false,
                  message:
                      '\nFluentIcons.${e.key}\n(tap to copy to clipboard)\n',
                  child: RepaintBoundary(
                    child: AnimatedContainer(
                      duration: FluentTheme.of(context).fasterAnimationDuration,
                      decoration: BoxDecoration(
                        color: ButtonThemeData.uncheckedInputColor(
                          FluentTheme.of(context),
                          states,
                          transparentWhenNone: true,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      //padding: const EdgeInsets.all(6.0),
                      child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(e.value, size: 40),
                            Padding(
                              padding:
                                  const EdgeInsetsDirectional.only(top: 8.0),
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
    );

    var mdl2IconLibrary = Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: double.infinity,
            child: InfoBar(
              title: Text('Tip:'),
              content: Text(
                'You can click on any icon to copy its name to the clipboard!',
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Expander(
            header: Padding(
              padding: EdgeInsets.symmetric(vertical: 24.0),
              child: Text('Instructions on how to use Segoe mdl2 Icon'),
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    'Segoe mdl2 icons are icons used when windows 10 is released'),
                SizedBox(height: 10.0),
                Text(
                  'How to get the icon',
                  style: FluentTheme.of(context).typography.bodyStrong,
                ),
                Text(
                    'Segoe mdl2 icons are icons used when windows 10 is released'),
                Text(
                    'By default, there\'s nothing you need to do, the icon set comes with this library.'),
                SizedBox(height: 10.0),
                Text(
                  'How to use the icon',
                  style: FluentTheme.of(context).typography.bodyStrong,
                ),
                Text('Inside Icon(), put the name of FluentIcons'),
                SyntaxView(
                  code: 'Icon(FluentIcons.add)',
                  syntaxTheme: getSyntaxTheme(FluentTheme.of(context)),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          searchbox,
          SizedBox(height: 10.0),
          defaultGridView
        ],
      ),
    );

    return mdl2IconLibrary;
  }

  static String snakeCasetoSentenceCase(String original) {
    return '${original[0].toUpperCase()}${original.substring(1)}'
        .replaceAll(RegExp(r'(_|-)+'), ' ');
  }
}

class FluentIconLibraryPage extends StatefulWidget {
  FluentIconLibraryPage({super.key});

  @override
  State<FluentIconLibraryPage> createState() => _FluentIconLibraryPageState();
}

class _FluentIconLibraryPageState extends State<FluentIconLibraryPage> {
  String filterText = '';

  late CardHighlight code;

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasFluentTheme(context));
/*
    final entries = FluentIcons.allIcons.entries.where(
      (icon) =>
          filterText.isEmpty ||
          // Remove '_'
          icon.key
              .replaceAll('_', '')
              // toLowerCase
              .toLowerCase()
              .contains(filterText
                  .toLowerCase()
                  // Remove spaces
                  .replaceAll(' ', '')),
    );

    var searchbox = Tooltip(
      message: 'Filter by name',
      child: SizedBox(
        width: 240.0,
        child: TextBox(
          suffix: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: const Icon(
              FluentIcons.search,
              size: 12.0,
            ),
          ),
          placeholder: 'Type to filter icons by name (e.g "logo")',
          onChanged: (value) => setState(() {
            filterText = value;
          }),
        ),
      ),
    );

    var fluentGridView = Expanded(
      //height: 500,
      child: GridView.builder(
        padding: EdgeInsetsDirectional.only(
          //start: PageHeader.horizontalPadding(context),
          end: PageHeader.horizontalPadding(context),
        ),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 150,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          childAspectRatio: 4 / 5,
        ),
        itemCount: entries.length,
        itemBuilder: (context, index) {
          final e = entries.elementAt(index);
          return HoverButton(
            onPressed: () async {
              final copyText = 'FluentIcons.${e.key}';
              await FlutterClipboard.copy(copyText);
              if (context.mounted) showCopiedSnackbar(context, copyText);
            },
            cursor: SystemMouseCursors.copy,
            builder: (context, states) {
              return FocusBorder(
                focused: states.isFocused,
                renderOutside: false,
                child: Tooltip(
                  useMousePosition: false,
                  message:
                      '\nFluentIcons.${e.key}\n(tap to copy to clipboard)\n',
                  child: RepaintBoundary(
                    child: AnimatedContainer(
                      duration: FluentTheme.of(context).fasterAnimationDuration,
                      decoration: BoxDecoration(
                        color: ButtonThemeData.uncheckedInputColor(
                          FluentTheme.of(context),
                          states,
                          transparentWhenNone: true,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      //padding: const EdgeInsets.all(6.0),
                      child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(e.value, size: 40),
                            Padding(
                              padding:
                                  const EdgeInsetsDirectional.only(top: 8.0),
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
    );
*/
    var fluentIconLibrary = Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /*
          const SizedBox(
            width: double.infinity,
            child: InfoBar(
              title: Text('Tip:'),
              content: Text(
                'You can click on any icon to copy its name to the clipboard!',
              ),
            ),
          ),
          SizedBox(height: 10.0),*/
          Expander(
            header: Padding(
              padding: EdgeInsets.symmetric(vertical: 24.0),
              child: Text('Instructions on how to use Segoe fluent Icon'),
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'How to get the icon',
                  style: FluentTheme.of(context).typography.bodyStrong,
                ),
                Text(
                    'With the release of windows 11, Segoe fluent icons are the recommended icons to use.'),
                Text(
                  'Import the official microsoft library and specify a prefix.',
                ),
                SyntaxView(
                  code:
                      '''import 'package:fluentui_system_icons/fluentui_system_icons.dart' as ms;''',
                  syntaxTheme: getSyntaxTheme(FluentTheme.of(context)),
                ),
                SizedBox(height: 10.0),
                Text(
                  'How to use the icon',
                  style: FluentTheme.of(context).typography.bodyStrong,
                ),
                Text(
                    'Inside Icon(), put \'ms.\' in front of the name of FluentIcons'),
                SyntaxView(
                  code: 'Icon(ms.FluentIcons.add_24_regular)',
                  syntaxTheme: getSyntaxTheme(FluentTheme.of(context)),
                ),
              ],
            ),
          ), /*
          SizedBox(
            height: 10.0,
          ),
          searchbox,
          SizedBox(height: 10.0),
          fluentGridView*/
        ],
      ),
    );

    return fluentIconLibrary;
  }

  static String snakeCasetoSentenceCase(String original) {
    return '${original[0].toUpperCase()}${original.substring(1)}'
        .replaceAll(RegExp(r'(_|-)+'), ' ');
  }
}
