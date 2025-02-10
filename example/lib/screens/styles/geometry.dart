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
        FlyoutTarget(
            controller: controller,
            child: IconButton(
              icon: const Icon(
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
                  builder: (context) {
                    return FlyoutContent(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ColorPicker(
                            color: selectedColor,
                            onChanged: (color) =>
                                setState(() => selectedColor = color),
                            colorSpectrumShape: spectrumShape,
                            isMoreButtonVisible: true,
                            isColorSliderVisible: true,
                            isColorChannelTextInputVisible: true,
                            isHexInputVisible: true,
                            isAlphaEnabled: false,
                          ),
                          const SizedBox(height: 12.0),
                          Button(
                            onPressed: Flyout.of(context).close,
                            child: const Text('Done'),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ))
      ],
    );
  }
}
