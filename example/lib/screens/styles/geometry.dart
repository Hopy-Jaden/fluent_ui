import 'package:example/screens/settings.dart';
import 'package:example/widgets/card_highlight.dart';
import 'package:example/widgets/page.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:url_launcher/link.dart';

class GeometryPage extends StatefulWidget {
  const GeometryPage({super.key});

  @override
  State<GeometryPage> createState() => _GeometryPageState();
}

class _GeometryPageState extends State<GeometryPage> with PageMixin {
  bool firstChecked = false;
  bool firstDisabled = false;
  bool? secondChecked = false;
  bool secondDisabled = false;
  bool iconDisabled = false;

  final controller = FlyoutController();
  final rootNavigatorKey = GlobalKey<NavigatorState>();

  Color selectedColor = Colors.blue;
  ColorSpectrumShape spectrumShape = ColorSpectrumShape.box;

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      header: PageHeader(
        title: Text('Geometry'),
        commandBar: Link(
          // from the url_launcher package
          uri: Uri.parse('https://fluent2.microsoft.design/shapes'),
          builder: (Context, open) {
            return Button(
              child: Text('Documentation'),
              onPressed: open,
            );
          },
        ),
      ),
      children: [
        const Text(
          'Geometry describes the shape, size and position of UI elements on screen. These fundamental design elements help experiences feel coherent across the entire design system. Progressively rounded corners, nested elements, and consistent gutters combine to create a soft, calm, and approachable effect that emphasizes unity of purpose and ease of use.',
        ),
        CardHighlight(
          child: Stack(
            children: [
              Image.network(
                'https://learn.microsoft.com/en-us/windows/apps/design/signature-experiences/images/geometry_rounded_corners_1880.png',
                width: double.infinity / 2,
              ),
              FlyoutTarget(
                  controller: controller,
                  child: SizedBox(
                    width: 12,
                    child: Button(
                      child: const Icon(
                        FluentIcons.info,
                        size: 12,
                      ),
                      onPressed: () {
                        controller.showFlyout(
                          autoModeConfiguration: FlyoutAutoConfiguration(
                            preferredMode: FlyoutPlacementMode.topCenter,
                          ),
                          barrierDismissible: true,
                          dismissOnPointerMoveAway: false,
                          dismissWithEsc: true,
                          navigatorKey: rootNavigatorKey.currentState,
                          barrierColor: Colors.transparent,
                          builder: (context) {
                            //if (context.hasData){
                            return TeachingTip(
                              title: const Text('8px'),
                              subtitle: const Text('OverlayCornerRadius'),
                            );
                            //} else {
                            //return Text("Loading"); // whatever you want here
                            //}
                          },
                        );
                      },
                    ),
                  )),
              FlyoutTarget(
                  controller: controller,
                  child: SizedBox(
                    width: 12,
                    height: 12,
                    child: Button(
                      child: const Icon(
                        FluentIcons.info,
                        size: 12,
                      ),
                      onPressed: () {
                        controller.showFlyout(
                          autoModeConfiguration: FlyoutAutoConfiguration(
                            preferredMode: FlyoutPlacementMode.topCenter,
                          ),
                          barrierDismissible: true,
                          dismissOnPointerMoveAway: false,
                          dismissWithEsc: true,
                          navigatorKey: rootNavigatorKey.currentState,
                          barrierColor: Colors.transparent,
                          builder: (context) {
                            //if (context.hasData){
                            return TeachingTip(
                              title: const Text('0px'),
                              subtitle: Container(),
                            );
                            //} else {
                            //return Text("Loading"); // whatever you want here
                            //}
                          },
                        );
                      },
                    ),
                  )),
              FlyoutTarget(
                  controller: controller,
                  child: SizedBox(
                    width: 12,
                    child: GestureDetector(
                      child: const Icon(
                        FluentIcons.info,
                        size: 12,
                      ),
                      onTap: () {
                        controller.showFlyout(
                          autoModeConfiguration: FlyoutAutoConfiguration(
                            preferredMode: FlyoutPlacementMode.topCenter,
                          ),
                          barrierDismissible: true,
                          dismissOnPointerMoveAway: false,
                          dismissWithEsc: true,
                          navigatorKey: rootNavigatorKey.currentState,
                          barrierColor: Colors.transparent,
                          builder: (context) {
                            //if (context.hasData){
                            return TeachingTip(
                              title: const Text('4px'),
                              subtitle: const Text('ControlCornerRadius'),
                            );
                            //} else {
                            //return Text("Loading"); // whatever you want here
                            //}
                          },
                        );
                      },
                    ),
                  )),
            ],
          ),
        ),
        SizedBox(height: 10),
        CardHighlight(
          child: Image.network(
            'https://fluent2.microsoft.design/_image?href=https%3A%2F%2Ffluent2websitecdn.azureedge.net%2Fcdn%2Fdesignlanguage-shapes-cornerradius-01.Bhn65Gvq.webp&f=webp',
            width: double.infinity / 2,
          ),
        )
      ],
    );
  }
}
