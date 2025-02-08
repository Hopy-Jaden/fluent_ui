import 'package:example/screens/home.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:url_launcher/link.dart';

/// Current sponsors and contributor of the project <3
const community = [
  Person(
    username: 'h3x4d3c1m4l',
    imageUrl: 'https://avatars.githubusercontent.com/u/2611894?v=4',
    name: 'Sander in \'t Hout',
    tag: 'sponsor',
  ),
  Person(
    username: 'phorcys420',
    imageUrl: 'https://avatars.githubusercontent.com/u/57866459?v=4',
    name: 'Phorcys',
    tag: 'sponsor',
  ),
  Person(
    username: 'whiplashoo',
    imageUrl: 'https://avatars.githubusercontent.com/u/9117427?v=4',
    name: 'Minas Giannekas',
    tag: 'sponsor',
  ),
  Person(
    username: 'longfit',
    imageUrl: 'https://avatars.githubusercontent.com/u/4157794?v=4',
    name: 'longfit',
    tag: 'sponsor',
  ),
  Person(
    username: 'WinXaito',
    imageUrl: 'https://avatars.githubusercontent.com/u/8223773?v=4',
    name: 'Kevin Vuilleumier',
    tag: 'contributor',
  ),
  Person(
    username: 'henry2man',
    imageUrl: 'https://avatars.githubusercontent.com/u/4610108?v=4',
    name: 'Enrique Cardona',
    tag: 'contributor',
  ),
  Person(
    username: 'klondikedragon',
    imageUrl: 'https://avatars.githubusercontent.com/u/88254524?v=4',
    name: 'klondikedragon',
    tag: 'contributor',
  ),
];

class Person {
  final String? username;
  final String name;
  final String imageUrl;
  final String tag;

  const Person({
    required this.username,
    required this.name,
    required this.imageUrl,
    required this.tag,
  });

  Person copyWith({
    String? username,
    String? name,
    String? imageUrl,
    String? tag,
  }) {
    return Person(
      username: username ?? this.username,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      tag: tag ?? this.tag,
    );
  }

  @override
  String toString() =>
      'Person(username: $username, name: $name, imageUrl: $imageUrl)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Person &&
        other.username == username &&
        other.name == name &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode => username.hashCode ^ name.hashCode ^ imageUrl.hashCode;

  Widget build() {
    return Builder(builder: (context) {
      return Link(
        uri: Uri.parse('https://www.github.com/$username'),
        builder: (context, followLink) {
          return Semantics(
            link: true,
            child: IconButton(
              onPressed: () {
                debugPrint('https://www.github.com/$username');
                followLink;
              },
              icon: CommunityMember(
                imageUrl: imageUrl,
                username: username ?? name,
                tag: tag,
              ),
            ),
          );
        },
      );
    });
  }
}
