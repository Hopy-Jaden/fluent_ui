import 'package:example/screens/fluentThemeBuilder.dart';
import 'package:example/screens/home.dart';
import 'package:example/screens/settings.dart';
import 'package:fluent_ui/fluent_ui.dart' hide Page;
import 'package:flutter/foundation.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart' as flutter_acrylic;
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:system_theme/system_theme.dart';
import 'package:url_launcher/link.dart';
import 'package:window_manager/window_manager.dart';

import 'routes/styles.dart' deferred as styles;
import 'routes/layout.dart' deferred as layout;
import 'routes/platforms.dart' deferred as platforms;
import 'routes/fluentapp.dart' deferred as fluentapp;
import 'routes/surfaces.dart' deferred as surfaces;
import 'routes/inputs.dart' deferred as inputs;
import 'routes/text.dart' deferred as text;
import 'routes/collections.dart' deferred as collections;
import 'routes/datetime.dart' deferred as datetime;
import 'routes/popups.dart' deferred as popups;
import 'routes/media.dart' deferred as media;
import 'routes/toolbar.dart' deferred as toolbar;
import 'routes/navigation.dart' deferred as navigation;
import 'routes/scrolling.dart' deferred as scrolling;
import 'routes/status.dart' deferred as status;
import 'theme.dart';
import 'widgets/deferred_widget.dart';

const String appTitle = 'Fluent UI for Flutter';
const String appIcon = 'assets/FluentLogo.png';

/// Checks if the current environment is a desktop environment.
bool get isDesktop {
  if (kIsWeb) return false;
  return [
    TargetPlatform.windows,
    TargetPlatform.linux,
    TargetPlatform.macOS,
  ].contains(defaultTargetPlatform);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // if it's not on the web, windows or android, load the accent color
  if (!kIsWeb &&
      [
        TargetPlatform.windows,
        TargetPlatform.android,
      ].contains(defaultTargetPlatform)) {
    SystemTheme.accentColor.load();
  }

  if (isDesktop) {
    await flutter_acrylic.Window.initialize();
    if (defaultTargetPlatform == TargetPlatform.windows) {
      await flutter_acrylic.Window.hideWindowControls();
    }
    await WindowManager.instance.ensureInitialized();
    windowManager.waitUntilReadyToShow().then((_) async {
      await windowManager.setTitleBarStyle(
        TitleBarStyle.hidden,
        windowButtonVisibility: false,
      );
      await windowManager.setMinimumSize(const Size(500, 600));
      await windowManager.show();
      await windowManager.setPreventClose(true);
      await windowManager.setSkipTaskbar(false);
    });
  }

  runApp(const MyApp());

  Future.wait([
    DeferredWidget.preload(styles.loadLibrary),
    DeferredWidget.preload(layout.loadLibrary),
    DeferredWidget.preload(platforms.loadLibrary),
    DeferredWidget.preload(fluentapp.loadLibrary),
    DeferredWidget.preload(surfaces.loadLibrary),
    DeferredWidget.preload(inputs.loadLibrary),
    DeferredWidget.preload(text.loadLibrary),
    DeferredWidget.preload(collections.loadLibrary),
    DeferredWidget.preload(datetime.loadLibrary),
    DeferredWidget.preload(popups.loadLibrary),
    DeferredWidget.preload(media.loadLibrary),
    DeferredWidget.preload(toolbar.loadLibrary),
    DeferredWidget.preload(navigation.loadLibrary),
    DeferredWidget.preload(scrolling.loadLibrary),
    DeferredWidget.preload(status.loadLibrary),
  ]);
}

