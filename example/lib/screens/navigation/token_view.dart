import 'package:fluent_ui/fluent_ui.dart';

class TokenViewPage extends StatelessWidget {
  const TokenViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      header: PageHeader(
            title: const Text('Token View'),
          ),
      children: [
          const Text(
            'A Token View is a control that displays a collection of tokens, '
            'which are small, interactive elements that represent discrete pieces of information, '
            'such as tags, categories, or user selections. '
            'Tokens can be added, removed, or selected by the user, making them useful for '
            'input fields, filters, and multi-select scenarios.',
          ),
          const SizedBox(height: 10),
          Text('Token acting for an Action', style: FluentTheme.of(context).typography.subtitle,),
          const Text('Token can be used to trigger an action or show progress and confirmation. They can appear dynamically and contextually in a UI.'),
          const SizedBox(height: 30),
          Text('Token acting for a Filter', style: FluentTheme.of(context).typography.subtitle,),
          const Text('Tokens can act as a filter using tags or descriptive words as a way to filter content.'),
          const SizedBox(height: 30),
          Text('Token acting for a Choice', style: FluentTheme.of(context).typography.subtitle,),
          const Text('Token can act as a single choice from a set, containing related descriptive text or categories.'),
          const SizedBox(height: 30),
          Text('Token acting for an Input', style: FluentTheme.of(context).typography.subtitle,),
          const Text('Token represent a complex piece of information, such as an entity (person, place, or thing) or conversational text, in a compact form.'),
          const SizedBox(height: 30),
        ],
    );
  }
}
