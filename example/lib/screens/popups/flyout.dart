import 'package:example/main.dart';
import 'package:example/theme.dart';
import 'package:example/widgets/card_highlight.dart';
import 'package:example/widgets/page.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';

class Flyout2Screen extends StatefulWidget {
  const Flyout2Screen({super.key});

  @override
  State<Flyout2Screen> createState() => _Flyout2ScreenState();
}

class _Flyout2ScreenState extends State<Flyout2Screen> with PageMixin {
  final controller = FlyoutController();
  final attachKey = GlobalKey();

  final menuController = FlyoutController();
  final menuAttachKey = GlobalKey();

  final itemsController = FlyoutController();
  final itemsAttachKey = GlobalKey();

  final commandBarController = FlyoutController();
  final commandBarAttachKey = GlobalKey();

  final contextController2 = FlyoutController();
  final contextAttachKey2 = GlobalKey();

  final selectableTextController = FlyoutController();
  final selectableTextAttachKey = GlobalKey();
  final selectableTextController2 = FlyoutController();
  final selectableTextAttachKey2 = GlobalKey();

  bool barrierDismissible = true;
  bool dismissOnPointerMoveAway = false;
  bool dismissWithEsc = true;
  FlyoutPlacementMode placementMode = FlyoutPlacementMode.topCenter;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    menuController.dispose();
    commandBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    return ScaffoldPage.scrollable(
      header: const PageHeader(title: Text('Flyouts')),
      children: [
        const Text(
          'A flyout is a light dismiss container that can show arbitrary UI as '
          'its content. Flyouts can contain other flyouts or context menus to '
          'create a nested experience.',
        ),
        const SizedBox(height: 8),
        Mica(
          child: Padding(
            padding: const EdgeInsetsDirectional.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                description(content: const Text('Config')),
                const SizedBox(height: 8),
                Wrap(
                  runSpacing: 10,
                  spacing: 10,
                  children: [
                    ToggleSwitch(
                      checked: barrierDismissible,
                      onChanged: (final v) =>
                          setState(() => barrierDismissible = v),
                      content: const Text('Barrier dismissible'),
                    ),
                    ToggleSwitch(
                      checked: dismissOnPointerMoveAway,
                      onChanged: (final v) =>
                          setState(() => dismissOnPointerMoveAway = v),
                      content: const Text('Dismiss on pointer move away'),
                    ),
                    ToggleSwitch(
                      checked: dismissWithEsc,
                      onChanged: (final v) =>
                          setState(() => dismissWithEsc = v),
                      content: const Text('Dismiss with esc'),
                    ),
                    ComboBox<FlyoutPlacementMode>(
                      placeholder: const Text('Placeholder'),
                      items: FlyoutPlacementMode.values
                          .where(
                            (final mode) => mode != FlyoutPlacementMode.auto,
                          )
                          .map((final mode) {
                            return ComboBoxItem(
                              value: mode,
                              child: Text(mode.name.uppercaseFirst()),
                            );
                          })
                          .toList(),
                      value: placementMode,
                      onChanged: (final mode) {
                        if (mode != null) setState(() => placementMode = mode);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: 50),
        Text('Simple Flyout', style: FluentTheme.of(context).typography.title),
        subtitle(content: const Text('A button with a flyout')),
        CardHighlight(
          codeSnippet:
              '''FlyoutTarget(
  controller: controller,
  child: Button(
    child: const Text('Clear cart'),
    onPressed: () {
      controller.showFlyout<void>(
        autoModeConfiguration: FlyoutAutoConfiguration(
          preferredMode: $placementMode,
        ),
        barrierDismissible: $barrierDismissible,
        dismissOnPointerMoveAway: $dismissOnPointerMoveAway,
        dismissWithEsc: $dismissWithEsc,
        navigatorKey: rootNavigatorKey.currentState,
        builder: (context) {
          return FlyoutContent(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'All items will be removed. Do you want to continue?',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12.0),
                Button(
                  onPressed: Flyout.of(context).close,
                  child: const Text('Yes, empty my cart'),
                ),
              ],
            ),
          );
        },
      );
    },
  )
)''',
          child: Row(
            children: [
              FlyoutTarget(
                key: attachKey,
                controller: controller,
                child: Button(
                  child: const Text('Clear cart'),
                  onPressed: () async {
                    controller.showFlyout<void>(
                      autoModeConfiguration: FlyoutAutoConfiguration(
                        preferredMode: placementMode,
                      ),
                      barrierDismissible: barrierDismissible,
                      dismissOnPointerMoveAway: dismissOnPointerMoveAway,
                      dismissWithEsc: dismissWithEsc,
                      navigatorKey: rootNavigatorKey.currentState,
                      builder: (final context) {
                        return FlyoutContent(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'All items will be removed. Do you want to continue?',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 12),
                              Button(
                                onPressed: Flyout.of(context).close,
                                child: const Text('Yes, empty my cart'),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(width: 8),
              Text(controller.isOpen ? 'Displaying' : ''),
            ],
          ),
        ),
        subtitle(content: const Text('MenuFlyout')),
        description(
          content: const Text(
            'Menu flyouts are used in menu and context menu scenarios to '
            'display a list of commands or options when requested by the user. '
            'A menu flyout shows a single, inline, top-level menu that can '
            'have menu items and sub-menus. To show a set of multiple top-level '
            'menus in a horizontal row, use menu bar (which you typically '
            'position at the top of the app window).',
          ),
        ),
        CardHighlight(
          codeSnippet:
              '''final menuController = FlyoutController();

FlyoutTarget(
  controller: menuController,
  child: Button(
    child: const Text('Options'),
    onPressed: () {
      menuController.showFlyout<void>(
        autoModeConfiguration: FlyoutAutoConfiguration(
          preferredMode: $placementMode,
        ),
        barrierDismissible: $barrierDismissible,
        dismissOnPointerMoveAway: $dismissOnPointerMoveAway,
        dismissWithEsc: $dismissWithEsc,
        navigatorKey: rootNavigatorKey.currentState,
        builder: (context) {
          return MenuFlyout(items: [
            MenuFlyoutItem(
              leading: const WindowsIcon(WindowsIcons.share),
              text: const Text('Share'),
              onPressed: Flyout.of(context).close,
            ),
            MenuFlyoutItem(
              leading: const WindowsIcon(WindowsIcons.copy),
              text: const Text('Copy'),
              onPressed: Flyout.of(context).close,
            ),
            MenuFlyoutItem(
              leading: const WindowsIcon(WindowsIcons.delete),
              text: const Text('Delete'),
              onPressed: Flyout.of(context).close,
            ),
            const MenuFlyoutSeparator(),
            MenuFlyoutItem(
              text: const Text('Rename'),
              onPressed: Flyout.of(context).close,
            ),
            MenuFlyoutItem(
              text: const Text('Select'),
              onPressed: Flyout.of(context).close,
            ),
            const MenuFlyoutSeparator(),
            MenuFlyoutSubItem(
              text: const Text('Send to'),
              items: (_) => [
                MenuFlyoutItem(
                  text: const Text('Bluetooth'),
                  onPressed: Flyout.of(context).close,
                ),
                MenuFlyoutItem(
                  text: const Text('Desktop (shortcut)'),
                  onPressed: Flyout.of(context).close,
                ),
                MenuFlyoutSubItem(
                  text: const Text('Compressed file'),
                  items: (context) => [
                    MenuFlyoutItem(
                      text: const Text('Compress and email'),
                      onPressed: Flyout.of(context).close,
                    ),
                    MenuFlyoutItem(
                      text: const Text('Compress to .7z'),
                      onPressed: Flyout.of(context).close,
                    ),
                    MenuFlyoutItem(
                      text: const Text('Compress to .zip'),
                      onPressed: Flyout.of(context).close,
                    ),
                  ],
                ),
              ],
            ),
          ]);
        },
      );
    },
  )
)''',
          child: Row(
            children: [
              FlyoutTarget(
                key: menuAttachKey,
                controller: menuController,
                child: Button(
                  child: const Text('Options'),
                  onPressed: () {
                    menuController.showFlyout<void>(
                      autoModeConfiguration: FlyoutAutoConfiguration(
                        preferredMode: placementMode,
                      ),
                      barrierDismissible: barrierDismissible,
                      dismissOnPointerMoveAway: dismissOnPointerMoveAway,
                      dismissWithEsc: dismissWithEsc,
                      navigatorKey: rootNavigatorKey.currentState,
                      builder: (final context) {
                        return MenuFlyout(
                          items: [
                            MenuFlyoutItem(
                              leading: const WindowsIcon(WindowsIcons.share),
                              text: const Text('Share'),
                              onPressed: Flyout.of(context).close,
                            ),
                            MenuFlyoutItem(
                              leading: const WindowsIcon(WindowsIcons.copy),
                              text: const Text('Copy'),
                              onPressed: Flyout.of(context).close,
                            ),
                            MenuFlyoutItem(
                              leading: const WindowsIcon(WindowsIcons.delete),
                              text: const Text('Delete'),
                              onPressed: Flyout.of(context).close,
                            ),
                            const MenuFlyoutSeparator(),
                            MenuFlyoutItem(
                              text: const Text('Rename'),
                              onPressed: Flyout.of(context).close,
                            ),
                            MenuFlyoutItem(
                              text: const Text('Select'),
                              onPressed: null,
                            ),
                            const MenuFlyoutSeparator(),
                            MenuFlyoutSubItem(
                              text: const Text('Send to'),
                              items: (_) => [
                                MenuFlyoutItem(
                                  text: const Text('Bluetooth'),
                                  onPressed: Flyout.of(context).close,
                                ),
                                MenuFlyoutItem(
                                  text: const Text('Desktop (shortcut)'),
                                  onPressed: Flyout.of(context).close,
                                ),
                                MenuFlyoutSubItem(
                                  text: const Text('Compressed file'),
                                  items: (final context) => [
                                    MenuFlyoutItem(
                                      text: const Text('Compress and email'),
                                      onPressed: Flyout.of(context).close,
                                    ),
                                    MenuFlyoutItem(
                                      text: const Text('Compress to .7z'),
                                      onPressed: Flyout.of(context).close,
                                    ),
                                    MenuFlyoutItem(
                                      text: const Text('Compress to .zip'),
                                      onPressed: Flyout.of(context).close,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(width: 8),
              Text(menuController.isOpen ? 'Displaying' : ''),
            ],
          ),
        ),
        subtitle(content: const Text('Other Flyout Item Types')),
        description(
          content: const Text(
            'The flyout can contain other flyout items like separators, '
            'toggle and radio items.',
          ),
        ),
        CardHighlight(
          codeSnippet:
              '''final itemsController = FlyoutController();
final itemsAttachKey = GlobalKey();

FlyoutTarget(
  controller: itemsController,
  child: Button(
    child: const Text('Show options'),
    onPressed: () {
      itemsController.showFlyout<void>(
        autoModeConfiguration: FlyoutAutoConfiguration(
          preferredMode: $placementMode,
        ),
        barrierDismissible: $barrierDismissible,
        dismissOnPointerMoveAway: $dismissOnPointerMoveAway,
        dismissWithEsc: $dismissWithEsc,
        navigatorKey: rootNavigatorKey.currentState,
        builder: (context) {
          var repeat = true;
          var shuffle = false;

          var radioIndex = 1;
          return StatefulBuilder(builder: (context, setState) {
            return MenuFlyout(items: [
              MenuFlyoutItem(
                text: const Text('Reset'),
                onPressed: () {
                  setState(() {
                    repeat = false;
                    shuffle = false;
                  });
                },
              ),
              const MenuFlyoutSeparator(),
              ToggleMenuFlyoutItem(
                text: const Text('Repeat'),
                value: repeat,
                onChanged: (v) {
                  setState(() => repeat = v);
                },
              ),
              ToggleMenuFlyoutItem(
                text: const Text('Shuffle'),
                value: shuffle,
                onChanged: (v) {
                  setState(() => shuffle = v);
                },
              ),
              const MenuFlyoutSeparator(),
              ...List.generate(3, (index) {
                return RadioMenuFlyoutItem(
                  text: Text([
                    'Small icons',
                    'Medium icons',
                    'Large icons',
                  ][index]),
                  value: index,
                  groupValue: radioIndex,
                  onChanged: (v) {
                    setState(() => radioIndex = index);
                  },
                );
              }),
            ]);
          });
        },
      );
    },
  )
)
''',
          child: Row(
            children: [
              FlyoutTarget(
                key: itemsAttachKey,
                controller: itemsController,
                child: Button(
                  child: const Text('Show options'),
                  onPressed: () {
                    itemsController.showFlyout<void>(
                      autoModeConfiguration: FlyoutAutoConfiguration(
                        preferredMode: placementMode,
                      ),
                      barrierDismissible: barrierDismissible,
                      dismissOnPointerMoveAway: dismissOnPointerMoveAway,
                      dismissWithEsc: dismissWithEsc,
                      navigatorKey: rootNavigatorKey.currentState,
                      builder: (final context) {
                        var repeat = true;
                        var shuffle = false;

                        var radioIndex = 1;
                        return StatefulBuilder(
                          builder: (final context, final setState) {
                            return MenuFlyout(
                              items: [
                                MenuFlyoutItem(
                                  text: const Text('Reset'),
                                  onPressed: () {
                                    setState(() {
                                      repeat = false;
                                      shuffle = false;
                                    });
                                  },
                                ),
                                const MenuFlyoutSeparator(),
                                ToggleMenuFlyoutItem(
                                  text: const Text('Repeat'),
                                  value: repeat,
                                  onChanged: (final v) {
                                    setState(() => repeat = v);
                                  },
                                ),
                                ToggleMenuFlyoutItem(
                                  text: const Text('Shuffle'),
                                  value: shuffle,
                                  onChanged: (final v) {
                                    setState(() => shuffle = v);
                                  },
                                ),
                                const MenuFlyoutSeparator(),
                                ...List.generate(3, (final index) {
                                  return RadioMenuFlyoutItem(
                                    text: Text(
                                      [
                                        'Small icons',
                                        'Medium icons',
                                        'Large icons',
                                      ][index],
                                    ),
                                    value: index,
                                    groupValue: radioIndex,
                                    onChanged: (final v) {
                                      setState(() => radioIndex = index);
                                    },
                                  );
                                }),
                              ],
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(width: 8),
              Text(menuController.isOpen ? 'Displaying' : ''),
            ],
          ),
        ),

        //subtitle(content: const Text('Context Menus')),
        SizedBox(height: 30),
        Text('Commandbar', style: FluentTheme.of(context).typography.title),
        description(
          content: const Text(
            'The command bar flyout lets you provide users with easy access '
            'to common tasks by showing commands in a floating toolbar related '
            'to an element on your UI canvas. Use your right mouse button to '
            'open the context menu.',
          ),
        ),
        GestureDetector(
            onSecondaryTapUp: (final d) {
              final targetContext = contextAttachKey2
                  .currentContext; // Use a new key for the second widget
              if (targetContext == null) return;

              final box = targetContext.findRenderObject()! as RenderBox;
              final position = box.localToGlobal(
                d.localPosition,
                ancestor: Navigator.of(context).context.findRenderObject(),
              );

              void showFlyout(final Offset position) {
                commandBarController.showFlyout<void>(
                  barrierColor: Colors.black.withValues(alpha: 0.1),
                  position: position,
                  barrierRecognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.of(context).pop();
                    }
                    ..onSecondaryTapUp = (final d) {
                      Navigator.of(context).pop();

                      final box =
                          Navigator.of(context).context.findRenderObject()!
                              as RenderBox;
                      final position = box.localToGlobal(
                        d.localPosition,
                        ancestor: box,
                      );

                      showFlyout(position);
                    },
                  builder: (final context) {
                    return MenuFlyout(
                      constraints: BoxConstraints(minWidth: 250),
                      items: [
                        MenuFlyoutItemBuilder(
                          builder: (context) {
                            return CommandBar(
                              overflowBehavior:
                                  CommandBarOverflowBehavior.scrolling,
                              isCompact: true,
                              primaryItems: [
                                CommandBarButton(
                                  icon: const WindowsIcon(WindowsIcons.cut),
                                  label: const Text('Cut'),
                                  onPressed: Flyout.of(context).close,
                                ),
                                CommandBarButton(
                                  icon: const WindowsIcon(WindowsIcons.copy),
                                  label: const Text('Copy'),
                                  onPressed: Flyout.of(context).close,
                                ),
                                CommandBarButton(
                                  icon: const WindowsIcon(WindowsIcons.paste),
                                  label: const Text('Paste'),
                                  onPressed: Flyout.of(context).close,
                                ),
                                CommandBarButton(
                                  icon: const WindowsIcon(WindowsIcons.rename),
                                  label: const Text('Rename'),
                                  onPressed: Flyout.of(context).close,
                                ),
                                CommandBarButton(
                                  icon: const WindowsIcon(WindowsIcons.delete),
                                  label: const Text('Delete'),
                                  onPressed: Flyout.of(context).close,
                                ),
                              ],
                            );
                          },
                        ),
                        MenuFlyoutSeparator(),
                        MenuFlyoutSubItem(
                          leading: const WindowsIcon(WindowsIcons.open_file),
                          text: const Text('Open'),
                          items: (context) => [
                            MenuFlyoutItem(
                              leading: const WindowsIcon(
                                WindowsIcons.open_file,
                              ),
                              text: const Text('Open File'),
                              onPressed: Flyout.of(context).close,
                            ),
                            MenuFlyoutItem(
                              leading: const WindowsIcon(WindowsIcons.favicon2),
                              text: const Text('Open in new tab'),
                              onPressed: Flyout.of(context).close,
                            ),
                            MenuFlyoutItem(
                              leading: const WindowsIcon(
                                WindowsIcons.open_in_new_window,
                              ),
                              text: const Text('Open in new windows'),
                              onPressed: Flyout.of(context).close,
                            ),
                            MenuFlyoutItem(
                              leading: const WindowsIcon(
                                WindowsIcons.open_with,
                              ),
                              text: const Text('Open with other apps'),
                              onPressed: Flyout.of(context).close,
                            ),
                          ],
                        ),
                        MenuFlyoutSubItem(
                          leading: const WindowsIcon(WindowsIcons.clickto_do),
                          text: const Text('AI actions'),
                          items: (context) => [
                            MenuFlyoutItem(
                              text: const Text('Action 1'),
                              onPressed: Flyout.of(context).close,
                            ),
                            MenuFlyoutItem(
                              text: const Text('Action 2'),
                              onPressed: Flyout.of(context).close,
                            ),
                            MenuFlyoutItem(
                              text: const Text('Action 3'),
                              onPressed: Flyout.of(context).close,
                            ),
                            MenuFlyoutItem(
                              text: const Text('Action 4'),
                              onPressed: Flyout.of(context).close,
                            ),
                          ],
                        ),
                        MenuFlyoutItem(
                          leading: const WindowsIcon(WindowsIcons.print),
                          text: const Text('Print'),
                          onPressed: Flyout.of(context).close,
                        ),
                        const MenuFlyoutSeparator(),

                        MenuFlyoutSubItem(
                          leading: const WindowsIcon(WindowsIcons.select_all),
                          text: const Text('Select'),
                          items: (context) => [
                            MenuFlyoutItem(
                              leading: const WindowsIcon(WindowsIcons.select_all),
                              text: const Text('Select All'),
                              onPressed: Flyout.of(context).close,
                            ),
                            MenuFlyoutItem(
                              leading: const WindowsIcon(WindowsIcons.multi_select),
                              text: const Text('Invert Selection'),
                              onPressed: Flyout.of(context).close,
                            ),
                            MenuFlyoutItem(
                              leading: const WindowsIcon(WindowsIcons.clear_selection),
                              text: const Text('Select None'),
                              onPressed: Flyout.of(context).close,
                            ),
                          ],
                        ),
                        MenuFlyoutSubItem(
                          leading: const WindowsIcon(WindowsIcons.view),
                          text: const Text('View'),
                          items: (context) => [
                            MenuFlyoutItem(
                              leading: const WindowsIcon(
                                WindowsIcons.grid_view,
                              ),
                              text: const Text('Grid View'),
                              onPressed: Flyout.of(context).close,
                            ),
                            MenuFlyoutItem(
                              leading: const WindowsIcon(
                                WindowsIcons.list,
                              ),
                              text: const Text('List View'),
                              onPressed: Flyout.of(context).close,
                            ),
                          ],
                        ),
                        MenuFlyoutSubItem(
                          leading: const WindowsIcon(WindowsIcons.sort),
                          text: const Text('Sort'),
                          items: (context) => [
                            MenuFlyoutItem(
                              leading: const WindowsIcon(
                                WindowsIcons.clickto_do,
                              ),
                              text: const Text('AI actions'),
                              onPressed: Flyout.of(context).close,
                            ),
                            MenuFlyoutItem(
                              leading: const WindowsIcon(
                                WindowsIcons.clickto_do,
                              ),
                              text: const Text('AI actions'),
                              onPressed: Flyout.of(context).close,
                            ),
                            MenuFlyoutItem(
                              leading: const WindowsIcon(
                                WindowsIcons.clickto_do,
                              ),
                              text: const Text('AI actions'),
                              onPressed: Flyout.of(context).close,
                            ),
                            MenuFlyoutItem(
                              leading: const WindowsIcon(
                                WindowsIcons.clickto_do,
                              ),
                              text: const Text('AI actions'),
                              onPressed: Flyout.of(context).close,
                            ),
                          ],
                        ),

                        const MenuFlyoutSeparator(),
                        MenuFlyoutItem(
                          leading: const WindowsIcon(WindowsIcons.pin),
                          text: const Text('Pin/Unpin'),
                          onPressed: Flyout.of(context).close,
                        ),
                        MenuFlyoutItem(
                          leading: const WindowsIcon(
                            WindowsIcons.favorite_star,
                          ),
                          text: const Text('Favourite'),
                          onPressed: Flyout.of(context).close,
                        ),
                        MenuFlyoutSeparator(),
                        MenuFlyoutSubItem(
                          leading: WindowsIcon(WindowsIcons.send),
                          text: const Text('Send to'),
                          items: (_) => [
                            MenuFlyoutItem(
                              text: const Text('Bluetooth'),
                              onPressed: Flyout.of(context).close,
                            ),
                            MenuFlyoutItem(
                              text: const Text('Desktop (shortcut)'),
                              onPressed: Flyout.of(context).close,
                            ),
                            MenuFlyoutSubItem(
                              text: const Text('Compressed file'),
                              items: (context) => [
                                MenuFlyoutItem(
                                  text: const Text('Compress and email'),
                                  onPressed: Flyout.of(context).close,
                                ),
                                MenuFlyoutItem(
                                  text: const Text('Compress to .7z'),
                                  onPressed: Flyout.of(context).close,
                                ),
                                MenuFlyoutItem(
                                  text: const Text('Compress to .zip'),
                                  onPressed: Flyout.of(context).close,
                                ),
                              ],
                            ),
                          ],
                        ),
                        MenuFlyoutItem(
                          leading: const WindowsIcon(WindowsIcons.share),
                          text: const Text('Share'),
                          onPressed: Flyout.of(context).close,
                        ),
                        MenuFlyoutItem(
                          leading: const WindowsIcon(
                            WindowsIcons.contact,
                          ),
                          text: const Text('Manage Access'),
                          onPressed: Flyout.of(context).close,
                        ),
                        MenuFlyoutItem(
                          leading: const WindowsIcon(WindowsIcons.link),
                          text: const Text('Create Shortcut'),
                          onPressed: Flyout.of(context).close,
                        ),

                        const MenuFlyoutSeparator(),
                        MenuFlyoutItem(
                          leading: const WindowsIcon(WindowsIcons.info),
                          text: const Text('Properties'),
                          onPressed: Flyout.of(context).close,
                        ),
                      ],
                    );
                  },
                );
              }

              showFlyout(position);
            },
            child: FlyoutTarget(
              controller: selectableTextController,
              key: selectableTextAttachKey,
              child: SelectableText('table',)
              ),
          ),
        CardHighlight(
          codeSnippet: '''''',
          child: GestureDetector(
            onSecondaryTapUp: (final d) {
              final targetContext = commandBarAttachKey.currentContext;
              if (targetContext == null) return;

              final box = targetContext.findRenderObject()! as RenderBox;
              final position = box.localToGlobal(
                d.localPosition,
                ancestor: Navigator.of(context).context.findRenderObject(),
              );

              void showFlyout(final Offset position) {
                commandBarController.showFlyout<void>(
                  barrierColor: Colors.black.withValues(alpha: 0.1),
                  position: position,
                  barrierRecognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.of(context).pop();
                    }
                    ..onSecondaryTapUp = (final d) {
                      Navigator.of(context).pop();

                      final box =
                          Navigator.of(context).context.findRenderObject()!
                              as RenderBox;
                      final position = box.localToGlobal(
                        d.localPosition,
                        ancestor: box,
                      );

                      showFlyout(position);
                    },
                  builder: (final context) {
                    return FlyoutContent(
                      child: SizedBox(
                        width: 130,
                        child: CommandBar(
                          isCompact: true,
                          primaryItems: [
                            CommandBarButton(
                              icon: const WindowsIcon(
                                WindowsIcons.favorite_star,
                              ),
                              label: const Text('Favorite'),
                              onPressed: () {},
                            ),
                            CommandBarButton(
                              icon: const WindowsIcon(WindowsIcons.copy),
                              label: const Text('Copy'),
                              onPressed: () {},
                            ),
                            CommandBarButton(
                              icon: const WindowsIcon(WindowsIcons.share),
                              label: const Text('Share'),
                              onPressed: () {},
                            ),
                            CommandBarButton(
                              icon: const WindowsIcon(WindowsIcons.save),
                              label: const Text('Save'),
                              onPressed: () {},
                            ),
                            CommandBarButton(
                              icon: const WindowsIcon(WindowsIcons.delete),
                              label: const Text('Delete'),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }

              showFlyout(position);
            },
            child: SizedBox(
              // Add a SizedBox to constrain the size
              width: 400, // Set a width value
              height: 400, // Set a height value
              child: FlyoutTarget(
                key: commandBarAttachKey,
                controller: commandBarController,
                child: ShaderMask(
                  shaderCallback: (final rect) {
                    final color = context
                        .read<AppTheme>()
                        .color
                        .defaultBrushFor(FluentTheme.of(context).brightness);
                    return LinearGradient(
                      colors: [color, color],
                    ).createShader(rect);
                  },
                  child: const FlutterLogo(size: 400),
                ),
              ),
            ),
          ),
        ),

        SizedBox(height: 50),
        Text('Context Menu', style: FluentTheme.of(context).typography.title),
        CardHighlight(
          codeSnippet: '''''',
          child: GestureDetector(
            onSecondaryTapUp: (final d) {
              final targetContext = contextAttachKey2
                  .currentContext; // Use a new key for the second widget
              if (targetContext == null) return;

              final box = targetContext.findRenderObject()! as RenderBox;
              final position = box.localToGlobal(
                d.localPosition,
                ancestor: Navigator.of(context).context.findRenderObject(),
              );

              void showFlyout(final Offset position) {
                commandBarController.showFlyout<void>(
                  barrierColor: Colors.black.withValues(alpha: 0.1),
                  position: position,
                  barrierRecognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.of(context).pop();
                    }
                    ..onSecondaryTapUp = (final d) {
                      Navigator.of(context).pop();

                      final box =
                          Navigator.of(context).context.findRenderObject()!
                              as RenderBox;
                      final position = box.localToGlobal(
                        d.localPosition,
                        ancestor: box,
                      );

                      showFlyout(position);
                    },
                  builder: (final context) {
                    return MenuFlyout(
                      constraints: BoxConstraints(minWidth: 250),
                      items: [
                        MenuFlyoutItemBuilder(
                          builder: (context) {
                            return CommandBar(
                              overflowBehavior:
                                  CommandBarOverflowBehavior.scrolling,
                              isCompact: true,
                              primaryItems: [
                                CommandBarButton(
                                  icon: const WindowsIcon(WindowsIcons.cut),
                                  label: const Text('Cut'),
                                  onPressed: Flyout.of(context).close,
                                ),
                                CommandBarButton(
                                  icon: const WindowsIcon(WindowsIcons.copy),
                                  label: const Text('Copy'),
                                  onPressed: Flyout.of(context).close,
                                ),
                                CommandBarButton(
                                  icon: const WindowsIcon(WindowsIcons.paste),
                                  label: const Text('Paste'),
                                  onPressed: Flyout.of(context).close,
                                ),
                                CommandBarButton(
                                  icon: const WindowsIcon(WindowsIcons.rename),
                                  label: const Text('Rename'),
                                  onPressed: Flyout.of(context).close,
                                ),
                                CommandBarButton(
                                  icon: const WindowsIcon(WindowsIcons.delete),
                                  label: const Text('Delete'),
                                  onPressed: Flyout.of(context).close,
                                ),
                              ],
                            );
                          },
                        ),
                        MenuFlyoutSeparator(),
                        MenuFlyoutSubItem(
                          leading: const WindowsIcon(WindowsIcons.open_file),
                          text: const Text('Open'),
                          items: (context) => [
                            MenuFlyoutItem(
                              leading: const WindowsIcon(
                                WindowsIcons.open_file,
                              ),
                              text: const Text('Open File'),
                              onPressed: Flyout.of(context).close,
                            ),
                            MenuFlyoutItem(
                              leading: const WindowsIcon(WindowsIcons.favicon2),
                              text: const Text('Open in new tab'),
                              onPressed: Flyout.of(context).close,
                            ),
                            MenuFlyoutItem(
                              leading: const WindowsIcon(
                                WindowsIcons.open_in_new_window,
                              ),
                              text: const Text('Open in new windows'),
                              onPressed: Flyout.of(context).close,
                            ),
                            MenuFlyoutItem(
                              leading: const WindowsIcon(
                                WindowsIcons.open_with,
                              ),
                              text: const Text('Open with other apps'),
                              onPressed: Flyout.of(context).close,
                            ),
                          ],
                        ),
                        MenuFlyoutSubItem(
                          leading: const WindowsIcon(WindowsIcons.clickto_do),
                          text: const Text('AI actions'),
                          items: (context) => [
                            MenuFlyoutItem(
                              text: const Text('Action 1'),
                              onPressed: Flyout.of(context).close,
                            ),
                            MenuFlyoutItem(
                              text: const Text('Action 2'),
                              onPressed: Flyout.of(context).close,
                            ),
                            MenuFlyoutItem(
                              text: const Text('Action 3'),
                              onPressed: Flyout.of(context).close,
                            ),
                            MenuFlyoutItem(
                              text: const Text('Action 4'),
                              onPressed: Flyout.of(context).close,
                            ),
                          ],
                        ),
                        MenuFlyoutItem(
                          leading: const WindowsIcon(WindowsIcons.print),
                          text: const Text('Print'),
                          onPressed: Flyout.of(context).close,
                        ),
                        const MenuFlyoutSeparator(),

                        MenuFlyoutSubItem(
                          leading: const WindowsIcon(WindowsIcons.select_all),
                          text: const Text('Select'),
                          items: (context) => [
                            MenuFlyoutItem(
                              leading: const WindowsIcon(WindowsIcons.select_all),
                              text: const Text('Select All'),
                              onPressed: Flyout.of(context).close,
                            ),
                            MenuFlyoutItem(
                              leading: const WindowsIcon(WindowsIcons.multi_select),
                              text: const Text('Invert Selection'),
                              onPressed: Flyout.of(context).close,
                            ),
                            MenuFlyoutItem(
                              leading: const WindowsIcon(WindowsIcons.clear_selection),
                              text: const Text('Select None'),
                              onPressed: Flyout.of(context).close,
                            ),
                          ],
                        ),
                        MenuFlyoutSubItem(
                          leading: const WindowsIcon(WindowsIcons.view),
                          text: const Text('View'),
                          items: (context) => [
                            MenuFlyoutItem(
                              leading: const WindowsIcon(
                                WindowsIcons.grid_view,
                              ),
                              text: const Text('Grid View'),
                              onPressed: Flyout.of(context).close,
                            ),
                            MenuFlyoutItem(
                              leading: const WindowsIcon(
                                WindowsIcons.list,
                              ),
                              text: const Text('List View'),
                              onPressed: Flyout.of(context).close,
                            ),
                          ],
                        ),
                        MenuFlyoutSubItem(
                          leading: const WindowsIcon(WindowsIcons.sort),
                          text: const Text('Sort'),
                          items: (context) => [
                            MenuFlyoutItem(
                              leading: const WindowsIcon(
                                WindowsIcons.clickto_do,
                              ),
                              text: const Text('AI actions'),
                              onPressed: Flyout.of(context).close,
                            ),
                            MenuFlyoutItem(
                              leading: const WindowsIcon(
                                WindowsIcons.clickto_do,
                              ),
                              text: const Text('AI actions'),
                              onPressed: Flyout.of(context).close,
                            ),
                            MenuFlyoutItem(
                              leading: const WindowsIcon(
                                WindowsIcons.clickto_do,
                              ),
                              text: const Text('AI actions'),
                              onPressed: Flyout.of(context).close,
                            ),
                            MenuFlyoutItem(
                              leading: const WindowsIcon(
                                WindowsIcons.clickto_do,
                              ),
                              text: const Text('AI actions'),
                              onPressed: Flyout.of(context).close,
                            ),
                          ],
                        ),

                        const MenuFlyoutSeparator(),
                        MenuFlyoutItem(
                          leading: const WindowsIcon(WindowsIcons.pin),
                          text: const Text('Pin/Unpin'),
                          onPressed: Flyout.of(context).close,
                        ),
                        MenuFlyoutItem(
                          leading: const WindowsIcon(
                            WindowsIcons.favorite_star,
                          ),
                          text: const Text('Favourite'),
                          onPressed: Flyout.of(context).close,
                        ),
                        MenuFlyoutSeparator(),
                        MenuFlyoutSubItem(
                          leading: WindowsIcon(WindowsIcons.send),
                          text: const Text('Send to'),
                          items: (_) => [
                            MenuFlyoutItem(
                              text: const Text('Bluetooth'),
                              onPressed: Flyout.of(context).close,
                            ),
                            MenuFlyoutItem(
                              text: const Text('Desktop (shortcut)'),
                              onPressed: Flyout.of(context).close,
                            ),
                            MenuFlyoutSubItem(
                              text: const Text('Compressed file'),
                              items: (context) => [
                                MenuFlyoutItem(
                                  text: const Text('Compress and email'),
                                  onPressed: Flyout.of(context).close,
                                ),
                                MenuFlyoutItem(
                                  text: const Text('Compress to .7z'),
                                  onPressed: Flyout.of(context).close,
                                ),
                                MenuFlyoutItem(
                                  text: const Text('Compress to .zip'),
                                  onPressed: Flyout.of(context).close,
                                ),
                              ],
                            ),
                          ],
                        ),
                        MenuFlyoutItem(
                          leading: const WindowsIcon(WindowsIcons.share),
                          text: const Text('Share'),
                          onPressed: Flyout.of(context).close,
                        ),
                        MenuFlyoutItem(
                          leading: const WindowsIcon(
                            WindowsIcons.contact,
                          ),
                          text: const Text('Manage Access'),
                          onPressed: Flyout.of(context).close,
                        ),
                        MenuFlyoutItem(
                          leading: const WindowsIcon(WindowsIcons.link),
                          text: const Text('Create Shortcut'),
                          onPressed: Flyout.of(context).close,
                        ),

                        const MenuFlyoutSeparator(),
                        MenuFlyoutItem(
                          leading: const WindowsIcon(WindowsIcons.info),
                          text: const Text('Properties'),
                          onPressed: Flyout.of(context).close,
                        ),
                      ],
                    );
                  },
                );
              }

              showFlyout(position);
            },
            child: SizedBox(
              // Add a SizedBox here as well
              width: 400, // Set a width value
              height: 400, // Set a height value
              child: FlyoutTarget(
                key: contextAttachKey2, // Use the new key here
                controller: contextController2,
                child: ShaderMask(
                  shaderCallback: (final rect) {
                    final color = context
                        .read<AppTheme>()
                        .color
                        .defaultBrushFor(FluentTheme.of(context).brightness);
                    return LinearGradient(
                      colors: [color, color],
                    ).createShader(rect);
                  },
                  child: const FlutterLogo(size: 400),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
