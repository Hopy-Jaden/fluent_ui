import 'package:example/main.dart';
import 'package:example/widgets/card_highlight.dart';
import 'package:example/widgets/page.dart';
import 'package:fluent_ui/fluent_ui.dart';

class TitleBarPage extends StatefulWidget {
  const TitleBarPage({super.key});

  @override
  State<TitleBarPage> createState() => _TitleBarPageState();
}

class _TitleBarPageState extends State<TitleBarPage> with PageMixin {
  var titleController = TextEditingController();
  var subtitleController = TextEditingController();
  var usernameController = TextEditingController();
  var titleString = 'Win UI for Flutter';
  var subtitleString = 'Beta';
  var userName = 'Jane Doe';
  bool isBackButtonVisible = false;
  bool isPaneToggleButtonVisible = false;

  @override
  Widget build(final BuildContext context) {
    var titlebar = SizedBox(
      height: 50,
      child: TitleBar(
        title: Text(titleString),
        subtitle: Text(subtitleString),
        isBackButtonVisible: isBackButtonVisible,
        content: Center(
          child: Wrap(
            children: [
              AutoSuggestBox(
                trailingIcon: Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: IconButton(
                    icon: Icon(WindowsIcons.search),
                    onPressed: () {},
                  ),
                ),
                items: [],
                placeholder: 'Search',
              ),
            ],
          ),
        ),
        endHeader: Avatar(name: userName == '' ? null : userName),
        captionControls: WindowButtons(),
      ),
    );
    var editingControls = Column(
      //mainAxisAlignment: ,
      children: [
        SizedBox(
          width: 200,
          child: TextBox(
            placeholder: 'Title',
            controller: titleController,
            onChanged: (value) {
              setState(() {
                titleString = value;
              });
            },
          ),
        ),
        SizedBox(height: 10),
        SizedBox(
          width: 200,
          child: TextBox(
            placeholder: 'Subtitle',
            controller: subtitleController,
            onChanged: (value) {
              setState(() {
                subtitleString = value;
              });
            },
          ),
        ),
        SizedBox(height: 10),
        SizedBox(
          width: 200,
          child: TextBox(
            placeholder: 'Username',
            controller: usernameController,
            onChanged: (value) {
              setState(() {
                userName = value;
              });
            },
          ),
        ),
        SizedBox(height: 20),
        ToggleSwitch(
          content: Text('Back Button Visible'),
          checked: isBackButtonVisible,
          onChanged: (v) {
            setState(() {
              isBackButtonVisible = v;
            });
          },
        ),
      ],
    );
    var displayedCodeSnippetName = userName=='' ? 'null' : "'$userName'";
    return ScaffoldPage.scrollable(
      header: const PageHeader(title: Text('TitleBar')),
      children: [
        const Text(
          'The TitleBar provide a simple way to create a modern titlebar UX with interactive content',
        ),
        subtitle(content: const Text('A simple TitleBar')),
        CardHighlight(
          codeSnippet: '''
TitleBar(
  title: Text('$titleString'),
  subtitle: Text('$subtitleString'),
  isBackButtonVisible: $isBackButtonVisible,
  content: AutoSuggestBox(
    trailingIcon: Padding(
      padding: const EdgeInsets.only(right: 4),
      child: IconButton(
        icon: Icon(WindowsIcons.search),
        onPressed: () {},
      ),
    ),
    items: [],
    placeholder: 'Search',
  ),
  endHeader: Avatar(name: $displayedCodeSnippetName),
  captionControls: WindowButtons(),
),
''',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: 5.0,
                    children: [
                      ClipRRect(borderRadius: BorderRadiusGeometry.circular(8),
                      child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadiusGeometry.circular(8), 
                        border: BoxBorder.fromBorderSide(BorderSide(color: FluentTheme.of(context).resources.surfaceStrokeColorDefault))),
                        child: titlebar
                    ))]
                  ),
                ),
              ),
              SizedBox(width: 30),
              Card(child: editingControls)
            ],
          ),/*Row(
            children: [
              Column(children: [titlebar, editingControls]),
              SizedBox(width: 270, child: Card( child: editingControls,),)
            ],
          ),*/
        ),
      ],
    );
  }
}
