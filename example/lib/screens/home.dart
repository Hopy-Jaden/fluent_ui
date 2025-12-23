import 'package:example/widgets/card_highlight.dart';
import 'package:example/widgets/changelog.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:url_launcher/link.dart';

import '../models/sponsor.dart';
import '../widgets/material_equivalents.dart';
import '../widgets/page.dart';
import '../widgets/sponsor.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with PageMixin {
  bool selected = true;
  String? comboboxValue;

  @override
  Widget build(final BuildContext context) {
    assert(debugCheckHasFluentTheme(context));
    final theme = FluentTheme.of(context);

    return ScaffoldPage.scrollable(
        //moved to the Rows of Cards below
        /*commandBar: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Link(
              uri: Uri.parse('https://github.com/bdlukaa/fluent_ui'),
              builder: (final context, final open) => Semantics(
                link: true,
                child: Tooltip(
                  message: 'Source code',
                  child: IconButton(
                    icon: const WindowsIcon(WindowsIcons.code, size: 24),
                    onPressed: open,
                  ),
                ),
              ),
            ),
          ],
        ),*/      
      children: [
        //Page Header Moved Here
        SizedBox(height: 22,),
        Text('Showcase App', style: theme.typography.subtitle),
        Text('Windows UI for Flutter', style: theme.typography.titleLarge),
        //will move to new page
        /*
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
      home: const HomePage(),
    );
  }
}
''',
          child: Card(
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 10,
              children: [
                InfoLabel(
                  label: 'Inputs',
                  child: ToggleSwitch(
                    checked: selected,
                    onChanged: (final v) => setState(() => selected = v),
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: InfoLabel(
                    label: 'Forms',
                    child: ComboBox<String>(
                      value: comboboxValue,
                      items: ['Item 1', 'Item 2']
                          .map(
                            (final e) => ComboBoxItem(value: e, child: Text(e)),
                          )
                          .toList(),
                      isExpanded: true,
                      onChanged: (final v) => setState(() => comboboxValue = v),
                    ),
                  ),
                ),
                RepaintBoundary(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(start: 4),
                    child: InfoLabel(
                      label: 'Progress',
                      child: const SizedBox(
                        height: 30,
                        width: 30,
                        child: ProgressRing(),
                      ),
                    ),
                  ),
                ),
                InfoLabel(
                  label: 'Surfaces & Materials',
                  child: SizedBox(
                    height: 40,
                    width: 120,
                    child: Stack(
                      children: [
                        Container(
                          width: 120,
                          height: 50,
                          color: theme.accentColor.lightest,
                        ),
                        const Positioned.fill(
                          child: Acrylic(luminosityAlpha: 0.5),
                        ),
                      ],
                    ),
                  ),
                ),
                InfoLabel(
                  label: 'Icons',
                  child: const WindowsIcon(FluentIcons.flag, size: 30),
                ),
                InfoLabel(
                  label: 'Colors',
                  child: SizedBox(
                    width: 40,
                    height: 30,
                    child: Wrap(
                      children:
                          <Color>[
                            ...Colors.accentColors,
                            Colors.successPrimaryColor,
                            Colors.warningPrimaryColor,
                            Colors.errorPrimaryColor,
                            Colors.grey,
                          ].map((final color) {
                            return Container(
                              height: 10,
                              width: 10,
                              color: color,
                            );
                          }).toList(),
                    ),
                  ),
                ),
                InfoLabel(
                  label: 'Typography',
                  child: ShaderMask(
                    shaderCallback: (final rect) {
                      return LinearGradient(
                        colors: [Colors.white, ...Colors.accentColors],
                      ).createShader(rect);
                    },
                    blendMode: BlendMode.srcATop,
                    child: const Text(
                      'ABCDEFGH',
                      style: TextStyle(
                        fontSize: 24,
                        shadows: [Shadow(offset: Offset(1, 1))],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        */
        const SizedBox(height: 70),
        Text('issue: incorrect searchbox width, incorrect card hover effect, no image transition, incorrect principle table view, incorrect iconography code, incorrect typography table view,'),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              // Card opening github repository
              Link(uri: Uri.parse('https://github.com/bdlukaa/fluent_ui'), builder: (context, followLink) => GestureDetector(onTap: followLink,
                child: Card(child: SizedBox(height: 150, width:230, child: Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.end, children: [
                  Icon(WindowsIcons.code, size: 30,), 
                  SizedBox(height:15),
                  Text('Fluent UI on Github', style: theme.typography.bodyStrong,),
                  Text('Explore the source code of the Fluent UI library and repository.'),
                  SizedBox(height:10),
                  Icon(WindowsIcons.open_in_new_window),
                ],),),),
              ),),
              SizedBox(width: 12,),
              //Card opening changelog dialog
              GestureDetector(onTap: () => showDialog(context: context, barrierDismissible: true, builder: (final context) => const Changelog(),),
                child: Card(child: SizedBox(height: 150, width:230, child: Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.end, children: [
                  Icon(WindowsIcons.megaphone, size: 30,), 
                  SizedBox(height:15),
                  Text('What\'s new on 4.0.0', style: theme.typography.bodyStrong,),
                  Text('A native look-and-feel out of the box. - June 21, 2022'),
                  SizedBox(height:10),
                  Icon(WindowsIcons.open_in_new_window),
                ],),),),
              ),
              SizedBox(width: 12,),
              //Card opening WinUI documentation
              Link(uri: Uri.parse('https://learn.microsoft.com/en-us/windows/apps/introduction'), builder: (context, followLink) => GestureDetector(onTap: followLink,
                child: Card(child: SizedBox(height: 150, width:230, child: Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.end, children: [
                  Icon(WindowsIcons.library, size: 30,), 
                  SizedBox(height:15),
                  Text('Win UI Documentation', style: theme.typography.bodyStrong,),
                  Text('Get started with WinUI and explore detailed documentation'),
                  SizedBox(height:10),
                  Icon(WindowsIcons.open_in_new_window),
                ],),),),
              ),),
              SizedBox(width: 12,),
              //Card opening Win UI design guidelines
              Link(uri: Uri.parse('https://learn.microsoft.com/en-us/windows/apps/design/'), builder: (context, followLink) => GestureDetector(onTap: followLink,
                child: Card(child: SizedBox(height: 150, width:230, child: Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.end, children: [
                  Icon(WindowsIcons.design, size: 30,), 
                  SizedBox(height:15),
                  Text('Design Win UI', style: theme.typography.bodyStrong,),
                  Text('Guidelines and toolkits for creating stunning WinUI experiences.'),
                  SizedBox(height:10),
                  Icon(WindowsIcons.open_in_new_window),
                ],),),),
              ),),
              SizedBox(width: 12,),
              //Card opening Fluent UI documentation
              Link(uri: Uri.parse('https://fluent2.microsoft.design/'), builder: (context, followLink) => GestureDetector(onTap: followLink,
                child: Card(child: SizedBox(height: 150, width:230, child: Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.end, children: [
                  Icon(WindowsIcons.document, size: 30,), 
                  SizedBox(height:15),
                  Text('Fluent UI 2 Documentation', style: theme.typography.bodyStrong,),
                  Text('Explore the official Fluent UI 2 documentation by Microsoft.'),
                  SizedBox(height:10),
                  Icon(WindowsIcons.open_in_new_window),
                ],),),),
              ),),
              SizedBox(width: 12,),
            ],
          )),
        const SizedBox(height: 60),
        Row(
          children: [
            Text('Sponsors', style: theme.typography.title),
            const SizedBox(width: 10),
            const WindowsIcon(WindowsIcons.heart_fill, size: 20),
          ],
        ),
        const SizedBox(height: 4),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: <Widget>[
            ...sponsors.map((final sponsor) {
              return sponsor.build();
            }),
            IconButton(onPressed: () {
                showDialog(
                  context: context,
                  builder: (final context) => const SponsorDialog(),
                );
              },
                icon:  Card(child: SizedBox(height: 200, width:150, child: Column(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center, children: [
                  SizedBox(height: 60, width: 60, child: ShaderMask(
                      shaderCallback: (final rect) {
                        return LinearGradient(
                          colors: [
                            Colors.white.withValues(alpha: 0.8),
                            ...Colors.accentColors,
                          ],
                        ).createShader(rect);
                      },
                      blendMode: BlendMode.srcATop,
                      child: const WindowsIcon(
                        FluentIcons.diamond_user,
                        size: 60,
                      ),
                    ),
                  ),
                          SizedBox(height:45),
                          Text('Become a Sponsor!', style: FluentTheme.of(context).typography.bodyStrong,),
                  ],),),),
              ),
          ],
        ),
        const SizedBox(height: 60),
        Text('Contributors', style: theme.typography.title),
        const SizedBox(height: 4),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: contributors.map((final contributor) {
            return contributor.build();
          }).toList(),
        ),
        const SizedBox(height: 60),
        Text('Equivalents with the material and cupertino libraries', style: theme.typography.title),
        const SizedBox(height: 4),
        const UIEquivalents(),
      ],
    );
  }
}
