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

  final expanderKeyforstep5 = GlobalKey<ExpanderState>(
    debugLabel: 'Expander key',
  );
  final expanderKeyforstep6 = GlobalKey<ExpanderState>(
    debugLabel: 'Expander key',
  );
  final expanderKeyforstep7 = GlobalKey<ExpanderState>(
    debugLabel: 'Expander key',
  );
  bool checked = false;

  @override
  Widget build(final BuildContext context) {
    return ScaffoldPage.scrollable(
      header: const PageHeader(title: Text('Settings Control')),
      children: [
        const Text(
          'A card or expander control can be used to create Windows 11 style settings experience, introduced in the windows community toolkit gallery. '
          'Follow these steps to create Settings Card and Settings Expander using existing widget provided from this library.',
        ),
        const SizedBox(height: 30),
        Text(
          'Simple settings card',
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
          'Clickable settings card',
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
          'Inside the HoverButton builder return a FocusBorder whose child is an AnimatedContainer. '
          'Use the AnimatedContainer() to animate background and wrap a Card or Expander as its child.',
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
          'Animate the background by setting a duration and a BoxDecoration with a unchecked background color. '
          'Place a Card or Expander as the AnimatedContainer\'s child depending on your need.',
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
        child: Card(), //Introduce the settings card or setting expander
      ),
    );
  }
),
''',
        ),
        const SizedBox(height: 30),
        Text(
          'Step 4a: Create the Settings Card as the child of AnimatedContainer()',
          style: FluentTheme.of(context).typography.subtitle,
        ),
        const SizedBox(height: 10),
        Text(
          'To create a settings card, use vertical padding of 8.0 and place a ListTile inside the Card with a title, '
          'optional subtitle, a leading icon, and a trailing widget (for example a chevron or a settings button) to represent the setting.',
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
        const SizedBox(height: 60),
        Text(
          'Simple Settings Expander',
          style: FluentTheme.of(context).typography.title,
        ),
        const SizedBox(height: 10),
        const Text(
          'The Settings Expander can be used to group multiple s into a single collapsible group. '
          'A Settings Expander can have it\'s own content to display a setting on the right, just like a Settings Card, '
          'but in addition can have any number of extra items to include as additional settings. ',
        ),
        const SizedBox(height: 30),
        Text(
          'Step 4b: Use a Expander() as the child of AnimatedContainer() instead',
          style: FluentTheme.of(context).typography.subtitle,
        ),
        const SizedBox(height: 10),
        const Text(
          'Expander allows the creation of a collapsible settings group. '
          'Ot provides a header (like a settings card) and expandable content where you can place additional setting items.',
        ),
        const SizedBox(height: 20),
        CardHighlight(
          initiallyOpen: false,
          codeSnippet: '''
final expanderKey = GlobalKey<ExpanderState>(debugLabel: 'Expander key');

