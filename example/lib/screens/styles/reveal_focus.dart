import 'dart:math';

import 'package:example/widgets/card_highlight.dart';
import 'package:fluent_ui/fluent_ui.dart' hide Page;
import 'package:url_launcher/link.dart';

import '../../widgets/page.dart';

class RevealFocusPage extends StatelessWidget with PageMixin {
  RevealFocusPage({super.key});

  final FocusNode focus = FocusNode();

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    return ScaffoldPage.withPadding(
      header: PageHeader(
        title: const Text('Reveal Focus'),
        commandBar: Link(
          // from the url_launcher package
          uri: Uri.parse(
              'https://learn.microsoft.com/en-us/windows/uwp/ui-input/reveal-focus'),
          builder: (Context, open) {
            return Button(
              child: Text('Documentation'),
              onPressed: open,
            );
          },
        ),
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          description(
            content: const Text(
              'Reveal Focus is a lighting effect for 10-foot experiences, such '
              'as Xbox One and television screens. It animates the border of '
              'focusable elements, such as buttons, when the user moves gamepad '
              'or keyboard focus to them. It\'s turned off by default, but '
              'it\'s simple to enable.',
            ),
          ),
          subtitle(content: const Text('Enabling reveal focus')),
          CardHighlight(
            codeSnippet: '''FocusTheme(
  data: FocusThemeData(
    borderRadius: BorderRaidus.zero,
    glowFactor: 4.0,
  ),
  child: ...,
)''',
            child: Center(
              child: FocusTheme(
                data: FocusThemeData(
                  borderRadius: BorderRadius.zero,
                  // glowColor: theme.accentColor.withValues(alpha: 0.2),
                  glowFactor: 4.0,
                  primaryBorder: BorderSide(
                    width: 2.0,
                    color: theme.inactiveColor,
                  ),
                ),
                child: Row(children: [
                  Wrap(
                    runSpacing: 10.0,
                    spacing: 10.0,
                    alignment: WrapAlignment.center,
                    children: [
                      buildCard(focus),
                      buildCard(),
                      buildCard(),
                      buildCard(),
                    ],
                  ),
                  const Spacer(),
                  Button(
                    child: const Text('Focus'),
                    onPressed: () => focus.requestFocus(),
                  ),
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCard([FocusNode? node]) {
    final color =
        Colors.accentColors[Random().nextInt(Colors.accentColors.length - 1)];
    return HoverButton(
      focusNode: node,
      onPressed: () {},
      builder: (context, states) {
        return FocusBorder(
          focused: states.isFocused,
          useStackApproach: false,
          child: Card(
            backgroundColor: color,
            child: const SizedBox(
              width: 50.0,
              height: 50.0,
            ),
          ),
        );
      },
    );
  }
}
