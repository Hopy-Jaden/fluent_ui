import 'package:example/widgets/card_highlight.dart';
import 'package:fluent_ui/fluent_ui.dart';

import '../../../widgets/page.dart';

class ShimmerPage extends StatefulWidget {
  const ShimmerPage({super.key});

  @override
  State<ShimmerPage> createState() => _ShimmerPageState();
}

class _ShimmerPageState extends State<ShimmerPage> with PageMixin {
  static const double itemHeight = 500;
  bool selected = true;
  String? comboboxValue;

  int topIndex = 0;

  PaneDisplayMode displayMode = PaneDisplayMode.expanded;
  String pageTransition = 'Default';

  String indicator = 'Sticky';
  bool hasTopBar = true;
  bool isLoaded = true;
  bool isFollowed = false;

  List<NavigationPaneItem> items = [];

  @override
  Widget build(final BuildContext context) {
    return ScaffoldPage.scrollable(
      header: const PageHeader(title: Text('Shimmer')),
      children: [
        const Text(
          'A Shimmer control can be used to indicate something is loading, introduced in the windows community toolkit gallery. ',
        ),
        const SizedBox(height: 30),
        CardHighlight(
          initiallyOpen: false,
          codeSnippet: '''
class ShimmerLoading extends StatefulWidget {
  const ShimmerLoading({
    Key? key,
    required this.isLoading,
    required this.child,
  }) : super(key: key);

  final bool isLoading;
  final Widget child;

  @override
  State<ShimmerLoading> createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading> {
  Listenable? _shimmerChanges;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_shimmerChanges != null) {
      _shimmerChanges!.removeListener(_onShimmerChange);
    }
    _shimmerChanges = Shimmer.of(context)?.shimmerChanges;
    if (_shimmerChanges != null) {
      _shimmerChanges!.addListener(_onShimmerChange);
    }
  }

  @override
  void dispose() {
    _shimmerChanges?.removeListener(_onShimmerChange);
    super.dispose();
  }

  void _onShimmerChange() {
    if (widget.isLoading) {
      setState(() {
        // Update the shimmer painting.
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isLoading) {
      return widget.child;
    }

    final shimmer = Shimmer.of(context)!;
    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (bounds) {
        return shimmer.gradient.createShader(bounds);
      },
      child: widget.child,
    );
  }
}
''',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Wrap(
                children: [
                  SizedBox(
                    //height: itemHeight*0.7,
                    //width: itemHeight*0.6,
                    child: Shimmer(
                      //linearGradient: _shimmerGradient,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              ShimmerItems(
                                isLoading: isLoaded,
                                child: Avatar(
                                  size: 100,
                                  name: isLoaded ? '' : 'John Doe',
                                  autoTextSize: true,
                                ),
                              ),
                              SizedBox(height: 20),
                              ShimmerItems(
                                isLoading: isLoaded,
                                child: isLoaded
                                    ? Card(child: SizedBox(width: 100))
                                    : Text(
                                        'John Doe',
                                        style: FluentTheme.of(
                                          context,
                                        ).typography.bodyStrong,
                                      ),
                              ),
                              SizedBox(height: 10),
                              ShimmerItems(
                                isLoading: isLoaded,
                                child: isLoaded
                                    ? Card(
                                        child: SizedBox(width: 150, height: 11),
                                      )
                                    : Text('A professional programmer.'),
                              ),
                              SizedBox(height: 20),
                              ShimmerItems(
                                isLoading: isLoaded,
                                child: isLoaded
                                    ? Card(
                                        child: SizedBox(height: 11, width: 60),
                                      )
                                    : ToggleButton(
                                        child: isFollowed
                                            ? Row(
                                                children: [
                                                  Icon(FluentIcons.accept),
                                                  SizedBox(width: 4),
                                                  Text('Followed'),
                                                ],
                                              )
                                            : Text('Follow'),
                                        checked: isFollowed,
                                        onChanged: (bool value) => setState(() {
                                          isFollowed = value;
                                        }),
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              InfoLabel(
                label: 'Is Loading',
                child: ToggleSwitch(
                  checked: isLoaded,
                  onChanged: (bool value) => setState(() {
                    isLoaded = value;
                  }),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

const _shimmerGradient = LinearGradient(
  colors: [
    const Color(0xFF202020),
    const Color(0xFF2c2c2c),
    const Color(0xFF202020),
  ],
  //colors: [Color(0xFFEBEBF4), Color(0xFFF4F4F4), Color(0xFFEBEBF4)],
  //colors: [FluentTheme.of(context).resources.solidBackgroundFillColorBase, FluentTheme.of(context).resources.solidBackgroundFillColorQuarternary, FluentTheme.of(context).resources.solidBackgroundFillColorBase]
  stops: [0.1, 0.3, 0.4],
  begin: Alignment(-1.0, -0.0),
  end: Alignment(1.0, 0.0),
  tileMode: TileMode.clamp,
);
