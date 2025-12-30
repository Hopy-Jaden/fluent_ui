import 'dart:math';

import 'package:example/widgets/page.dart';
import 'package:fluent_ui/fluent_ui.dart';

import '../../widgets/card_highlight.dart';

class RatingPage extends StatefulWidget {
  const RatingPage({super.key});

  @override
  State<RatingPage> createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> with PageMixin {
  double determinateValue = 0;
  double amount = 5;
  double spacing = 4; //Random().nextDouble() * 100;
  @override
  Widget build(final BuildContext context) {
    return ScaffoldPage.scrollable(
      header: const PageHeader(title: Text('Rating controls')),
      children: [
        description(
          content: const Text(
            'RatingBar() allow user to rate something on a scale, typically with stars. It\'s a straightforward control for gathering user feedback and displaying ratings.',
          ),
        ),
        CardHighlight(
          codeSnippet:
              '''
RatingBar(
  rating: ${determinateValue.toInt()},
  amount: 5,
  starSpacing:4,
),''',
          child: Row(
            children: [
              RatingBar(
                rating: determinateValue,
                amount: amount.toInt(),
                starSpacing: spacing,
              ),
              Spacer(),
              InfoLabel(
                label: 'Rating: ${determinateValue.toInt()}',
                child: Slider(
                  max: 5,
                  value: determinateValue,
                  onChanged: (final v) => setState(() {
                    determinateValue = v;
                  }),
                ),
              ),
              InfoLabel(
                label: 'Spacing: ${spacing.toInt()}',
                child: Slider(
                  max: 5,
                  value: spacing,
                  onChanged: (final v) => setState(() => spacing = v),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
