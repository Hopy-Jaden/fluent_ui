import 'package:example/widgets/card_highlight.dart';
import 'package:example/widgets/page.dart';
import 'package:fluent_ui/fluent_ui.dart';

class HardwareConsiderationPage extends StatefulWidget {
  const HardwareConsiderationPage({super.key});

  @override
  State<HardwareConsiderationPage> createState() =>
      _HardwareConsiderationPageState();
}

class _HardwareConsiderationPageState extends State<HardwareConsiderationPage>
    with PageMixin {
  bool firstChecked = false;
  bool firstDisabled = false;
  bool? secondChecked = false;
  bool secondDisabled = false;
  bool iconDisabled = false;
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      header: const PageHeader(title: Text('Hardware Consideration')),
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
