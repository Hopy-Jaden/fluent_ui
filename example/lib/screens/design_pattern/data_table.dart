import 'package:example/widgets/card_highlight.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;

import '../../../widgets/page.dart';

class DataTablePage extends StatefulWidget {
  const DataTablePage({super.key});

  @override
  State<DataTablePage> createState() => _DataTablePageState();
}

class _DataTablePageState extends State<DataTablePage>
    with PageMixin {
  static const double itemHeight = 500;
    bool selected = true;
      String? comboboxValue;

  int topIndex = 0;

  PaneDisplayMode displayMode = PaneDisplayMode.expanded;
  String pageTransition = 'Default';

  String indicator = 'Sticky';
  bool hasTopBar = true;

  List<NavigationPaneItem> items = [];

  @override
  Widget build(final BuildContext context) {
    return ScaffoldPage.scrollable(
      header: const PageHeader(title: Text('Data Table')),
      children: [
        const Text(
          'DataTable provides a set of components which is an intermediary between a list and a full-blown DataGrid experience, introduced in the windows community toolkit gallery. '
          'Yet, there is no existing widget provided from this library can achieve this feature. '
          'Follow these steps to create Data Table in Fluent UI design language as a workaround:'
        ),
        const SizedBox(height: 30),
        Text('About DataTable', style: FluentTheme.of(context).typography.subtitle,),
        const Text(
          'DataTable is useful in scenarios where:'
        ),
        const Text(
          '(1) A simplified/modern style is required as more of a table of data'
        ),
        const Text(
          '(2) Cell-level selection isn\'t required'
        ),
        const Text(
          '(3) Editing every piece of data in the table isn\'t required'
        ),
        const SizedBox(height: 10),
        
        Text('Step 1: Import both Fluent ui and Material ui package', style: FluentTheme.of(context).typography.subtitle,),
        const SizedBox(height: 20),
        CardHighlight(
          initiallyOpen: false,
          codeSnippet: '''
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;'''
        ),
        const SizedBox(height: 30),
        Text('Step 2: Import a material UI DataTable() widget', style: FluentTheme.of(context).typography.subtitle,),
        const SizedBox(height: 10,),
        Text(
          'Import DataTable by adding \'material.\' .',
        ),
        const SizedBox(height: 20),
        CardHighlight(
          initiallyOpen: false,
          codeSnippet: '''
material.DataTable(
  columns: <material.DataColumn>[
    material.DataColumn(label: Text('Platform'),
    material.DataColumn(label: Text('Specific UI library'),
  ],
  rows: <material.DataRow>[
    material.DataRow(
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
''', 
child: material.DataTable(
          columns: <material.DataColumn>[
            const material.DataColumn(label: Text('Platform')),
            const material.DataColumn(label: Text('Specific UI library')),
          ],
          rows: <material.DataRow>[
            material.DataRow(
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
        ),
        const SizedBox(height: 30),
        Text('Step 3: Remove Divider', style: FluentTheme.of(context).typography.subtitle,),
        const SizedBox(height: 10,),
        Text(
          'Set divider thickness as 0.01 to remove the white divider line between rows.',
        ),
        const SizedBox(height: 20),
        CardHighlight(
          initiallyOpen: false,
          codeSnippet: '''
material.DataTable(
  dividerThickness: 0.01,
  columns: <material.DataColumn>[
    material.DataColumn(label: Text('Platform'),
    material.DataColumn(label: Text('Specific UI library'),
  ],
  rows: <material.DataRow>[
    material.DataRow(
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
''', 
child: material.DataTable(
          dividerThickness: 0.01,
          columns: <material.DataColumn>[
            const material.DataColumn(label: Text('Platform')),
            const material.DataColumn(label: Text('Specific UI library')),
          ],
          rows: <material.DataRow>[
            material.DataRow(
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
        ),
        const SizedBox(height: 30),
        Text('Step 4: Alternate Colors of Data Row', style: FluentTheme.of(context).typography.subtitle,),
        const SizedBox(height: 10,),
        Text(
          'Alternate the rows with the card theme color.',
        ),
        const SizedBox(height: 20),
        CardHighlight(
          initiallyOpen: false,
          codeSnippet: '''
material.DataTable(
  dividerThickness: 0.01,
  columns: <material.DataColumn>[
    material.DataColumn(label: Text('Platform'),
    material.DataColumn(label: Text('Specific UI library'),
  ],
  rows: <material.DataRow>[
    material.DataRow(
      color: WidgetStateProperty.all(FluentTheme.of(context).cardColor),
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
      color: WidgetStateProperty.all(FluentTheme.of(context).cardColor),
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
''', 
child: material.DataTable(
          dividerThickness: 0.01,
          columns: <material.DataColumn>[
            const material.DataColumn(label: Text('Platform')),
            const material.DataColumn(label: Text('Specific UI library')),
          ],
          rows: <material.DataRow>[
            material.DataRow(
              color: WidgetStateProperty.all(FluentTheme.of(context).cardColor),
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
              color: WidgetStateProperty.all(FluentTheme.of(context).cardColor),
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
        ),
        const SizedBox(height: 30),
        Text('Step 5: Color the Table Header', style: FluentTheme.of(context).typography.subtitle,),
        const SizedBox(height: 10,),
        Text(
          'Color the table header with NavigationPaneTheme header text style.',
        ),
        const SizedBox(height: 20),
        CardHighlight(
          initiallyOpen: true,
          codeSnippet: '''
material.DataTable(
  dividerThickness: 0.01,
  columns: <material.DataColumn>[
    material.DataColumn(label: Text('Platform', style: NavigationPaneTheme.of(context).itemHeaderTextStyle,)),
    material.DataColumn(label: Text('Specific UI library', style: NavigationPaneTheme.of(context).itemHeaderTextStyle,)),
  ],
  rows: <material.DataRow>[
    material.DataRow(
      color: WidgetStateProperty.all(FluentTheme.of(context).cardColor),
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
      color: WidgetStateProperty.all(FluentTheme.of(context).cardColor),
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
''', 
child: material.DataTable(
          dividerThickness: 0.01,
          columns: <material.DataColumn>[
            material.DataColumn(label: Text('Platform', style: NavigationPaneTheme.of(context).itemHeaderTextStyle,)),
            material.DataColumn(label: Text('Specific UI library', style: NavigationPaneTheme.of(context).itemHeaderTextStyle,)),
          ],
          rows: <material.DataRow>[
            material.DataRow(
              color: WidgetStateProperty.all(FluentTheme.of(context).cardColor),
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
              color: WidgetStateProperty.all(FluentTheme.of(context).cardColor),
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
        ),
      ],
    );
  }
}
