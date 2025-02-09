import 'package:example/widgets/card_highlight.dart';
import 'package:example/widgets/page.dart';
import 'package:fluent_ui/fluent_ui.dart';

class AnnotatedScrollPage extends StatefulWidget {
  const AnnotatedScrollPage({super.key});

  @override
  State<AnnotatedScrollPage> createState() => _AnnotatedScrollPageState();
}

class _AnnotatedScrollPageState extends State<AnnotatedScrollPage>
    with PageMixin {
  bool firstChecked = false;
  bool firstDisabled = false;
  bool? secondChecked = false;
  bool secondDisabled = false;
  bool iconDisabled = false;
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      header: const PageHeader(title: Text('Annotated Scroll')),
      children: [
        const Text(
          'Page Descriiption Here',
        ),
        subtitle(content: const Text('Subtitle')),
        CardHighlight(
          codeSnippet: '''bool checked = false;

Checkbox(
  checked: checked,
  onPressed: disabled ? null : (v) => setState(() => checked = v),
)''',
          child: Row(children: [
            Checkbox(
              checked: firstChecked,
              onChanged: firstDisabled
                  ? null
                  : (v) => setState(() => firstChecked = v!),
              content: const Text('Two-state Checkbox'),
            ),
            const Spacer(),
            ToggleSwitch(
              checked: firstDisabled,
              onChanged: (v) {
                setState(() {
                  firstDisabled = v;
                });
              },
              content: const Text('Disabled'),
            ),
          ]),
        ),
      ],
    );
  }
}
