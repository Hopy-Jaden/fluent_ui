import 'package:fluent_ui/fluent_ui.dart';
import 'package:url_launcher/link.dart';

import '../models/sponsor.dart';
import '../widgets/changelog.dart';
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
  Widget build(BuildContext context) {
    assert(debugCheckHasFluentTheme(context));
    final theme = FluentTheme.of(context);

    return ScaffoldPage.scrollable(
      header: PageHeader(
          //title:  const Text('Fluent UI for Flutter Gallery'),
          /*commandBar: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          Link(
            uri: Uri.parse('https://github.com/bdlukaa/fluent_ui'),
            builder: (context, open) => Semantics(
              link: true,
              child: Tooltip(
                message: 'Source code',
                child: IconButton(
                  icon: const Icon(FluentIcons.open_source, size: 24.0),
                  onPressed: open,
                ),
              ),
            ),
          ),
        ]),*/
          ),
      children: [
        /* Failed to use header png to stack for the effect
        Stack(alignment: Alignment.bottomLeft, children: [
          Column(
            children: [
              Image.asset(
                'assets/images/header.png',
                width: MediaQuery.sizeOf(context).width,
                scale: 0.1,
              ),
              SizedBox(
                height: 100,
                child: Container(
                  color: Colors.black,
                ),
              )
            ],
          ),*/
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            subtitle(content: const Text('Version 4')),
            titleLarge(content: const Text('Fluent UI for Flutter Gallery')),
            const SizedBox(height: 75.0),
            Wrap(spacing: 10.0, runSpacing: 10.0, children: <Widget>[
              PortalCard(
                title: 'What\'s New',
                icon: Icon(
                  FluentIcons.megaphone,
                  size: 55,
                ),
                description: 'A native look-and-feel out of the box',
                function: () {
                  showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (context) => const Changelog(),
                  );
                },
              ),
              Link(
                  uri: Uri.parse('https://fluent2.microsoft.design/'),
                  builder: (context, followLink) {
                    return Semantics(
                      link: true,
                      child: PortalCard(
                          title: 'Design',
                          icon: Icon(
                            FluentIcons.color,
                            size: 55,
                          ),
                          description:
                              'Guidelines for creating stunning FluentUI experience',
                          function: followLink),
                    );
                  }),
              Link(
                  uri: Uri.parse('https://github.com/bdlukaa/fluent_ui'),
                  builder: (context, followLink) {
                    return Semantics(
                      link: true,
                      child: PortalCard(
                          title: 'Github',
                          icon: Icon(
                            FluentIcons.code,
                            size: 55,
                          ),
                          description:
                              'Explore the FluentUI source code and repository',
                          function: followLink),
                    );
                  }),
              PortalCard(
                  function: () {
                    showDialog(
                      context: context,
                      builder: (context) => const SponsorDialog(),
                    );
                  },
                  icon: Icon(FluentIcons.diamond_user, size: 60),
                  title: 'Sponsor',
                  description: 'Become a Sponsor to support!'),
            ]),
          ],
        ),
        //]),
        const SizedBox(height: 22.0),
        subtitle(content: const Text('Community')),
        const SizedBox(height: 4.0),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: community.map((member) {
            return member.build();
          }).toList(),
        ),
        const SizedBox(height: 22.0),
        subtitle(content: const Text('Common Widgets from the Library')),
        const SizedBox(height: 22.0),
        Wrap(alignment: WrapAlignment.center, spacing: 30.0, children: [
          InfoLabel(
            label: 'Inputs',
            child: ToggleSwitch(
              checked: selected,
              onChanged: (v) => setState(() => selected = v),
            ),
          ),
          SizedBox(
            width: 100,
            child: InfoLabel(
              label: 'Forms',
              child: ComboBox<String>(
                value: comboboxValue,
                items: ['Item 1', 'Item 2']
                    .map((e) => ComboBoxItem(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),
                isExpanded: true,
                onChanged: (v) => setState(() => comboboxValue = v),
              ),
            ),
          ),
          RepaintBoundary(
            child: Padding(
              padding: const EdgeInsetsDirectional.only(start: 4.0),
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
              child: Stack(children: [
                Container(
                  width: 120,
                  height: 50,
                  color: theme.accentColor.lightest,
                ),
                const Positioned.fill(child: Acrylic(luminosityAlpha: 0.5)),
              ]),
            ),
          ),
          InfoLabel(
            label: 'Icons',
            child: const Icon(FluentIcons.graph_symbol, size: 30.0),
          ),
          InfoLabel(
            label: 'Colors',
            child: SizedBox(
              width: 40,
              height: 30,
              child: Wrap(
                children: <Color>[
                  ...Colors.accentColors,
                  Colors.successPrimaryColor,
                  Colors.warningPrimaryColor,
                  Colors.errorPrimaryColor,
                  Colors.grey,
                ].map((color) {
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
              shaderCallback: (rect) {
                return LinearGradient(
                  colors: [
                    Colors.white,
                    ...Colors.accentColors,
                  ],
                ).createShader(rect);
              },
              blendMode: BlendMode.srcATop,
              child: const Text(
                'ABCDEFGH',
                style: TextStyle(fontSize: 24, shadows: [
                  Shadow(offset: Offset(1, 1)),
                ]),
              ),
            ),
          ),
        ]),
        const SizedBox(height: 22.0),
        subtitle(content: const Text('Equivalents with the material library')),
        const SizedBox(height: 4.0),
        const MaterialEquivalents(),
      ],
    );
  }
}

class MemberCard extends StatelessWidget {
  const MemberCard({
    super.key,
    required this.imageUrl,
    required this.username,
    required this.tag,
  });

  final String imageUrl;
  final String username;
  final String tag;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      //height: 214,
      child: Card(
        child: ListTile(
            leading: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                ),
                shape: BoxShape.circle,
              ),
            ),
            title: Text(username),
            subtitle: InfoBadge(
              source: Text('$tag   '),
            )),
      ),
    );
  }
}

class PortalCard extends StatelessWidget {
  final String? title;
  final String description;
  final Icon icon;
  void Function()? function;

  PortalCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: SizedBox(
        width: 218,
        height: 214,
        child: Card(
          padding: EdgeInsets.all(24),
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              icon,
              SizedBox(
                height: 12,
              ),
              Text(
                title ?? '',
                style: FluentTheme.of(context).typography.subtitle!,
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                description,
                style: FluentTheme.of(context).typography.caption!,
              ),
              SizedBox(
                height: 12,
              ),
              Icon(FluentIcons.pop_expand),
            ],
          ),
        ),
      ),
    );
  }
}