final _appTheme = AppTheme();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _appTheme,
      builder: (context, child) {
        final appTheme = context.watch<AppTheme>();
        return FluentApp.router(
          title: appTitle,
          themeMode: appTheme.mode,
          debugShowCheckedModeBanner: false,
          color: appTheme.color,
          darkTheme: FluentThemeData(
            brightness: Brightness.dark,
            accentColor: appTheme.color,
            visualDensity: VisualDensity.standard,
            focusTheme: FocusThemeData(
              glowFactor: is10footScreen(context) ? 2.0 : 0.0,
            ),
          ),
          theme: FluentThemeData(
            accentColor: appTheme.color,
            visualDensity: VisualDensity.standard,
            focusTheme: FocusThemeData(
              glowFactor: is10footScreen(context) ? 2.0 : 0.0,
            ),
          ),
          locale: appTheme.locale,
          builder: (context, child) {
            return Directionality(
              textDirection: appTheme.textDirection,
              child: NavigationPaneTheme(
                data: NavigationPaneThemeData(
                  backgroundColor: appTheme.windowEffect !=
                          flutter_acrylic.WindowEffect.disabled
                      ? Colors.transparent
                      : null,
                ),
                child: child!,
              ),
            );
          },
          routeInformationParser: router.routeInformationParser,
          routerDelegate: router.routerDelegate,
          routeInformationProvider: router.routeInformationProvider,
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.child,
    required this.shellContext,
  });

  final Widget child;
  final BuildContext? shellContext;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WindowListener {
  bool value = false;

  // int index = 0;

  final viewKey = GlobalKey(debugLabel: 'Navigation View Key');
  final searchKey = GlobalKey(debugLabel: 'Search Bar Key');
  final searchFocusNode = FocusNode();
  final searchController = TextEditingController();

  late final List<NavigationPaneItem> originalItems = [
    PaneItem(
      key: const ValueKey('/'),
      icon: const Icon(FluentIcons.home),
      title: const Text('Home'),
      body: const SizedBox.shrink(),
    ),
    //New Arrangement made, original theming pages, issue: indicator not appearing
    PaneItemExpander(
      icon: const Icon(FluentIcons.format_painter),
      title: const Text('Styles'),
      body: const SizedBox.shrink(),
      items: [
        //New colour contrast section to be added
        PaneItem(
          key: const ValueKey('/styles/colors'),
          icon: const Icon(FluentIcons.color),
          title: const Text('Colors'),
          body: const SizedBox.shrink(),
        ),
        //New Page is needed for design guideline
        PaneItem(
          key: const ValueKey('/styles/geometry'), //need new key value?
          icon: const Icon(FluentIcons.shapes),
          title: const Text('Geometry'),
          body: const SizedBox.shrink(),
          infoBadge: const InfoBadge(source: Text('NEW  ')),
        ),
        PaneItem(
          //need new key value? what is the use?
          key: const ValueKey('/styles/icongraphy'),
          icon: const Icon(FluentIcons.emoji_tab_symbols),
          title: const Text('Icongraphy'), // title is modified
          body: const SizedBox.shrink(),
        ),
        PaneItem(
          key: const ValueKey('/styles/typography'),
          icon: const Icon(FluentIcons.font),
          title: const Text('Typography'),
          body: const SizedBox.shrink(),
        ),
        PaneItem(
          key: const ValueKey('/styles/reveal_focus'),
          icon: const Icon(FluentIcons.focus),
          title: const Text('Reveal Focus'),
          body: const SizedBox.shrink(),
        ),
      ],
    ),

    //New Arrangement made, issue: indicator not appearing
    PaneItemExpander(
      icon: const Icon(FluentIcons.column_right_two_thirds),
      title: const Text('Layouts'),
      body: const SizedBox.shrink(),
      infoBadge: const InfoBadge(source: Text('NEW  ')),
      items: [
        //New Page is needed for design guideline
        PaneItem(
          key: const ValueKey('/layout/spacing'), //need new key value?
          icon: const Icon(FluentIcons.grid_view_medium),
          title: const Text('Spacing'),
          body: const SizedBox.shrink(), //need a new page
        ),
        //New Page is needed for design guideline
        PaneItem(
          key: const ValueKey('/layout/windows_size'), //need new key value?
          icon: const Icon(FluentIcons.grid_view_medium),
          title: const Text('Windows Size'),
          body: const SizedBox.shrink(), //need a new page
        ),
        //New Page is needed for design guideline
        PaneItem(
          key: const ValueKey(
              '/layout/hardware_consideration'), //need new key value?
          icon: const Icon(FluentIcons.user_window),
          title: const Text('Hardware Considerations'),
          body: const SizedBox.shrink(),
          infoBadge: const InfoBadge(source: Text('NEW  ')),
        ),
      ],
    ),

    //New Arrangement made, issue: indicator not appearing
    PaneItemExpander(
      icon: const Icon(FluentIcons.system),
      title: const Text('Platforms'),
      body: const SizedBox.shrink(),
      infoBadge: const InfoBadge(source: Text('NEW  ')),
      items: [
        //New Page is needed for design guideline
        PaneItem(
          key: const ValueKey('/platforms/windows'), //need new key value?
          icon: const Icon(FluentIcons.grid_view_medium),
          title: const Text('Windows'),
          body: const SizedBox.shrink(),
        ),
        //New Page is needed for design guideline
        PaneItem(
          key: const ValueKey('/platforms/macos'), //need new key value?
          icon: const Icon(FluentIcons.this_p_c),
          title: const Text('MacOS'),
          body: const SizedBox.shrink(),
        ),
        //New Page is needed for design guideline
        PaneItem(
          key: const ValueKey('/platforms/web'), //need new key value?
          icon: const Icon(FluentIcons.globe),
          title: const Text('Web'),
          body: const SizedBox.shrink(),
        ),
        //New Page is needed for design guideline
        PaneItem(
          key: const ValueKey('/platforms/linux'), //need new key value?
          icon: const Icon(FluentIcons.pc1),
          title: const Text('Linux'),
          body: const SizedBox.shrink(),
        ),
        //New Page is needed for design guideline
        PaneItem(
          key: const ValueKey('/platforms/android'), //need new key value?
          icon: const Icon(FluentIcons.cell_phone),
          title: const Text('Android'),
          body: const SizedBox.shrink(),
        ),
        //New Page is needed for design guideline
        PaneItem(
          key: const ValueKey('/platforms/ios'), //need new key value?
          icon: const Icon(FluentIcons.italic),
          title: const Text('IOS'),
          body: const SizedBox.shrink(),
        ),
      ],
    ),

    PaneItemSeparator(),

    //New Arrangement made, issue: indicator not appearing
    PaneItemExpander(
      key: const ValueKey('/fluentapp'),
      icon: const Icon(FluentIcons.app_icon_default),
      title: const Text('Fluent App'),
      body: const SizedBox.shrink(),
      infoBadge: const InfoBadge(source: Text('NEW  ')),
      items: [
        PaneItem(
          key: const ValueKey(
              '/fluentapp/getting_started'), //need new key value?
          icon: const Icon(FluentIcons.code),
          title: const Text('Getting Started'),
          body: const SizedBox.shrink(),
        ),
        //New Page is needed for design guideline
        PaneItem(
          key: const ValueKey('/fluentapp/splash_screen'), //need new key value?
          icon: const Icon(FluentIcons.screen),
          title: const Text('Splash Screen'),
          body: const SizedBox.shrink(),
        ),
        //New Page is needed for design guideline
        PaneItem(
          key: const ValueKey('/fluentapp/appbar'), //need new key value?
          icon: const Icon(FluentIcons.title),
          title: const Text('App Bar'),
          body: const SizedBox.shrink(),
        ),
      ],
    ),

    //New Arrangement made, issue: indicator not appearing
    PaneItemExpander(
      key: const ValueKey('/surfaces'),
      icon: const Icon(FluentIcons.arrange_send_backward),
      title: const Text('Surfaces'),
      body: const SizedBox.shrink(),
      items: [
        PaneItem(
          key: const ValueKey('/surfaces/materials'),
          icon: const Icon(FluentIcons.un_set_color),
          title: const Text('Acrylic'),
          body: const SizedBox.shrink(),
        ),
        //New Page is needed for design guideline
        PaneItem(
          key: const ValueKey('/surfaces/carousel'), //need new key value?
          icon: const Icon(FluentIcons.triple_column),
          title: const Text('Carousel'),
          body: const SizedBox.shrink(),
          infoBadge: const InfoBadge(
            source: Text('NOT SUPPORTED  '),
            color: Color(0xFF979593),
            foregroundColor: Color(0xFFFFFFFF),
          ),
          //enabled: false
        ),
        //New Page is needed for design guideline
        PaneItem(
          key: const ValueKey('/surfaces/cards'), //need new key value?
          icon: const Icon(FluentIcons.rectangle_shape),
          title: const Text('Cards'),
          body: const SizedBox.shrink(),
          infoBadge: const InfoBadge(source: Text('NEW  ')),
        ),
        //New Page is needed for design guideline
        PaneItem(
          key: const ValueKey('/surfaces/sheets'), //need new key value?
          icon: const Icon(FluentIcons.page),
          title: const Text('Sheets'),
          body: const SizedBox.shrink(),
          infoBadge: const InfoBadge(
            source: Text('NOT SUPPORTED  '),
            color: Color(0xFF979593),
            foregroundColor: Color(0xFFFFFFFF),
          ),
          //enabled: false
        ),
      ],
    ),

    //New Arrangement made, issue: indicator not appearing
    PaneItemExpander(
        key: const ValueKey('/forms/textbox'),
        icon: const Icon(FluentIcons.checkbox_composite),
        title: const Text('Input'),
        body: const SizedBox.shrink(),
        items: [
          PaneItem(
            key: const ValueKey('/inputs/buttons'),
            icon: const Icon(FluentIcons.button_control),
            title: const Text('Button'),
            body: const SizedBox.shrink(),
          ),
          PaneItem(
            key: const ValueKey('/inputs/checkbox'),
            icon: const Icon(FluentIcons.checkbox_composite),
            title: const Text('Checkbox'),
            body: const SizedBox.shrink(),
          ),
          PaneItem(
            key: const ValueKey('/inputs/slider'),
            icon: const Icon(FluentIcons.slider),
            title: const Text('Slider'),
            body: const SizedBox.shrink(),
          ),
          //New Page is needed for design guideline
          PaneItem(
            key: const ValueKey('/inputs/rating'), //need new key value?
            icon: const Icon(FluentIcons.favorite_star),
            title: const Text('Rating'),
            body: const SizedBox.shrink(),
            infoBadge: const InfoBadge(
              source: Text('NOT SUPPORTED  '),
              color: Color(0xFF979593),
              foregroundColor: Color(0xFFFFFFFF),
            ),
            //enabled: false
          ),
          //New Page is needed for design guideline
          PaneItem(
            key: const ValueKey('/inputs/chips'), //need new key value?
            icon: const Icon(FluentIcons.tag),
            title: const Text('Chips'),
            body: const SizedBox.shrink(),
            infoBadge: const InfoBadge(
              source: Text('NOT SUPPORTED  '),
              color: Color(0xFF979593),
              foregroundColor: Color(0xFFFFFFFF),
            ),
            //enabled: false
          ),
          PaneItem(
            key: const ValueKey('/inputs/toggle_switch'),
            icon: const Icon(FluentIcons.toggle_left),
            title: const Text('ToggleSwitch'),
            body: const SizedBox.shrink(),
          ),
          PaneItem(
            key: const ValueKey('/inputs/color_picker'),
            icon: const Icon(FluentIcons.color),
            title: const Text('ColorPicker'),
            body: const SizedBox.shrink(),
          ),
        ]),

    /* Moved to Basic Input Expander
    PaneItemHeader(header: const Text('Inputs')),
    PaneItem(
      key: const ValueKey('/inputs/buttons'),
      icon: const Icon(FluentIcons.button_control),
      title: const Text('Button'),
      body: const SizedBox.shrink(),
    ),
    PaneItem(
      key: const ValueKey('/inputs/checkbox'),
      icon: const Icon(FluentIcons.checkbox_composite),
      title: const Text('Checkbox'),
      body: const SizedBox.shrink(),
    ),
    PaneItem(
      key: const ValueKey('/inputs/slider'),
      icon: const Icon(FluentIcons.slider),
      title: const Text('Slider'),
      body: const SizedBox.shrink(),
    ),
    PaneItem(
      key: const ValueKey('/inputs/toggle_switch'),
      icon: const Icon(FluentIcons.toggle_left),
      title: const Text('ToggleSwitch'),
      body: const SizedBox.shrink(),
    ),*/

    //New Arrangement made, issue: indicator not appearing
    PaneItemExpander(
      key: const ValueKey('/text'),
      icon: const Icon(FluentIcons.font),
      title: const Text('Text'),
      body: const SizedBox.shrink(),
      items: [
        PaneItem(
          key: const ValueKey('/text/text_box'),
          icon: const Icon(FluentIcons.text_field),
          title: const Text('TextBox'),
          body: const SizedBox.shrink(),
        ),
        PaneItem(
          key: const ValueKey('/text/auto_suggest_box'),
          icon: const Icon(FluentIcons.page_list),
          title: const Text('AutoSuggestBox'),
          body: const SizedBox.shrink(),
        ),
        PaneItem(
          key: const ValueKey('/text/combobox'),
          icon: const Icon(FluentIcons.combobox),
          title: const Text('ComboBox'),
          body: const SizedBox.shrink(),
        ),
        PaneItem(
          key: const ValueKey('/text/numberbox'),
          icon: const Icon(FluentIcons.number),
          title: const Text('NumberBox'),
          body: const SizedBox.shrink(),
        ),
        PaneItem(
          key: const ValueKey('/text/passwordbox'),
          icon: const Icon(FluentIcons.password_field),
          title: const Text('PasswordBox'),
          body: const SizedBox.shrink(),
        ),
      ],
    ),

    /*PaneItemHeader(header: const Text('Form')),*/
    /* Moved to Text Expander
    PaneItem(
      key: const ValueKey('/forms/text_box'),
      icon: const Icon(FluentIcons.text_field),
      title: const Text('TextBox'),
      body: const SizedBox.shrink(),
    ),
    PaneItem(
      key: const ValueKey('/forms/auto_suggest_box'),
      icon: const Icon(FluentIcons.page_list),
      title: const Text('AutoSuggestBox'),
      body: const SizedBox.shrink(),
    ),
    PaneItem(
      key: const ValueKey('/forms/combobox'),
      icon: const Icon(FluentIcons.combobox),
      title: const Text('ComboBox'),
      body: const SizedBox.shrink(),
    ),
    PaneItem(
      key: const ValueKey('/forms/numberbox'),
      icon: const Icon(FluentIcons.number),
      title: const Text('NumberBox'),
      body: const SizedBox.shrink(),
    ),
    PaneItem(
      key: const ValueKey('/forms/passwordbox'),
      icon: const Icon(FluentIcons.password_field),
      title: const Text('PasswordBox'),
      body: const SizedBox.shrink(),
    ),*/

    //New Arrangement made, issue: indicator not appearing
    PaneItemExpander(
      key: const ValueKey('/collections'),
      icon: const Icon(FluentIcons.grid_view_small),
      title: const Text('Collections'),
      body: const SizedBox.shrink(),
      items: [
        PaneItem(
          key: const ValueKey('/collections/tiles'),
          icon: const Icon(FluentIcons.tiles),
          title: const Text('Tiles'),
          body: const SizedBox.shrink(),
        ),
        //New Page is needed for design guideline
        PaneItem(
          key: const ValueKey('/collections/table'), //need new key value?
          icon: const Icon(FluentIcons.table),
          title: const Text('Table'),
          body: const SizedBox.shrink(),
          infoBadge: const InfoBadge(
            source: Text('NOT PLANNED  '),
            color: Color(0xFF979593),
            foregroundColor: Color(0xFFFFFFFF),
          ),
          //enabled: false
        ),
        //New Page is needed for design guideline
        PaneItem(
          key: const ValueKey('/collections/grid'), //need new key value?
          icon: const Icon(FluentIcons.snap_to_grid),
          title: const Text('Grid'),
          body: const SizedBox.shrink(),
          infoBadge: const InfoBadge(
            source: Text('NOT SUPPORTED  '),
            color: Color(0xFF979593),
            foregroundColor: Color(0xFFFFFFFF),
          ),
          //enabled: false
        ),
        //New Page is needed for design guideline
        PaneItem(
          key: const ValueKey('/collections/flip_view'), //need new key value?
          icon: const Icon(FluentIcons.five_tile_grid),
          title: const Text('Flip View'),
          body: const SizedBox.shrink(),
          infoBadge: const InfoBadge(
            source: Text('NOT SUPPORTED  '),
            color: Color(0xFF979593),
            foregroundColor: Color(0xFFFFFFFF),
          ),
          //enabled: false
        ),
        PaneItem(
          key: const ValueKey('/collections/expander'),
          icon: const Icon(FluentIcons.expand_all),
          title: const Text('Expander'),
          body: const SizedBox.shrink(),
        ),
      ],
    ),

    //New Arrangement made, issue: indicator not appearing
    PaneItemExpander(
      key: const ValueKey('/datetime'),
      icon: const Icon(FluentIcons.date_time),
      title: const Text('Date and Time'),
      body: const SizedBox.shrink(),
      items: [
        PaneItem(
          key: const ValueKey('/datetime/time_picker'),
          icon: const Icon(FluentIcons.time_picker),
          title: const Text('TimePicker'),
          body: const SizedBox.shrink(),
        ),
        PaneItem(
          key: const ValueKey('/datetime/date_picker'),
          icon: const Icon(FluentIcons.date_time),
          title: const Text('DatePicker'),
          body: const SizedBox.shrink(),
        ),
        //New Page is needed for design guideline
        PaneItem(
          key: const ValueKey('/datetime/calendar_view'), //need new key value?
          icon: const Icon(FluentIcons.calendar),
          title: const Text('Calendar View'),
          body: const SizedBox.shrink(),
          infoBadge: const InfoBadge(
            source: Text('NOT SUPPORTED  '),
            color: Color(0xFF979593),
            foregroundColor: Color(0xFFFFFFFF),
          ),
          //enabled: false
        ),
      ],
    ),

    /* Moved to Date and Time Expander
    PaneItem(
      key: const ValueKey('/forms/time_picker'),
      icon: const Icon(FluentIcons.time_picker),
      title: const Text('TimePicker'),
      body: const SizedBox.shrink(),
    ),
    PaneItem(
      key: const ValueKey('/forms/date_picker'),
      icon: const Icon(FluentIcons.date_time),
      title: const Text('DatePicker'),
      body: const SizedBox.shrink(),
    ),*/

    /* Moved to Basic Input Expander
    PaneItem(
      key: const ValueKey('/forms/color_picker'),
      icon: const Icon(FluentIcons.color),
      title: const Text('ColorPicker'),
      body: const SizedBox.shrink(),
    ),
    */

    //New Arrangement made, issue: indicator not appearing
    PaneItemExpander(
      key: const ValueKey('/popups'),
      icon: const Icon(FluentIcons.chat),
      title: const Text('Popups'),
      body: const SizedBox.shrink(),
      items: [
        PaneItem(
          key: const ValueKey('/popups/content_dialog'),
          icon: const Icon(FluentIcons.comment_urgent),
          title: const Text('ContentDialog'),
          body: const SizedBox.shrink(),
        ),
        PaneItem(
          key: const ValueKey('/popups/flyout'),
          icon: const Icon(FluentIcons.pop_expand),
          title: const Text('Flyout'),
          body: const SizedBox.shrink(),
        ),
        PaneItem(
          key: const ValueKey('/popups/teaching_tip'),
          icon: const Icon(FluentIcons.field_filled),
          title: const Text('Teaching Tip'),
          body: const SizedBox.shrink(),
        ),
      ],
    ),

    //New Arrangement made, issue: indicator not appearing
    PaneItemExpander(
      key: const ValueKey('/media'),
      icon: const Icon(FluentIcons.media),
      title: const Text('Media'),
      body: const SizedBox.shrink(),
      items: [
        //New Page is needed for design guideline
        PaneItem(
          key: const ValueKey('/media/avatar'), //need new key value?
          icon: const Icon(FluentIcons.people),
          title: const Text('Avatar'),
          body: const SizedBox.shrink(),
          infoBadge: const InfoBadge(
            source: Text('NOT SUPPORTED  '),
            color: Color(0xFF979593),
            foregroundColor: Color(0xFFFFFFFF),
          ),
          //enabled: false
        ),
        //New Page is needed for design guideline
        PaneItem(
          key: const ValueKey('/media/media_player'), //need new key value?
          icon: const Icon(FluentIcons.playback_rate1x),
          title: const Text('Media Player'),
          body: const SizedBox.shrink(),
          infoBadge: const InfoBadge(
            source: Text('NOT SUPPORTED  '),
            color: Color(0xFF979593),
            foregroundColor: Color(0xFFFFFFFF),
          ),
          //enabled: false
        ),
      ],
    ),

    //New Arrangement made, issue: indicator not appearing
    PaneItemExpander(
      key: const ValueKey('/toolbar'),
      icon: const Icon(FluentIcons.toolbox),
      title: const Text('Menus and Toolbar'),
      body: const SizedBox.shrink(),
      items: [
        PaneItem(
          key: const ValueKey('/toolbar/menu_bar'),
          icon: const Icon(FluentIcons.expand_menu),
          title: const Text('MenuBar'),
          body: const SizedBox.shrink(),
        ),
        PaneItem(
          key: const ValueKey('/toolbar/context_menu'),
          icon: const Icon(FluentIcons.pop_expand),
          title: const Text('Context Menu'),
          body: const SizedBox.shrink(),
        ),
        PaneItem(
          key: const ValueKey('/toolbar/command_bar'),
          icon: const Icon(FluentIcons.customize_toolbar),
          title: const Text('CommandBar'),
          body: const SizedBox.shrink(),
        ),
        //New Page is needed for design guideline
        PaneItem(
          key: const ValueKey('/toolbar/ink_toolbar'), //need new key value?
          icon: const Icon(FluentIcons.inking_tool),
          title: const Text('Ink Toolbar'),
          body: const SizedBox.shrink(),
          infoBadge: const InfoBadge(
            source: Text('NOT SUPPORTED  '),
            color: Color(0xFF979593),
            foregroundColor: Color(0xFFFFFFFF),
          ),
          //enabled: false
        ),
      ],
    ),

    //New Arrangement made, issue: indicator not appearing
    PaneItemExpander(
      key: const ValueKey('/navigation'),
      icon: const Icon(FluentIcons.collapse_menu),
      title: const Text('Navigation'),
      body: const SizedBox.shrink(),
      items: [
        PaneItem(
          key: const ValueKey('/navigation/navigation_view'),
          icon: const Icon(FluentIcons.navigation_flipper),
          title: const Text('NavigationView'),
          body: const SizedBox.shrink(),
        ),
        PaneItem(
          key: const ValueKey('/navigation/tab_view'),
          icon: const Icon(FluentIcons.table_header_row),
          title: const Text('TabView'),
          body: const SizedBox.shrink(),
        ),
        PaneItem(
          key: const ValueKey('/navigation/tree_view'),
          icon: const Icon(FluentIcons.bulleted_tree_list),
          title: const Text('TreeView'),
          body: const SizedBox.shrink(),
        ),
        PaneItem(
          key: const ValueKey('/navigation/breadcrumb_bar'),
          icon: const Icon(FluentIcons.breadcrumb),
          title: const Text('BreadcrumbBar'),
          body: const SizedBox.shrink(),
        ),
      ],
    ),

    /* Moved to Navigation Expander
    PaneItemHeader(header: const Text('Navigation')),
    PaneItem(
      key: const ValueKey('/navigation/navigation_view'),
      icon: const Icon(FluentIcons.navigation_flipper),
      title: const Text('NavigationView'),
      body: const SizedBox.shrink(),
    ),
    PaneItem(
      key: const ValueKey('/navigation/tab_view'),
      icon: const Icon(FluentIcons.table_header_row),
      title: const Text('TabView'),
      body: const SizedBox.shrink(),
    ),
    PaneItem(
      key: const ValueKey('/navigation/tree_view'),
      icon: const Icon(FluentIcons.bulleted_tree_list),
      title: const Text('TreeView'),
      body: const SizedBox.shrink(),
    ),
    PaneItem(
      key: const ValueKey('/navigation/breadcrumb_bar'),
      icon: const Icon(FluentIcons.breadcrumb),
      title: const Text('BreadcrumbBar'),
      body: const SizedBox.shrink(),
    ), */

    //New Arrangement made, issue: indicator not appearing
    PaneItemExpander(
      key: const ValueKey('/scrolling'),
      icon: const Icon(FluentIcons.sort),
      title: const Text('Scrolling'),
      body: const SizedBox.shrink(),
      items: [
        //New Page is needed for design guideline
        PaneItem(
          key: const ValueKey('/scrolling/scroll_bar'), //need new key value?
          icon: const Icon(FluentIcons.scroll_up_down),
          title: const Text('ScrollBar'),
          body: const SizedBox.shrink(),
          infoBadge: const InfoBadge(source: Text('NEW  ')),
        ),
        //New Page is needed for design guideline
        PaneItem(
          key: const ValueKey(
              '/scrolling/annotated_scroll'), //need new key value?
          icon: const Icon(FluentIcons.timeline),
          title: const Text('Annotated Scroll'),
          body: const SizedBox.shrink(),
          infoBadge: const InfoBadge(
            source: Text('NOT SUPPORTED  '),
            color: Color(0xFF979593),
            foregroundColor: Color(0xFFFFFFFF),
          ),
          //enabled: false
        ),
        //New Page is needed for design guideline
        PaneItem(
          key: const ValueKey('/scrolling/pigs_page'), //need new key value?
          icon: const Icon(FluentIcons.page),
          title: const Text('Pigs Page'),
          body: const SizedBox.shrink(),
          infoBadge: const InfoBadge(
            source: Text('NOT SUPPORTED  '),
            color: Color(0xFF979593),
            foregroundColor: Color(0xFFFFFFFF),
          ),
          //enabled: false
        ),
      ],
    ),

    //New Arrangement made, issue: indicator not appearing
    PaneItemExpander(
      key: const ValueKey('/status'),
      icon: const Icon(FluentIcons.info),
      title: const Text('Status and Info'),
      body: const SizedBox.shrink(),
      items: [
        PaneItem(
          key: const ValueKey('/status/info_bar'),
          icon: const Icon(FluentIcons.info_solid),
          title: const Text('InfoBar'),
          body: const SizedBox.shrink(),
        ),
        PaneItem(
          key: const ValueKey('/status/progress_indicators'),
          icon: const Icon(FluentIcons.progress_ring_dots),
          title: const Text('Progress Indicators'),
          body: const SizedBox.shrink(),
        ),
        PaneItem(
          key: const ValueKey('/status/shimmer'), //need new key value?
          icon: const Icon(FluentIcons.light),
          title: const Text('Shimmer'),
          body: const SizedBox.shrink(),
          infoBadge: const InfoBadge(
            source: Text('NOT SUPPORTED  '),
            color: Color(0xFF979593),
            foregroundColor: Color(0xFFFFFFFF),
          ),
          //enabled: false
        ),
        PaneItem(
          key: const ValueKey('/status/tooltip'),
          icon: const Icon(FluentIcons.hint_text),
          title: const Text('Tooltip'),
          body: const SizedBox.shrink(),
        ),
        PaneItem(
          key: const ValueKey('/status/badge'), //need new key value?
          icon: const Icon(FluentIcons.scroll_up_down),
          title: const Text('Badge'),
          body: const SizedBox.shrink(),
          infoBadge: const InfoBadge(source: Text('NEW  ')),
        ),
      ],
    ),

    /* Moved to Surface Expander
    PaneItemHeader(header: const Text('Surfaces')),
    PaneItem(
      key: const ValueKey('/surfaces/acrylic'),
      icon: const Icon(FluentIcons.un_set_color),
      title: const Text('Acrylic'),
      body: const SizedBox.shrink(),
    ),
    */
    /* Moved to menus and toolbar expander
    PaneItem(
      key: const ValueKey('/surfaces/command_bar'),
      icon: const Icon(FluentIcons.customize_toolbar),
      title: const Text('CommandBar'),
      body: const SizedBox.shrink(),
    ),
    */
    /* Moved to Collections Expander
    PaneItem(
      key: const ValueKey('/surfaces/expander'),
      icon: const Icon(FluentIcons.expand_all),
      title: const Text('Expander'),
      body: const SizedBox.shrink(),
    ),
    */
    /* Moved to Status and Info Expander
    PaneItem(
      key: const ValueKey('/surfaces/info_bar'),
      icon: const Icon(FluentIcons.info_solid),
      title: const Text('InfoBar'),
      body: const SizedBox.shrink(),
    ),
    PaneItem(
      key: const ValueKey('/surfaces/progress_indicators'),
      icon: const Icon(FluentIcons.progress_ring_dots),
      title: const Text('Progress Indicators'),
      body: const SizedBox.shrink(),
    ),
    */
    /* Moved to Collections Expander
    PaneItem(
      key: const ValueKey('/surfaces/tiles'),
      icon: const Icon(FluentIcons.tiles),
      title: const Text('Tiles'),
      body: const SizedBox.shrink(),
    ), */
    /* Moved to Popups Expander
    PaneItemHeader(header: const Text('Popups')),
    PaneItem(
      key: const ValueKey('/popups/content_dialog'),
      icon: const Icon(FluentIcons.comment_urgent),
      title: const Text('ContentDialog'),
      body: const SizedBox.shrink(),
    ),
    PaneItem(
      key: const ValueKey('/popups/flyout'),
      icon: const Icon(FluentIcons.pop_expand),
      title: const Text('Flyout'),
      body: const SizedBox.shrink(),
    ),*/
    /* Moved to menus and toolbar expander
    PaneItem(
        key: const ValueKey('/popups/menu_bar'),
        icon: const Icon(FluentIcons.expand_menu),
        title: const Text('MenuBar'),
        body: const SizedBox.shrink(),
        infoBadge: InfoBadge(
          source: Text('NEW  '),
        )),*/
    /* Moved to Popup expander
    PaneItem(
      key: const ValueKey('/popups/teaching_tip'),
      icon: const Icon(FluentIcons.field_filled),
      title: const Text('Teaching Tip'),
      body: const SizedBox.shrink(),
    ),*/
    /* Moved to Status and Info expander
    PaneItem(
      key: const ValueKey('/popups/tooltip'),
      icon: const Icon(FluentIcons.hint_text),
      title: const Text('Tooltip'),
      body: const SizedBox.shrink(),
    ),*/
    /* Moved to the top for new arrangement
    PaneItemHeader(header: const Text('Theming')),
    PaneItem(
      key: const ValueKey('/theming/colors'),
      icon: const Icon(FluentIcons.color_solid),
      title: const Text('Colors'),
      body: const SizedBox.shrink(),
    ),
    PaneItem(
      key: const ValueKey('/theming/typography'),
      icon: const Icon(FluentIcons.font_color_a),
      title: const Text('Typography'),
      body: const SizedBox.shrink(),
    ),
    PaneItem(
      key: const ValueKey('/theming/icons'),
      icon: const Icon(FluentIcons.icon_sets_flag),
      title: const Text('Icons'),
      body: const SizedBox.shrink(),
    ),
    PaneItem(
      key: const ValueKey('/theming/reveal_focus'),
      icon: const Icon(FluentIcons.focus),
      title: const Text('Reveal Focus'),
      body: const SizedBox.shrink(),
    ),*/
    // TODO: Scrollbar, RatingBar
  ].map<NavigationPaneItem>((e) {
    PaneItem buildPaneItem(PaneItem item) {
      return PaneItem(
        key: item.key,
        icon: item.icon,
        title: item.title,
        body: item.body,
        infoBadge: item.infoBadge,
        enabled: item.enabled,
        onTap: () {
          final path = (item.key as ValueKey).value;
          if (GoRouterState.of(context).uri.toString() != path) {
            context.go(path);
          }
          item.onTap?.call();
        },
      );
    }

    if (e is PaneItemExpander) {
      return PaneItemExpander(
        key: e.key,
        icon: e.icon,
        title: e.title,
        body: e.body,
        infoBadge: e.infoBadge,
        items: e.items.map((item) {
          if (item is PaneItem) return buildPaneItem(item);
          return item;
        }).toList(),
      );
    }
    if (e is PaneItem) return buildPaneItem(e);
    return e;
  }).toList();
  late final List<NavigationPaneItem> footerItems = [
    PaneItemSeparator(),
    PaneItem(
      key: const ValueKey('/fluent_theme_builder'),
      icon: const Icon(FluentIcons.brush),
      title: const Text('Fluent Theme Builder'),
      body: const SizedBox.shrink(),
      onTap: () {
        if (GoRouterState.of(context).uri.toString() !=
            '/fluent_theme_builder') {
          context.go('/fluent_theme_builder');
        }
      },
    ),
    PaneItem(
      key: const ValueKey('/settings'),
      icon: const Icon(FluentIcons.settings),
      title: const Text('Settings'),
      body: const SizedBox.shrink(),
      onTap: () {
        if (GoRouterState.of(context).uri.toString() != '/settings') {
          context.go('/settings');
        }
      },
    ),
    _LinkPaneItemAction(
      icon: const Icon(FluentIcons.open_source),
      title: const Text('Source code'),
      link: 'https://github.com/bdlukaa/fluent_ui',
      body: const SizedBox.shrink(),
    ),
  ];

  @override
  void initState() {
    windowManager.addListener(this);
    super.initState();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    searchController.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }

  int _calculateSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    int indexOriginal = originalItems
        .where((item) => item.key != null)
        .toList()
        .indexWhere((item) => item.key == Key(location));

    if (indexOriginal == -1) {
      int indexFooter = footerItems
          .where((element) => element.key != null)
          .toList()
          .indexWhere((element) => element.key == Key(location));
      if (indexFooter == -1) {
        return 0;
      }
      return originalItems
              .where((element) => element.key != null)
              .toList()
              .length +
          indexFooter;
    } else {
      return indexOriginal;
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = FluentLocalizations.of(context);

    final appTheme = context.watch<AppTheme>();
    final theme = FluentTheme.of(context);
    if (widget.shellContext != null) {
      if (router.canPop() == false) {
        setState(() {});
      }
    }
    return NavigationView(
      key: viewKey,
      appBar: NavigationAppBar(
        automaticallyImplyLeading: false,
        leading: () {
          final enabled = widget.shellContext != null && router.canPop();

          final onPressed = enabled
              ? () {
                  if (router.canPop()) {
                    context.pop();
                    setState(() {});
                  }
                }
              : null;
          return NavigationPaneTheme(
            data: NavigationPaneTheme.of(context).merge(NavigationPaneThemeData(
              unselectedIconColor: WidgetStateProperty.resolveWith((states) {
                if (states.isDisabled) {
                  return ButtonThemeData.buttonColor(context, states);
                }
                return ButtonThemeData.uncheckedInputColor(
                  FluentTheme.of(context),
                  states,
                ).basedOnLuminance();
              }),
            )),
            child: Builder(
              builder: (context) => PaneItem(
                icon: const Center(child: Icon(FluentIcons.back, size: 12.0)),
                title: Text(localizations.backButtonTooltip),
                body: const SizedBox.shrink(),
                enabled: enabled,
              ).build(
                context,
                false,
                onPressed,
                displayMode: PaneDisplayMode.compact,
              ),
            ),
          );
        }(),
        title: () {
          if (kIsWeb) {
            return const Align(
              alignment: AlignmentDirectional.centerStart,
              child: Row(
                children: [
                  //Icon(FluentIcons.app_icon_default),
                  ImageIcon(
                    AssetImage(appIcon),
                    size: 16,
                  ),
                  SizedBox(width: 12.0),
                  Text(appTitle),
                ],
              ),
            );
          }
          return const DragToMoveArea(
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Row(
                children: [
                  //Icon(FluentIcons.app_icon_default),
                  ImageIcon(
                    AssetImage(appIcon),
                    size: 20,
                  ),
                  SizedBox(width: 12.0),
                  Text(appTitle),
                ],
              ),
            ),
          );
        }(),
        actions: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: Padding(
              padding: const EdgeInsetsDirectional.only(end: 8.0),
              child: ToggleSwitch(
                content: const Text('Dark Mode'),
                checked: FluentTheme.of(context).brightness.isDark,
                onChanged: (v) {
                  if (v) {
                    appTheme.mode = ThemeMode.dark;
                  } else {
                    appTheme.mode = ThemeMode.light;
                  }
                },
              ),
            ),
          ),
          if (!kIsWeb) const WindowButtons(),
        ]),
      ),
      paneBodyBuilder: (item, child) {
        final name =
            item?.key is ValueKey ? (item!.key as ValueKey).value : null;
        return FocusTraversalGroup(
          key: ValueKey('body$name'),
          child: widget.child,
        );
      },
      pane: NavigationPane(
        selected: _calculateSelectedIndex(context),
        /*header: SizedBox(
          height: kOneLineTileHeight,
          child: ShaderMask(
            shaderCallback: (rect) {
              final color = appTheme.color.defaultBrushFor(
                theme.brightness,
              );
              return LinearGradient(
                colors: [
                  color,
                  color,
                ],
              ).createShader(rect);
            },
            child: const FlutterLogo(
              style: FlutterLogoStyle.horizontal,
              size: 80.0,
              textColor: Colors.white,
              duration: Duration.zero,
            ),
          ),
        ),*/
        displayMode: appTheme.displayMode,
        indicator: () {
          switch (appTheme.indicator) {
            case NavigationIndicators.end:
              return const EndNavigationIndicator();
            case NavigationIndicators.sticky:
              return const StickyNavigationIndicator();
          }
        }(),
        items: originalItems,
        autoSuggestBox: Builder(builder: (context) {
          return AutoSuggestBox(
            key: searchKey,
            focusNode: searchFocusNode,
            controller: searchController,
            unfocusedColor: Colors.transparent,
            // also need to include sub items from [PaneItemExpander] items
            items: <PaneItem>[
              ...originalItems
                  .whereType<PaneItemExpander>()
                  .expand<PaneItem>((item) {
                return [
                  item,
                  ...item.items.whereType<PaneItem>(),
                ];
              }),
              ...originalItems
                  .where(
                    (item) => item is PaneItem && item is! PaneItemExpander,
                  )
                  .cast<PaneItem>(),
            ].map((item) {
              assert(item.title is Text);
              final text = (item.title as Text).data!;
              return AutoSuggestBoxItem(
                label: text,
                value: text,
                onSelected: () {
                  item.onTap?.call();
                  searchController.clear();
                  searchFocusNode.unfocus();
                  final view = NavigationView.of(context);
                  if (view.compactOverlayOpen) {
                    view.compactOverlayOpen = false;
                  } else if (view.minimalPaneOpen) {
                    view.minimalPaneOpen = false;
                  }
                },
              );
            }).toList(),
            trailingIcon: IgnorePointer(
              child: IconButton(
                onPressed: () {},
                icon: const Icon(FluentIcons.search),
              ),
            ),
            placeholder: 'Search',
          );
        }),
        autoSuggestBoxReplacement: const Icon(FluentIcons.search),
        footerItems: footerItems,
      ),
      onOpenSearch: searchFocusNode.requestFocus,
    );
  }

  @override
  void onWindowClose() async {
    bool isPreventClose = await windowManager.isPreventClose();
    if (isPreventClose && mounted) {
      showDialog(
        context: context,
        builder: (_) {
          return ContentDialog(
            title: const Text('Confirm close'),
            content: const Text('Are you sure you want to close this window?'),
            actions: [
              FilledButton(
                child: const Text('Yes'),
                onPressed: () {
                  Navigator.pop(context);
                  windowManager.destroy();
                },
              ),
              Button(
                child: const Text('No'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }
  }
}

class WindowButtons extends StatelessWidget {
  const WindowButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final FluentThemeData theme = FluentTheme.of(context);

    return SizedBox(
      width: 138,
      height: 50,
      child: WindowCaption(
        brightness: theme.brightness,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}

class _LinkPaneItemAction extends PaneItem {
  _LinkPaneItemAction({
    required super.icon,
    required this.link,
    required super.body,
    super.title,
  });

  final String link;

  @override
  Widget build(
    BuildContext context,
    bool selected,
    VoidCallback? onPressed, {
    PaneDisplayMode? displayMode,
    bool showTextOnTop = true,
    bool? autofocus,
    int? itemIndex,
  }) {
    return Link(
      uri: Uri.parse(link),
      builder: (context, followLink) => Semantics(
        link: true,
        child: super.build(
          context,
          selected,
          followLink,
          displayMode: displayMode,
          showTextOnTop: showTextOnTop,
          itemIndex: itemIndex,
          autofocus: autofocus,
        ),
      ),
    );
  }
}

final rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();
final router = GoRouter(navigatorKey: rootNavigatorKey, routes: [
  ShellRoute(
    navigatorKey: _shellNavigatorKey,
    builder: (context, state, child) {
      return MyHomePage(
        shellContext: _shellNavigatorKey.currentContext,
        child: child,
      );
    },
    routes: <GoRoute>[
      /// Home
      GoRoute(path: '/', builder: (context, state) => const HomePage()),

      /// Settings
      GoRoute(
          path: '/fluent_theme_builder',
          builder: (context, state) => const FluentThemeBuilderPage()),

      /// Settings
      GoRoute(path: '/settings', builder: (context, state) => const Settings()),

      /// /// Styles Expander
      /// Colors
      GoRoute(
        path: '/styles/colors',
        builder: (context, state) => DeferredWidget(
          styles.loadLibrary,
          () => styles.ColorsPage(),
        ),
      ),

      /// Geometry
      GoRoute(
        path: '/styles/geometry',
        builder: (context, state) => DeferredWidget(
          styles.loadLibrary,
          () => styles.GeometryPage(),
        ),
      ),

      /// Typography
      GoRoute(
        path: '/styles/typography',
        builder: (context, state) => DeferredWidget(
          styles.loadLibrary,
          () => styles.TypographyPage(),
        ),
      ),

      /// Icongraphy
      GoRoute(
        path: '/styles/icongraphy',
        builder: (context, state) => DeferredWidget(
          styles.loadLibrary,
          () => styles.IcongraphyPage(),
        ),
      ),

      /// Reveal Focus
      GoRoute(
        path: '/styles/reveal_focus',
        builder: (context, state) => DeferredWidget(
          styles.loadLibrary,
          () => styles.RevealFocusPage(),
        ),
      ),

      /// /// Layout Expander
      /// Spacing
      GoRoute(
        path: '/layout/spacing',
        builder: (context, state) => DeferredWidget(
          layout.loadLibrary,
          () => layout.SpacingPage(),
        ),
      ),

      /// Windows Size
      GoRoute(
        path: '/layout/windows_size',
        builder: (context, state) => DeferredWidget(
          layout.loadLibrary,
          () => layout.WindowsSizePage(),
        ),
      ),

      /// Hardware Consideration
      GoRoute(
        path: '/layout/hardware_consideration',
        builder: (context, state) => DeferredWidget(
          layout.loadLibrary,
          () => layout.HardwareConsiderationPage(),
        ),
      ),

      /// /// Platforms Expander
      /// Windows
      GoRoute(
        path: '/platforms/windows',
        builder: (context, state) => DeferredWidget(
          platforms.loadLibrary,
          () => platforms.WindowsPage(),
        ),
      ),

      /// Mac OS
      GoRoute(
        path: '/platforms/macos',
        builder: (context, state) => DeferredWidget(
          platforms.loadLibrary,
          () => platforms.MacOSPage(),
        ),
      ),

      /// Web
      GoRoute(
        path: '/platforms/web',
        builder: (context, state) => DeferredWidget(
          platforms.loadLibrary,
          () => platforms.WebPage(),
        ),
      ),

      /// Linux
      GoRoute(
        path: '/platforms/linux',
        builder: (context, state) => DeferredWidget(
          platforms.loadLibrary,
          () => platforms.LinuxPage(),
        ),
      ),

      /// Android
      GoRoute(
        path: '/platforms/android',
        builder: (context, state) => DeferredWidget(
          platforms.loadLibrary,
          () => platforms.AndroidPage(),
        ),
      ),

      /// Ios
      GoRoute(
        path: '/platforms/ios',
        builder: (context, state) => DeferredWidget(
          platforms.loadLibrary,
          () => platforms.IosPage(),
        ),
      ),

      /// /// Fluent App Expander
      /// Getting Started
      GoRoute(
        path: '/fluentapp/getting_started',
        builder: (context, state) => DeferredWidget(
          fluentapp.loadLibrary,
          () => fluentapp.GettingStartedPage(),
        ),
      ),

      /// Splash Screen
      GoRoute(
        path: '/fluentapp/splash_screen',
        builder: (context, state) => DeferredWidget(
          fluentapp.loadLibrary,
          () => fluentapp.SplashScreenPage(),
        ),
      ),

      /// Appbar
      GoRoute(
        path: '/fluentapp/appbar',
        builder: (context, state) => DeferredWidget(
          fluentapp.loadLibrary,
          () => fluentapp.AppBarPage(),
        ),
      ),

      /// /// Surfaces Expander
      /// Material
      GoRoute(
        path: '/surfaces/materials',
        builder: (context, state) => DeferredWidget(
          surfaces.loadLibrary,
          () => surfaces.MaterialsPage(),
        ),
      ),

      /// Carousel
      GoRoute(
        path: '/surfaces/carousel',
        builder: (context, state) => DeferredWidget(
          surfaces.loadLibrary,
          () => surfaces.CarouselPage(),
        ),
      ),

      /// Cards
      GoRoute(
        path: '/surfaces/cards',
        builder: (context, state) => DeferredWidget(
          surfaces.loadLibrary,
          () => surfaces.CardsPage(),
        ),
      ),

      /// Sheets
      GoRoute(
        path: '/surfaces/sheets',
        builder: (context, state) => DeferredWidget(
          surfaces.loadLibrary,
          () => surfaces.SheetsPage(),
        ),
      ),

      /// /// Input Expander
      /// Buttons
      GoRoute(
        path: '/inputs/buttons',
        builder: (context, state) => DeferredWidget(
          inputs.loadLibrary,
          () => inputs.ButtonPage(),
        ),
      ),

      /// Checkbox
      GoRoute(
        path: '/inputs/checkbox',
        builder: (context, state) => DeferredWidget(
          inputs.loadLibrary,
          () => inputs.CheckBoxPage(),
        ),
      ),

      /// Slider
      GoRoute(
        path: '/inputs/slider',
        builder: (context, state) => DeferredWidget(
          inputs.loadLibrary,
          () => inputs.SliderPage(),
        ),
      ),

      // Rating
      GoRoute(
        path: '/inputs/rating',
        builder: (context, state) => DeferredWidget(
          inputs.loadLibrary,
          () => inputs.RatingPage(),
        ),
      ),

      // Chips
      GoRoute(
        path: '/inputs/chips',
        builder: (context, state) => DeferredWidget(
          inputs.loadLibrary,
          () => inputs.ChipsPage(),
        ),
      ),

      /// ToggleSwitch
      GoRoute(
        path: '/inputs/toggle_switch',
        builder: (context, state) => DeferredWidget(
          inputs.loadLibrary,
          () => inputs.ToggleSwitchPage(),
        ),
      ),

      /// ColorPicker
      GoRoute(
        path: '/inputs/color_picker',
        builder: (context, state) => DeferredWidget(
          inputs.loadLibrary,
          () => inputs.ColorPickerPage(),
        ),
      ),

      /// /// Text
      /// TextBox
      GoRoute(
        path: '/text/text_box',
        builder: (context, state) => DeferredWidget(
          text.loadLibrary,
          () => text.TextBoxPage(),
        ),
      ),

      /// AutoSuggestBox
      GoRoute(
        path: '/text/auto_suggest_box',
        builder: (context, state) => DeferredWidget(
          text.loadLibrary,
          () => text.AutoSuggestBoxPage(),
        ),
      ),

      /// ComboBox
      GoRoute(
        path: '/text/combobox',
        builder: (context, state) => DeferredWidget(
          text.loadLibrary,
          () => text.ComboBoxPage(),
        ),
      ),

      /// NumberBox
      GoRoute(
        path: '/text/numberbox',
        builder: (context, state) => DeferredWidget(
          text.loadLibrary,
          () => text.NumberBoxPage(),
        ),
      ),

      GoRoute(
        path: '/text/passwordbox',
        builder: (context, state) => DeferredWidget(
          text.loadLibrary,
          () => text.PasswordBoxPage(),
        ),
      ),

      /// /// Collections
      /// Tiles
      GoRoute(
        path: '/collections/tiles',
        builder: (context, state) => DeferredWidget(
          collections.loadLibrary,
          () => collections.TilesPage(),
        ),
      ),

      /// Table
      GoRoute(
        path: '/collections/table',
        builder: (context, state) => DeferredWidget(
          collections.loadLibrary,
          () => collections.TablePage(),
        ),
      ),

      /// Tiles
      GoRoute(
        path: '/collections/grid',
        builder: (context, state) => DeferredWidget(
          collections.loadLibrary,
          () => collections.GridPage(),
        ),
      ),

      /// Tiles
      GoRoute(
        path: '/collections/flip_view',
        builder: (context, state) => DeferredWidget(
          collections.loadLibrary,
          () => collections.FlipViewPage(),
        ),
      ),

      /// Expander
      GoRoute(
        path: '/collections/expander',
        builder: (context, state) => DeferredWidget(
          collections.loadLibrary,
          () => collections.ExpanderPage(),
        ),
      ),

      /// /// Date and Time
      /// TimePicker
      GoRoute(
        path: '/datetime/time_picker',
        builder: (context, state) => DeferredWidget(
          datetime.loadLibrary,
          () => datetime.TimePickerPage(),
        ),
      ),

      /// DatePicker
      GoRoute(
        path: '/datetime/date_picker',
        builder: (context, state) => DeferredWidget(
          datetime.loadLibrary,
          () => datetime.DatePickerPage(),
        ),
      ),

      /// DatePicker
      GoRoute(
        path: '/datetime/calendar_view',
        builder: (context, state) => DeferredWidget(
          datetime.loadLibrary,
          () => datetime.CalendarViewPage(),
        ),
      ),

      /// Popups
      /// ContentDialog
      GoRoute(
        path: '/popups/content_dialog',
        builder: (context, state) => DeferredWidget(
          popups.loadLibrary,
          () => popups.ContentDialogPage(),
        ),
      ),

      /// Flyout
      GoRoute(
        path: '/popups/flyout',
        builder: (context, state) => DeferredWidget(
          popups.loadLibrary,
          () => popups.Flyout2Screen(),
        ),
      ),

      /// Teaching Tip
      GoRoute(
        path: '/popups/teaching_tip',
        builder: (context, state) => DeferredWidget(
          popups.loadLibrary,
          () => popups.TeachingTipPage(),
        ),
      ),

      /// /// Media
      /// Avatar
      GoRoute(
        path: '/media/avatar',
        builder: (context, state) => DeferredWidget(
          media.loadLibrary,
          () => media.AvatarPage(),
        ),
      ),

      /// Media Player
      GoRoute(
        path: '/media/media_player',
        builder: (context, state) => DeferredWidget(
          media.loadLibrary,
          () => media.MediaPlayerPage(),
        ),
      ),

      /// /// Toolbar
      /// MenuBar
      GoRoute(
        path: '/toolbar/menu_bar',
        builder: (context, state) => DeferredWidget(
          toolbar.loadLibrary,
          () => toolbar.MenuBarPage(),
        ),
      ),

      /// MenuBar
      GoRoute(
        path: '/toolbar/context_menu',
        builder: (context, state) => DeferredWidget(
          toolbar.loadLibrary,
          () => toolbar.ContextMenuPage(),
        ),
      ),

      /// CommandBar
      GoRoute(
        path: '/toolbar/command_bar',
        builder: (context, state) => DeferredWidget(
          toolbar.loadLibrary,
          () => toolbar.CommandBarsPage(),
        ),
      ),

      /// Ink Toolbar
      GoRoute(
        path: '/toolbar/ink_toolbar',
        builder: (context, state) => DeferredWidget(
          toolbar.loadLibrary,
          () => toolbar.InkToolbarPage(),
        ),
      ),

      /// /// Navigation
      /// NavigationView
      GoRoute(
        path: '/navigation/navigation_view',
        builder: (context, state) => DeferredWidget(
          navigation.loadLibrary,
          () => navigation.NavigationViewPage(),
        ),
      ),
      GoRoute(
        path: '/navigation_view',
        builder: (context, state) => DeferredWidget(
          navigation.loadLibrary,
          () => navigation.NavigationViewShellRoute(),
        ),
      ),

      /// TabView
      GoRoute(
        path: '/navigation/tab_view',
        builder: (context, state) => DeferredWidget(
          navigation.loadLibrary,
          () => navigation.TabViewPage(),
        ),
      ),

      /// TreeView
      GoRoute(
        path: '/navigation/tree_view',
        builder: (context, state) => DeferredWidget(
          navigation.loadLibrary,
          () => navigation.TreeViewPage(),
        ),
      ),

      /// BreadcrumbBar
      GoRoute(
        path: '/navigation/breadcrumb_bar',
        builder: (context, state) => DeferredWidget(
          navigation.loadLibrary,
          () => navigation.BreadcrumbBarPage(),
        ),
      ),

      /// /// Scrolling
      /// Scroll Bar
      GoRoute(
        path: '/scrolling/scroll_bar',
        builder: (context, state) => DeferredWidget(
          scrolling.loadLibrary,
          () => scrolling.ScrollbarPage(),
        ),
      ),

      /// Scroll Bar
      GoRoute(
        path: '/scrolling/annotated_scroll',
        builder: (context, state) => DeferredWidget(
          scrolling.loadLibrary,
          () => scrolling.AnnotatedScrollPage(),
        ),
      ),

      /// Pigs Page
      GoRoute(
        path: '/scrolling/pigs_page',
        builder: (context, state) => DeferredWidget(
          scrolling.loadLibrary,
          () => scrolling.PigsPagePage(),
        ),
      ),

      /// /// Status
      /// InfoBar
      GoRoute(
        path: '/status/info_bar',
        builder: (context, state) => DeferredWidget(
          status.loadLibrary,
          () => status.InfoBarsPage(),
        ),
      ),

      /// Progress Indicators
      GoRoute(
        path: '/status/progress_indicators',
        builder: (context, state) => DeferredWidget(
          status.loadLibrary,
          () => status.ProgressIndicatorsPage(),
        ),
      ),

      /// Tooltip
      GoRoute(
        path: '/status/shimmer',
        builder: (context, state) => DeferredWidget(
          status.loadLibrary,
          () => status.ShimmerPage(),
        ),
      ),

      /// Tooltip
      GoRoute(
        path: '/status/tooltip',
        builder: (context, state) => DeferredWidget(
          status.loadLibrary,
          () => status.TooltipPage(),
        ),
      ),

      /// Badge
      GoRoute(
        path: '/status/badge',
        builder: (context, state) => DeferredWidget(
          status.loadLibrary,
          () => status.BadgePage(),
        ),
      ),
    ],
  ),
]);
