import 'package:fluent_ui/fluent_ui.dart';

//ShimmerLoading wrap child with Shader mask
class ShimmerItems extends StatefulWidget {
  const ShimmerItems({super.key, required this.isLoading, required this.child});

  final bool isLoading;
  final Widget child;

  @override
  State<ShimmerItems> createState() => _ShimmerItemsState();
}

class _ShimmerItemsState extends State<ShimmerItems> {
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

    // Collect ancestor shimmer information.
    final shimmer = Shimmer.of(context)!;
    if (!shimmer.isSized) {
      // The ancestor Shimmer widget isn't laid
      // out yet. Return an empty box.
      return const SizedBox();
    }
    final shimmerSize = shimmer.size;
    final gradient = shimmer.gradient;
    final offsetWithinShimmer = shimmer.getDescendantOffset(
      descendant: context.findRenderObject() as RenderBox,
    );

    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (bounds) {
        return gradient.createShader(
          Rect.fromLTWH(
            -offsetWithinShimmer.dx,
            -offsetWithinShimmer.dy,
            shimmerSize.width,
            shimmerSize.height,
          ),
        );
      },
      child: widget.child,
    );
  }
}

//make the the entire screen should look like one, big shimmering surface

class Shimmer extends StatefulWidget {
  static ShimmerState? of(BuildContext context) {
    return context.findAncestorStateOfType<ShimmerState>();
  }

  const Shimmer({super.key, this.linearGradient, this.child});

  final LinearGradient? linearGradient;
  final Widget? child;

  @override
  ShimmerState createState() => ShimmerState();
}

class ShimmerState extends State<Shimmer> with SingleTickerProviderStateMixin {
  late AnimationController _shimmerController;
  bool get isLight => FluentTheme.of(context).brightness == Brightness.light;

  @override
  void initState() {
    super.initState();

    _shimmerController = AnimationController.unbounded(vsync: this)
      ..repeat(min: -0.5, max: 1.5, period: const Duration(milliseconds: 1000));
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  LinearGradient get gradient => LinearGradient(
    colors:
        widget.linearGradient?.colors ??
        (FluentTheme.of(context).brightness == Brightness.light
            ? [
                FluentTheme.of(
                  context,
                ).resources.solidBackgroundFillColorBase, //Color(0xFFe2e2e2),
                FluentTheme.of(context)
                    .resources
                    .solidBackgroundFillColorQuarternary, //Color(0xFFe7e7e7),
                FluentTheme.of(
                  context,
                ).resources.solidBackgroundFillColorBase, //Color(0xFFe2e2e2),
              ]
            : [
                FluentTheme.of(
                  context,
                ).resources.cardStrokeColorDefault, //Color(0xFF353535),
                FluentTheme.of(
                  context,
                ).resources.cardBackgroundFillColorDefault, //Color(0xFF303030),
                FluentTheme.of(
                  context,
                ).resources.cardStrokeColorDefault, //Color(0xFF353535),
              ]),
    stops: widget.linearGradient?.stops ?? const [0.1, 0.3, 0.4],
    begin: widget.linearGradient?.begin ?? const Alignment(-1.0, 0.0),
    end: widget.linearGradient?.end ?? const Alignment(1.0, 0.0),
    transform: _SlidingGradientTransform(
      slidePercent: _shimmerController.value,
    ),
  );

  bool get isSized =>
      (context.findRenderObject() as RenderBox?)?.hasSize ?? false;

  Size get size => (context.findRenderObject() as RenderBox).size;

  Listenable get shimmerChanges => _shimmerController;

  Offset getDescendantOffset({
    required RenderBox descendant,
    Offset offset = Offset.zero,
  }) {
    final shimmerBox = context.findRenderObject() as RenderBox;
    return descendant.localToGlobal(offset, ancestor: shimmerBox);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child ?? const SizedBox();
  }
}

class _SlidingGradientTransform extends GradientTransform {
  const _SlidingGradientTransform({required this.slidePercent});

  final double slidePercent;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * slidePercent, 0.0, 0.0);
  }
}
