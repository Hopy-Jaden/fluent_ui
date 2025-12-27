import 'package:example/widgets/card_highlight.dart';
import 'package:fluent_ui/fluent_ui.dart';

class TokenViewPage extends StatefulWidget {
  const TokenViewPage({super.key});
  @override
  State<TokenViewPage> createState() => _TokenViewPageState();
}

class _TokenViewPageState extends State<TokenViewPage> {
  bool isActionTokenSelected = false;
  List<String> filterTokens = [
    'Documents',
    'Images',
    'Videos',
    'Music',
    'Archives',
    'Others',
  ];
  List<String> selectedFilterTokens = [];
  List<String> choiceTokens = [
    'Favourites',
    'Shared',
    'Recent',
  ];
  String selectedChoiceTokens = 'Favourites';
  List<String> inputTokens = [
    'Alice',
    'Bob',
    'Charlie',
    'David',
    'Eve',
  ];
  List<String> selectedInputTokens = [];
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      header: PageHeader(title: const Text('Token View')),
      children: [
        const Text(
          'A Token View is a control that displays a collection of tokens, '
          'which are small, interactive elements that represent discrete pieces of information, '
          'such as tags, categories, or user selections. '
          'Tokens can be added, removed, or selected by the user, making them useful for '
          'input fields, filters, and multi-select scenarios.',
        ),
        const SizedBox(height: 30),
        Text(
          'Token used to trigger an Action',
          style: FluentTheme.of(context).typography.subtitle,
        ),
        const Text(
          'Token can be used to trigger an action or show progress and confirmation. They can appear dynamically and contextually in a UI. It is single-selectable, non-togglable, non-removable.',
        ),
        const SizedBox(height: 10),
        CardHighlight(
          codeSnippet: '''
bool isActionTokenSelected = false;

...

Token(
  isTogglable: false, // Token that trigger actions tends to be non-togglable
  selected: isActionTokenSelected,
  icon: Icon(isActionTokenSelected ? FluentIcons.heart : FluentIcons.heart_fill),
  child: const Text('Favourite'),
  onSelected: (value) => setState(() => isActionTokenSelected = !isActionTokenSelected),
),
''',
          child: Wrap(
            children: [Token(
              isTogglable: false, // Token that trigger actions tends to be non-togglable
              selected: isActionTokenSelected,
              icon: Icon(isActionTokenSelected ? FluentIcons.heart : FluentIcons.heart_fill),
              child: const Text('Favourite'),
              onSelected: (value) => setState(() => isActionTokenSelected = !isActionTokenSelected),
            ),]
          ),
        ),
        const SizedBox(height: 30),
        Text(
          'Token acting for a Choice',
          style: FluentTheme.of(context).typography.subtitle,
        ),
        const Text(
          'Token can act as a single choice from a set, containing related descriptive text or categories. It is single-selectable, togglable, non-removable.',
        ),
        const SizedBox(height: 10),
        CardHighlight(
          codeSnippet: '''
List<String> choiceTokens = [
    'Favourites',
    'Shared',
    'Recent',
];
String selectedChoiceTokens = 'Favourites'; // Default selected choice token

...

Wrap(
  spacing: 5.0,
  child: List<Widget>.generate(choiceTokens.length, (int index) {
    return Token(
      selected: selectedChoiceTokens == choiceTokens[index], // To allow single selection
      onSelected: (bool selected) {
        setState(() {
          if (selectedChoiceTokens != choiceTokens[index]) {
            selectedChoiceTokens = choiceTokens[index]; // Ensure there will always be one option selected.
          }
        });
      },
      child: Text(choiceTokens[index]), // Token label according to list item
    );
  }),
),
''',
          child: Wrap(
            spacing: 5.0,
            children: List<Widget>.generate(choiceTokens.length, (int index) {
              return Token(
                selected: selectedChoiceTokens == choiceTokens[index], // To allow single selection
                onSelected: (bool selected) {
                  setState(() {
                    if (selectedChoiceTokens != choiceTokens[index]) {
                      selectedChoiceTokens = choiceTokens[index]; // Ensure there will always be one option selected.
                    }
                  });
                },
                child: Text(choiceTokens[index]),
              );
            }),
          ),
        ),
        const SizedBox(height: 30),
        Text(
          'Token acting as a Filter',
          style: FluentTheme.of(context).typography.subtitle,
        ),
        const Text(
          'Tokens can act as a filter using tags or descriptive words as a way to filter content.  It is multi-selectable, togglable, non-removable.',
        ),
        const SizedBox(height: 10),
        CardHighlight(
          codeSnippet: '''
List<String> filterTokens = [
    'Documents',
    'Images',
    'Videos',
    'Music',
    'Archives',
    'Others',
  ];
List<String> selectedFilterTokens = [];

...

List<Widget>.generate(filterTokens.length, (int index) {
  return Token(
    selected: selectedFilterTokens.contains(filterTokens[index]), // To allow multiple selection
    onSelected: (bool selected) {
      setState(() {
        if (selectedFilterTokens.contains(filterTokens[index])) {
          selectedFilterTokens.remove(filterTokens[index]); // Deselect token if selected
        } else {
          selectedFilterTokens.add(filterTokens[index]); // Select token if not selected
        }
      });
    },
    child: Text(filterTokens[index]), // Token label according to list item
  );
}),
''',
          child: Wrap(
            spacing: 5.0,
            children: List<Widget>.generate(filterTokens.length, (int index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Token(
                  selected: selectedFilterTokens.contains(filterTokens[index]),
                  onSelected: (bool selected) {
                    setState(() {
                      if (selectedFilterTokens.contains(filterTokens[index])) {
                        selectedFilterTokens.remove(filterTokens[index]);
                      } else {
                        selectedFilterTokens.add(filterTokens[index]);
                      }
                    });
                  },
                  child: Text(filterTokens[index]),
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: 30),
        Text(
          'Token acting for an Input',
          style: FluentTheme.of(context).typography.subtitle,
        ),
        const Text(
          'Token represent a complex piece of information, such as an entity (person, place, or thing) or conversational text, in a compact form. It is multi-selectable, togglable, removable.',
        ),
        const SizedBox(height: 10),
        CardHighlight(
          codeSnippet: '''
Wrap(
  spacing: 5.0,
  children: List<Widget>.generate(inputTokens.length, (int index) {
    return Token(
      isRemovable: true, // Input tokens are usually removable
      selected: selectedInputTokens.contains(inputTokens[index]), // To allow multiple selection
      onSelected: (bool selected) {
        setState(() {
          if (selectedInputTokens.contains(inputTokens[index])) {
            selectedInputTokens.remove(inputTokens[index]); // Deselect token if selected
          } else {
            selectedInputTokens.add(inputTokens[index]); // Select token if not selected
          }
        });
      },
      onRemoved: () {
        setState(() {
          inputTokens.remove(inputTokens[index]); // Remove token from the list
        });
      },
      child: Text(inputTokens[index]), // Token label according to list item
    );
  }),
),
''',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: 5.0,
                    children: List<Widget>.generate(inputTokens.length, (int index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Token(
                          isRemovable: true,
                          selected: selectedInputTokens.contains(inputTokens[index]),
                          onSelected: (bool selected) {
                            setState(() {
                              if (selectedInputTokens.contains(inputTokens[index])) {
                                selectedInputTokens.remove(inputTokens[index]);
                              } else {
                                selectedInputTokens.add(inputTokens[index]);
                              }
                            });
                          },
                          onRemoved: () {
                            setState(() {
                              inputTokens.remove(inputTokens[index]);
                            });
                          },
                          child: Text(inputTokens[index]),
                        ),
                      );
                    }),
                  ),
                ),
              ),
              Button(
                child: const Text('Add Token'),
                onPressed: () {
                  setState(() {
                    inputTokens.add('Token ${inputTokens.length + 1}');
                  });
                },
              ),
              const SizedBox(width: 10),
              Button(child: const Text('Reset'), 
              onPressed: () {
                setState(() {
                  inputTokens = [
                    'Alice',
                    'Bob',
                    'Charlie',
                    'David',
                    'Eve',
                  ];
                  selectedInputTokens = [];
                });
              },)
            ],
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
