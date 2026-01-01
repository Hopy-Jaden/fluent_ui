import 'package:example/widgets/card_highlight.dart';
import 'package:example/widgets/page.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/rendering.dart';


class GridViewPage extends StatefulWidget {
  const GridViewPage({super.key});

  @override
  State<GridViewPage> createState() => _GridViewPageState();
}

class _GridViewPageState extends State<GridViewPage> with PageMixin {
  final List<String> items = List.generate(20, (i) => 'Item ${i + 1}');
  final List<String> selectableItems =
      List.generate(20, (i) => 'Selectable Item ${i + 1}');

  String? selectedItem;
  List<String> selectedItems = [];

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      header: const PageHeader(title: Text('GridView')),
      children: [
        description(
          content: const Text(
            'GridView is a layout that arranges its children in a grid. '
            'GridTile is a single item within the GridView.',
          ),
        ),
        subtitle(content: const Text('Basic GridView with selectable GridTile')),
        CardHighlight(
          codeSnippet: '''
GridView.count(
  crossAxisCount: 3,
  children: List.generate(9, (index) {
    return GridTile(
      child: Center(
        child: Text('Item \$index'),
      ),
    );
  }),
),
''',
          child: SizedBox(
            height: 300,
            child: GridView.count(
              crossAxisCount: 3,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 1.0, // Adjust as needed
              padding: const EdgeInsets.all(8),
              children: List.generate(9, (index) {
                return GridTile.selectable(
                  selectionMode: GridTileSelectionMode.single,
                  selected: selectedItem == index.toString(),
                  onPressed: () => setState(() {
                    selectedItem = index.toString();
                  }),
                  child: Center(
                    child: Text(
                      'Item $index',
                      //style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
        subtitle(content: const Text('GridTiles that are multi-selectable')),
        CardHighlight(
          codeSnippet: '''
GridView.count(
  crossAxisCount: 3,
  children: items.map((item) {
    return GridTile.selectable(
      selected: selectedItems.contains(item),
      selectionMode: GridTileSelectionMode.multiple,
      onSelectionChange: (selected) {
        setState(() {
          if (selected) {
            selectedItems.add(item);
          } else {
            selectedItems.remove(item);
          }
        });
      },
      child: Center(
        child: Text(item),
      ),
    );
  }).toList(),
),
''',
          child: SizedBox(
            height: 300,
            child: GridView.count(
              crossAxisCount: 3,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 1.0, // Adjust as needed
              padding: const EdgeInsets.all(8),
              children: selectableItems.map((item) {
                return GridTile.selectable(
                  /*tileColor: WidgetStateColor.resolveWith((states) {
                    return Colors.accentColors[
                            selectableItems.indexOf(item) % Colors.accentColors.length]
                        .withOpacity(selectedItems.contains(item) ? 1 : 0.5);
                  }),*/
                  selected: selectedItems.contains(item),
                  selectionMode: GridTileSelectionMode.multiple,
                  onSelectionChange: (selected) {
                    setState(() {
                      if (selected) {
                        selectedItems.add(item);
                      } else {
                        selectedItems.remove(item);
                      }
                    });
                  },
                  child: Center(
                    child: Text(
                      item,
                      //style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        subtitle(content: const Text('GridView.builder with GridTile')),
        CardHighlight(
          codeSnippet: '''
GridView.builder(
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 3,
    crossAxisSpacing: 8,
    mainAxisSpacing: 8,
    childAspectRatio: 1.0,
  ),
  itemCount: items.length,
  itemBuilder: (context, index) {
    final item = items[index];
    return GridTile(
      child: Center(
        child: Text(item),
      ),
    );
  },
),
''',
          child: SizedBox(
            height: 300,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 1.0,
              ),
              padding: const EdgeInsets.all(8),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return GridTile(
                  tileColor: WidgetStateColor.resolveWith((states) {
  if (states.isHovered) {
    return Colors.accentColors[index % Colors.accentColors.length].withOpacity(0.8); // Slightly lighter on hover
  }
  return Colors.accentColors[index % Colors.accentColors.length]; // Default color
}),
                  child: Center(
                    child: Text(
                      item,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
