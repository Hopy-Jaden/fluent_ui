import 'package:example/widgets/card_highlight.dart';
import 'package:fluent_ui/fluent_ui.dart';

import '../../../widgets/page.dart';

class SettingsCardPage extends StatefulWidget {
  const SettingsCardPage({super.key});

  @override
  State<SettingsCardPage> createState() => _SettingsCardPageState();
}

class _SettingsCardPageState extends State<SettingsCardPage> with PageMixin {
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
      header: const PageHeader(title: Text('Settings Card')),
      children: [
        const Text(
          'A card control that can be used to create Windows 11 style settings experience, introduced in the windows community toolkit gallery. '
          'Follow these steps to create Settings Card using existing widget provided from this library.',
        ),
        const SizedBox(height: 30),
        Text(
          'Simple Setting Card',
          style: FluentTheme.of(context).typography.title,
        ),
        const SizedBox(height: 10),
        const Text(
          'SettingsCard is a control that can be used to display settings in your experience. '
          'It uses the default styling found in Windows 11 and is easy to use, meets all accessibility standards '
          'and will make your settings page look great! It typically contains a header, description, header icon and content to create an easy '
          'to use experience',
        ),
        const SizedBox(height: 30),
        Text(
          'Step 1: Wrap the ListTile() widget with a Card() widget',
          style: FluentTheme.of(context).typography.subtitle,
        ),
        const SizedBox(height: 10),
        const Text(
          'Set the vertical padding of the list tile in the card widget as 8.0.',
        ),
        const SizedBox(height: 20),
        CardHighlight(
          initiallyOpen: false,
          codeSnippet: '''
Card(
  padding: EdgeInsetsGeometry.symmetric(vertical: 8.0),
  child: ListTile()
),
''',
          child: const Card(
            padding: EdgeInsetsGeometry.symmetric(vertical: 8.0),
            child: ListTile(),
          ),
        ),
        const SizedBox(height: 30),
        Text(
          'Step 2: Put Widgets inside ListTile() based on your need',
          style: FluentTheme.of(context).typography.subtitle,
        ),
        const SizedBox(height: 10),
        const Text(
          'Some settings card do not have header icon while some do not have description.',
        ),
        const SizedBox(height: 20),
        CardHighlight(
          initiallyOpen: true,
          codeSnippet: '''
Card(
  padding: EdgeInsetsGeometry.symmetric(vertical: 8.0),
  child: ListTile(
    title: Text('Header'), //Header of the settings
    subtitle: Text('description'), //Description of the settings
    leading: Icon(WindowsIcons.action_center), //Icon typically included in the card
    trailing: Button(
      child: Text('Settings'), 
      onPressed: () {}
    ), //Any widget to modify the settings
  ),
),
''',
          child: Card(
            padding: EdgeInsetsGeometry.symmetric(vertical: 8.0),
            child: ListTile(
              title: Text('Header'),
              subtitle: Text('description'),
              leading: Icon(WindowsIcons.action_center),
              trailing: Button(child: Text('Settings'), onPressed: () {}),
            ),
          ),
        ),
        const SizedBox(height: 60),
        Text(
          'Clickable Setting Card',
          style: FluentTheme.of(context).typography.title,
        ),
        const SizedBox(height: 10),
        const Text(
          'SettingsCard can also be turned into a button. This can be useful whenever you want your settings '
          'component to navigate to a detail page or open an external link. ',
        ),
        const SizedBox(height: 30),
        Text(
          'Step 1: Begin with a HoverButton() returning FocusBorder()',
          style: FluentTheme.of(context).typography.subtitle,
        ),
        const SizedBox(height: 10),
        Text(
          'SettingsCard can also be turned into a button. This can be useful whenever you want your settings '
          'component to navigate to a detail page or open an external link. ',
        ),
        const SizedBox(height: 20),
        CardHighlight(
          initiallyOpen: false,
          codeSnippet: '''
HoverButton(
  onPressed: () {
    //function when the settings card is clicked
  },
  builder: (final context, final states) {
    return FocusBorder();
  }
),
''',
        ),
        const SizedBox(height: 30),

        Text(
          'Step 2: Set AnimatedContainer() as the child',
          style: FluentTheme.of(context).typography.subtitle,
        ),
        const SizedBox(height: 10),
        Text(
          'SettingsCard can also be turned into a button. This can be useful whenever you want your settings '
          'component to navigate to a detail page or open an external link. ',
        ),
        const SizedBox(height: 20),
        CardHighlight(
          initiallyOpen: false,
          codeSnippet: '''
HoverButton(
  onPressed: () {
    //function when the settings card is clicked
  },
  builder: (final context, final states) {
    return FocusBorder(
      focused: states.isFocused,
      renderOutside: false,
      child: AnimatedContainer(),
    );
  }
),
''',
        ),
        const SizedBox(height: 30),
        Text(
          'Step 3: Decorate AnimatedContainer()',
          style: FluentTheme.of(context).typography.subtitle,
        ),
        const SizedBox(height: 10),
        Text(
          'SettingsCard can also be turned into a button. This can be useful whenever you want your settings '
          'component to navigate to a detail page or open an external link. ',
        ),
        const SizedBox(height: 20),
        CardHighlight(
          initiallyOpen: true,
          codeSnippet: '''
HoverButton(
  onPressed: () {
    //function when the settings card is clicked
  },
  builder: (final context, final states) {
    return FocusBorder(
      focused: states.isFocused,
      renderOutside: false,
      child: AnimatedContainer(
        duration: FluentTheme.of(context).fasterAnimationDuration,
        decoration: BoxDecoration(
          color: ButtonThemeData.uncheckedInputColor(
            FluentTheme.of(context),
            states,
            transparentWhenNone: true,
          ),
        ),
        child: Card(), //Introduce the settings card
      ),
    );
  }
),
''',
        ),
        const SizedBox(height: 30),
        Text(
          'Step 4: Create the Settings Card as the child of AnimatedContainer()',
          style: FluentTheme.of(context).typography.subtitle,
        ),
        const SizedBox(height: 10),
        Text(
          'SettingsCard can also be turned into a button. This can be useful whenever you want your settings '
          'component to navigate to a detail page or open an external link. ',
        ),
        const SizedBox(height: 20),
        CardHighlight(
          codeSnippet: '''
HoverButton(
  onPressed: () {
    //function when the settings card is clicked
  },
  builder: (final context, final states) {
    return FocusBorder(
      focused: states.isFocused,
      renderOutside: false,
      child: AnimatedContainer(
        duration: FluentTheme.of(context).fasterAnimationDuration,
        decoration: BoxDecoration(
          color: ButtonThemeData.uncheckedInputColor(
            FluentTheme.of(context),
            states,
            transparentWhenNone: true,
          ),
        ),
        child:  Card(
          padding: EdgeInsetsGeometry.symmetric(vertical: 8.0),
          child: ListTile(
            title: Text('Theme'),
            subtitle: Text('Change the appearance of the app'),
            leading: Icon(WindowsIcons.color),
            trailing: Icon(WindowsIcons.chevron_right),
          ),
        ),
      ),
    );
  }
),
''',
          child: HoverButton(
            onPressed: () {},
            builder: (final context, final states) {
              return FocusBorder(
                focused: states.isFocused,
                renderOutside: false,
                child: AnimatedContainer(
                  duration: FluentTheme.of(context).fasterAnimationDuration,
                  decoration: BoxDecoration(
                    color: ButtonThemeData.uncheckedInputColor(
                      FluentTheme.of(context),
                      states,
                      transparentWhenNone: true,
                    ),
                  ),
                  child: Card(
                    padding: EdgeInsetsGeometry.symmetric(vertical: 8.0),
                    child: ListTile(
                      title: Text('Theme'),
                      subtitle: Text('Change the appearance of the app'),
                      leading: Icon(WindowsIcons.color),
                      trailing: Icon(WindowsIcons.chevron_right),
                    ),
                  ), 
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
