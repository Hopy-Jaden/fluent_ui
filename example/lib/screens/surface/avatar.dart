import 'package:example/widgets/card_highlight.dart';
import 'package:example/widgets/page.dart';
import 'package:fluent_ui/fluent_ui.dart';

class AvatarPage extends StatefulWidget {
  const AvatarPage({super.key});

  @override
  State<AvatarPage> createState() => _AvatarPageState();
}

class _AvatarPageState extends State<AvatarPage> with PageMixin {
  bool showStatusRing = true;
  bool autoTextSize = false;

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);

    return ScaffoldPage.scrollable(
      header: PageHeader(
        title: const Text('Avatar & StatusRing'),
        commandBar: Wrap(
          spacing: 12,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            ToggleSwitch(
              checked: showStatusRing,
              onChanged: (v) => setState(() => showStatusRing = v),
              content: const Text('Show status ring'),
            ),
            ToggleSwitch(
              checked: autoTextSize,
              onChanged: (v) => setState(() => autoTextSize = v),
              content: const Text('Auto initials size'),
            ),
          ],
        ),
      ),
      children: [
        const Text(
          'This page demonstrates how to use StatusRing, Avatar and AvatarGroup. '
          'Avatars show images, initials, or custom child widgets. StatusRing is '
          'useful to indicate online/offline/away status (or for decorative effects).',
        ),

        subtitle(content: const Text('Simple avatars')),

        CardHighlight(
          codeSnippet: '''
// Basic initials avatar
Avatar(size: 40, name: 'Ada Lovelace'),

// Image avatar
Avatar(
  size: 40,
  image: NetworkImage('https://...'),
  children: [
    Align(
      alignment: Alignment.bottomRight,
      child: InfoBadge(
        source: Icon(WindowsIcons.info2),
        color: FluentTheme.of(context).accentColor,
      ),
    ),
  ],
),
Avatar(size: 40, image: NetworkImage('https://...')),

// Avatar with a child widget
Avatar(size: 40, child: Icon(FluentIcons.contact)),
''',
          child: Row(
            children: [
              Avatar(
                size: 40,
                name: 'Ada Lovelace',
                autoTextSize: autoTextSize,
              ),
              const SizedBox(width: 12),
              Avatar(
                size: 40,
                image: NetworkImage(
                  'https://avatars.githubusercontent.com/u/9919?s=200&v=4',
                ),
                children: [
                  Align(
                    alignment: Alignment.bottomRight,
                    child: InfoBadge(
                      source: Icon(WindowsIcons.info2),
                      color: FluentTheme.of(context).accentColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              const Avatar(size: 40, child: Icon(FluentIcons.contact)),
            ],
          ),
        ),

        subtitle(content: const Text('Status ring')),

        description(
          content: const Text(
            'Place a StatusRing around an Avatar to show presence or emphasis. '
            'The StatusRing can be customized '
            'with color, thickness or with a full BoxDecoration for gradients.',
          ),
        ),

        CardHighlight(
          codeSnippet: '''
// Status ring slightly larger than the avatar
statusRing = StatusRing(size: 48, thickness: 3, color: Colors.green),

Avatar(size: 40, name: 'Alan Luke', statusRing: statusRing),
''',
          child: Row(
            children: [
              // green online ring
              Avatar(
                size: 40,
                name: 'Alan Luke',
                autoTextSize: autoTextSize,
                statusRing: showStatusRing
                    ? StatusRing(size: 48, thickness: 3, color: Colors.green)
                    : null,
              ),
              const SizedBox(width: 12),

              // red do-not-disturb ring with gradient decoration
              Avatar(
                size: 40,
                image: NetworkImage(
                  'https://avatars.githubusercontent.com/u/9919?s=200&v=4',
                ),
                autoTextSize: autoTextSize,
                statusRing: showStatusRing
                    ? StatusRing(
                        size: 48,
                        thickness: 3,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [Colors.blue, Colors.green],
                          ),
                        ),
                      )
                    : null,
              ),

              const SizedBox(width: 12),

              // Status ring used as a decorative outline (thinner)
              Avatar(
                size: 40,
                child: const Icon(FluentIcons.contact),
                statusRing: showStatusRing
                    ? StatusRing(size: 46, thickness: 2, color: Colors.blue)
                    : null,
              ),
            ],
          ),
        ),

        subtitle(content: const Text('AvatarGroup (overlap & overflow)')),

        description(
          content: const Text(
            'AvatarGroup arranges avatars with overlap. Use maxDisplayed to '
            'compress many avatars into a single "+N" avatar.',
          ),
        ),

        CardHighlight(
          codeSnippet: '''
AvatarGroup(
  children: [
    Avatar(name: 'Ada', size: 40),
    Avatar(name: 'Grace', size: 40),
    Avatar(name: 'Alan', size: 40),
    // ...
  ],
  overlapPercent: 0.35,
  maxDisplayed: 3,
)
''',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AvatarGroup(
                children: [
                  Avatar(name: 'Ada', size: 40),
                  Avatar(name: 'Grace', size: 40),
                  Avatar(name: 'Alan', size: 40),
                  Avatar(name: 'Linus', size: 40),
                  Avatar(name: 'Guido', size: 40),
                ],
                overlapPercent: 0.35,
                fallbackAvatarSize: 40,
                maxDisplayed: 4,
              ),
              const SizedBox(height: 12),
              // Example: group that contains avatars with different base sizes / status rings
              AvatarGroup(
                children: [
                  Avatar(
                    name: 'A',
                    size: 36,
                    statusRing: showStatusRing
                        ? StatusRing(
                            size: 42,
                            thickness: 2,
                            color: Colors.green,
                          )
                        : null,
                  ),
                  const Avatar(name: 'B', size: 40),
                  const Avatar(name: 'C', size: 44),
                ],
                overlapPercent: 0.25,
                fallbackAvatarSize: 40,
              ),
            ],
          ),
        ),

        subtitle(content: const Text('Additional tips')),

        description(
          content: const Text(
            '• Use decoration to change the avatar shape (square for groups).\n'
            '• Use foregroundDecoration for badges/overlays clipped to the avatar.\n'
            '• When providing images, supply an errorBuilder fallback (Avatar handles this).\n'
            '• Adjust StatusRing.size so it slightly exceeds the avatar size to remain visible.',
          ),
        ),

        // small live example demonstrating foregroundDecoration and square decoration
        CardHighlight(
          codeSnippet: '''
Avatar(
  size: 48,
  child: Text('Org'),
  decoration: BoxDecoration(shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(6)),
  statusRing: showStatusRing
    ? StatusRing(size: 54, thickness: 2, color: Colors.purple, decoration: BoxDecoration(
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: theme.accentColor, width: 2)
    ),)
    : null,
),
''',
          child: Avatar(
            size: 48,
            child: const Text('Org'),
            decoration: const BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(6)),
            ),
            statusRing: showStatusRing
                ? StatusRing(
                    size: 54,
                    thickness: 2,
                    color: Colors.purple,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: theme.accentColor, width: 2),
                    ),
                  )
                : null,
            autoTextSize: autoTextSize,
          ),
        ),
      ],
    );
  }
}
