import 'dart:math';

import 'package:example/widgets/card_highlight.dart';
import 'package:fluent_ui/fluent_ui.dart' hide Page;

import '../../widgets/page.dart';

class RevealFocusPage extends StatelessWidget with PageMixin {
  RevealFocusPage({super.key});

  final FocusNode focus = FocusNode();

  @override
  Widget build(final BuildContext context) {
    final theme = FluentTheme.of(context);
    return ScaffoldPage.withPadding(
      header: PageHeader(
        title: const Text('Reveal Focus'),
        commandBar: Button(
          onPressed: focus.requestFocus,
          child: const Text('Focus'),
        ),
      ),
      content: Column(
        children: [
          description(
            content: const Text(
              'Reveal Focus is a lighting effect for 10-foot experiences, such '
              'as Xbox One and television screens. It animates the border of '
              'focusable elements, such as buttons, when the user moves gamepad '
              "or keyboard focus to them. It's turned off by default, but "
              "it's simple to enable.",
            ),
          ),
          subtitle(content: const Text('Enabling reveal focus')),
          CardHighlight(
            codeSnippet: '''
FocusTheme(
  data: FocusThemeData(
    borderRadius: BorderRadius.circular(8.0),
    glowColor: theme.accentColor.withValues(alpha: 0.2),
    glowFactor: 3,
    primaryBorder: BorderSide(
      width: 3,
      color: theme.brightness == Brightness.light
        ? Colors.white
        : Colors.black.withOpacity(0.4),
      ),
      secondaryBorder: BorderSide(
        width: 1,
        color: theme.accentColor,
      ),
    ),
  child: ...,
)''',
            child: Center(
              child: FocusTheme(
                data: FocusThemeData(
                  borderRadius: BorderRadius.circular(8.0),
                  glowColor: theme.accentColor.withValues(alpha: 0.2),
                  glowFactor: 3,
                  primaryBorder: BorderSide(
                    width: 3,
                    color: theme.brightness == Brightness.light
                        ? Colors.white
                        : Colors.black.withOpacity(0.4),
                  ),
                  secondaryBorder: BorderSide(
                    width: 1,
                    color: theme.accentColor,
                  ),
                ),
                child: Wrap(
                  runSpacing: 10,
                  spacing: 20,
                  alignment: WrapAlignment.center,
                  children: [
                    buildCard(focus),
                    buildCard(),
                    buildCard(),
                    buildCard(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCard([final FocusNode? node]) {
    final color =
        Colors.accentColors[Random().nextInt(Colors.accentColors.length - 1)];
    return HoverButton(
      focusNode: node,
      onPressed: () {},
      builder: (final context, final states) {
        return FocusBorder(
          focused: states.isFocused,
          child: Card(
            backgroundColor: FluentTheme.of(context).brightness == Brightness.light
                ? Color(0xfffbfbfb)
                : Color(0xff2b2b2b),
            child: const SizedBox(width: 50, height: 50),
          ),
        );
      },
    );
  }
}
