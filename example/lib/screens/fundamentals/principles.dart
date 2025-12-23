import 'package:example/widgets/card_highlight.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;

class PrinciplesPage extends StatelessWidget {
  const PrinciplesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      header: PageHeader(title: Text('Principles')),
      children: [
        const SizedBox(height: 10),
        const Text(
          '1. Natural on every platform: You want to know what to do. Your experiences should adapt to the device you’re on and should build off the familiar—designing for what you already understand.',
        ),
        const SizedBox(height: 10),
        const Text(
          '2. Built for focus: You want to stay in the flow. ​ Your experiences should inspire action, drawing you forward, simply and seamlessly.',
        ),
        const SizedBox(height: 10),
        const Text(
          '3. One for all, all for one: You want to be included. Your experiences should consider, learn, and reflect a range of perspectives and abilities for the benefit of all.',
        ),
        const SizedBox(height: 10),
        const Text(
          '4. Unmistakably Microsoft: You want to recognize what you’re looking for. Your experiences should feel like one Microsoft. One moment, one product, one experience at a time.',
        ),
        const SizedBox(height: 30),
        Text('Fluent UI 2', style: FluentTheme.of(context).typography.subtitle),
        const SizedBox(height: 10),
        const Text(
          'Fluent UI 2 is a design system to create beautiful and cohesive experiences. '
          'The language is carried through each platform-specific UI library to ensure you can build '
          'the same great experiences across one platform or across them all.',
        ),
        const SizedBox(height: 10),
        material.DataTable(
          border: material.TableBorder.all(
            color: Colors.transparent,
            width: 0,
          ),
          columns: <material.DataColumn>[
            const material.DataColumn(label: Text('Platform')),
            const material.DataColumn(label: Text('Specific UI library')),
          ],
          rows: <material.DataRow>[
            material.DataRow(
              color: WidgetStateProperty.all(Colors.white),
              cells: [
                const material.DataCell(Text('Web')),
                const material.DataCell(Text('Fluent Web UI widgets')),
              ],
            ),
            material.DataRow(
              cells: [
                const material.DataCell(Text('iOS')),
                const material.DataCell(Text('Fluent iOS UI widgets')),
              ],
            ),
            material.DataRow(
              color: WidgetStateProperty.all(Colors.white),
              cells: [
                const material.DataCell(Text('Android')),
                const material.DataCell(Text('Fluent Android UI widgets')),
              ],
            ),
            material.DataRow(
              cells: [
                const material.DataCell(Text('Windows')),
                const material.DataCell(Text('WinUI 3 widgets')),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Text(
          'This flutter library mainly provide WinUI 3 widgets, bringing the Fluent UI 2 design language to Flutter applications.',
        ),
        const SizedBox(height: 30),
        Text('Flutter', style: FluentTheme.of(context).typography.subtitle),
        const SizedBox(height: 10),
        const Text(
          'Flutter is Google\'s UI Framework for building natively compiled applications '
          'for cross-platforms from a single codebase. It allows developers to create '
          'high-performance apps with consistent UIs. '
          'With Flutter, it becomes possible to bring WinUI widgets to platforms outside Windows. Yet, you should be aware of '
          'the existence of specific Fluent UI widgets that fit each platform.',
        ),
      ],
    );
  }
}