...

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
        child: Expander(
          key: expanderKey,
          header: Padding(
            padding: EdgeInsetsGeometry.symmetric(vertical: 8.0),
            child: ListTile(),
          ), //introduce padding
          content: Container(),
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
                  child: Expander(
                    header: Padding(
                      padding: EdgeInsetsGeometry.symmetric(vertical: 8.0),
                      child: ListTile(),
                    ), //introduce padding
                    content: Container(),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 30),
        Text(
          'Step 5: Make the ListTile() region clickable',
          style: FluentTheme.of(context).typography.subtitle,
        ),
        const SizedBox(height: 10),
        const Text(
          'Set the tileColor of the ListTile to transparent to prevent hover color from showing when clicking the tile area. '
          'Also provide an onPressed handler that toggles the Expander via its GlobalKey so clicking the header expands/collapses the content.',
        ),
        const SizedBox(height: 20),
        CardHighlight(
          initiallyOpen: false,
          codeSnippet: '''
final expanderKey = GlobalKey<ExpanderState>(debugLabel: 'Expander key');

...

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
        child: Expander(
          key: expanderKey,
          header: Padding(
            padding: EdgeInsetsGeometry.symmetric(vertical: 8.0),
            child: ListTile(
              tileColor: WidgetStateColor.resolveWith(
                (states) => Colors.transparent,
              ), //to prevent hover color from showing when clicking on list tile region
              onPressed: () {
                final open = expanderKey.currentState?.isExpanded ?? false;
                expanderKey.currentState?.isExpanded = !open;
              }, //to allow expander to expand when clicking on list tile region
            ),
          ),
          content: Container(),
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
                  child: Expander(
                    key: expanderKeyforstep5,
                    header: Padding(
                      padding: EdgeInsetsGeometry.symmetric(vertical: 8.0),
                      child: ListTile(
                        tileColor: WidgetStateColor.resolveWith(
                          (states) => Colors.transparent,
                        ),
                        onPressed: () {
                          final open =
                              expanderKeyforstep5.currentState?.isExpanded ??
                              false;
                          expanderKeyforstep5.currentState?.isExpanded = !open;
                        },
                      ),
                    ), //introduce padding
                    content: Container(),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 30),
        Text(
          'Step 6: Set the Settings Expander Header',
          style: FluentTheme.of(context).typography.subtitle,
        ),
        const SizedBox(height: 10),
        const Text(
          'Set the header to allow modification on settings of it\'s own content.',
        ),
        const SizedBox(height: 20),
        CardHighlight(
          initiallyOpen: false,
          codeSnippet: '''
final expanderKey = GlobalKey<ExpanderState>(debugLabel: 'Expander key');

...

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
        child: Expander(
          key: expanderKey,
          header: Padding(
            padding: EdgeInsetsGeometry.symmetric(vertical: 8.0),
            child: ListTile(
              tileColor: WidgetStateColor.resolveWith(
                (states) => Colors.transparent,
              ),
              onPressed: () {
                final open = expanderKey.currentState?.isExpanded ?? false;
                expanderKey.currentState?.isExpanded = !open;
              },
              title: Text('Header'), //title of the expander header
              subtitle: Text('description'), //Description of the expander header
              leading: Icon(WindowsIcons.action_center), //Icon typically included in the expander header
              trailing: Button(
                child: Text('Settings'),
                onPressed: () {},
              ), //Any widget to modify the expander header setting
            ),
          ),
          content: Container(),
        ),
      ),
    );
  }
),
''',
          child: //Step 6: Set the Tile color and onPressed function of ListTile()
          HoverButton(
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
                  child: Expander(
                    key: expanderKeyforstep6,
                    header: Padding(
                      padding: EdgeInsetsGeometry.symmetric(vertical: 8.0),
                      child: ListTile(
                        tileColor: WidgetStateColor.resolveWith(
                          (states) => Colors.transparent,
                        ),
                        onPressed: () {
                          final open =
                              expanderKeyforstep6.currentState?.isExpanded ??
                              false;
                          expanderKeyforstep6.currentState?.isExpanded = !open;
                        },
                        title: Text('Header'), //title of the expander header
                        subtitle: Text(
                          'description',
                        ), //Description of the expander header
                        leading: Icon(
                          WindowsIcons.action_center,
                        ), //Icon typically included in the expander header
                        trailing: Button(
                          child: Text('Settings'),
                          onPressed: () {},
                        ), //Any widget to modify the expander header setting
                      ),
                    ), //introduce padding
                    content: Container(),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 30),
        Text(
          'Step 7: Place the Content of the Settings Expander',
          style: FluentTheme.of(context).typography.subtitle,
        ),
        const SizedBox(height: 10),
        const Text(
          'Depending on the situation, place any number of extra widget item as additional settings.',
        ),
        const SizedBox(height: 20),
        CardHighlight(
          initiallyOpen: true,
          codeSnippet: '''
final expanderKey = GlobalKey<ExpanderState>(debugLabel: 'Expander key');

...

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
        child: Expander(
          key: expanderKey,
          header: Padding(
            padding: EdgeInsetsGeometry.symmetric(vertical: 8.0),
            child: ListTile(
              tileColor: WidgetStateColor.resolveWith(
                (states) => Colors.transparent,
              ), //to prevent hover color from showing when clicking on list tile region
              onPressed: () {
                final open = expanderKey.currentState?.isExpanded ?? false;
                expanderKey.currentState?.isExpanded = !open;
              }, //to allow expander to expand when clicking on list tile region
            ),
          ),
          content: ListTile(
            title: Container(),
            subtitle: Text('Subsettings Here!'),
            leading: Checkbox(checked: checked, onChanged: (v){
              setState(() {
                checked = v!;
              });
            }),
          ),//Any widget to modify the expander content setting
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
                  child: Expander(
                    key: expanderKeyforstep7,
                    header: Padding(
                      padding: EdgeInsetsGeometry.symmetric(vertical: 8.0),
                      child: ListTile(
                        tileColor: WidgetStateColor.resolveWith(
                          (states) => Colors.transparent,
                        ),
                        onPressed: () {
                          final open =
                              expanderKeyforstep7.currentState?.isExpanded ??
                              false;
                          expanderKeyforstep7.currentState?.isExpanded = !open;
                        },
                        title: Text('Header'), //title of the expander header
                        subtitle: Text(
                          'description',
                        ), //Description of the expander header
                        leading: Icon(
                          WindowsIcons.action_center,
                        ), //Icon typically included in the expander header
                        trailing: Button(
                          child: Text('Settings'),
                          onPressed: () {},
                        ), //Any widget to modify the expander header setting
                      ),
                    ), //introduce padding
                    content: ListTile(
                      title: Container(),
                      subtitle: Text('Subsettings Here!'),
                      leading: Checkbox(
                        checked: checked,
                        onChanged: (v) {
                          setState(() {
                            checked = v!;
                          });
                        },
                      ),
                    ), //Any widget to modify the expander content setting
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
