import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;

import '../settings.dart';

class TypographyPage extends StatefulWidget {
  const TypographyPage({super.key});

  @override
  State<TypographyPage> createState() => _TypographyPageState();
}

class _TypographyPageState extends State<TypographyPage> {
  int selectedIndex = 0;
  Color? color;
  double scale = 1;

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasFluentTheme(context));
    var typography = FluentTheme.of(context).typography;
    color ??= typography.display!.color;
    typography = typography.apply(displayColor: color);
    return ScaffoldPage(
      header: Column(
        children: [
          PageHeader(
            title: Text('Typography'),
            commandBar: SizedBox(
              width: 180,
              child: Tooltip(
                message: 'Pick a text color',
                child: ComboBox<Color>(
                  placeholder: const Text('Text Color'),
                  onChanged: (final c) => setState(() => color = c),
                  value: color,
                  items: [
                    ComboBoxItem(
                      value: Colors.white,
                      child: Row(
                        children: [
                          buildColorBox(Colors.white),
                          const SizedBox(width: 10),
                          const Text('White'),
                        ],
                      ),
                    ),
                    ComboBoxItem(
                      value: const Color(0xE4000000),
                      child: Row(
                        children: [
                          buildColorBox(const Color(0xE4000000)),
                          const SizedBox(width: 10),
                          const Text('Black'),
                        ],
                      ),
                    ),
                    ...List.generate(Colors.accentColors.length, (final index) {
                      final color = Colors.accentColors[index];
                      return ComboBoxItem(
                        value: color,
                        child: Row(
                          children: [
                            buildColorBox(color),
                            const SizedBox(width: 10),
                            Text(accentColorNames[index + 1]),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: const Text(
              'Clear typographical hierarchy organizes and structures content, making it easy for people to find their way through an experience. '
              'Friendly and legible, Segoe is Microsoft’s signature typeface. It emphasizes readability and personality at different sizes. ',
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: const Text(
              'The Fluent type ramp for Windows uses Segoe UI Variable, a variant of the signature typeface. The type options provide clear style direction and semantic roles for creating scannable hierarchies and a sense of balance. '
              'While Segoe UI is Fluent’s primary typeface in WinUI native and web apps, the system should defaults to native system fonts to ensure a familiar and accessible experience across platforms. ',
            ),
          ),
          /*material.DataTable(
            //dataRowMaxHeight: 92 * (scale + 0.1),

            ///decoration: const BoxDecoration(border: BoxBorder.fromBorderSide(BorderSide.none)),
            columns: const <material.DataColumn>[
              material.DataColumn(label: Text('Name')),
              material.DataColumn(label: Text('Weight')),
              material.DataColumn(label: Text('Size / Height')),
            ],
            rows: <material.DataRow>[
              material.DataRow(
                color: WidgetStateProperty.all(Colors.white),
                cells: [
                  material.DataCell(
                    Text(
                      'Display',
                      style: FluentTheme.of(context).typography.display?.apply(
                        fontSizeFactor: scale,
                        color: color,
                      ),
                    ),
                  ),
                  const material.DataCell(Text('Semibold display')),
                  const material.DataCell(Text('68px / 92px')),
                ],
              ),
              material.DataRow(
                cells: [
                  material.DataCell(
                    Text(
                      'Title Large',
                      style: FluentTheme.of(context).typography.titleLarge
                          ?.apply(fontSizeFactor: scale, color: color),
                    ),
                  ),
                  const material.DataCell(Text('Semibold display')),
                  const material.DataCell(Text('40px / 52px')),
                ],
              ),
              material.DataRow(
                color: WidgetStateProperty.all(Colors.white),
                cells: [
                  material.DataCell(
                    Text(
                      'Title',
                      style: FluentTheme.of(context).typography.title?.apply(
                        fontSizeFactor: scale,
                        color: color,
                      ),
                    ),
                  ),
                  const material.DataCell(Text('Semibold display')),
                  const material.DataCell(Text('28px / 36px')),
                ],
              ),
              material.DataRow(
                cells: [
                  material.DataCell(
                    Text(
                      'Subtitle',
                      style: FluentTheme.of(context).typography.subtitle?.apply(
                        fontSizeFactor: scale,
                        color: color,
                      ),
                    ),
                  ),
                  const material.DataCell(Text('Semibold display')),
                  const material.DataCell(Text('20px / 28px')),
                ],
              ),
              material.DataRow(
                color: WidgetStateProperty.all(Colors.white),
                cells: [
                  material.DataCell(
                    Text(
                      'Body Large',
                      style: FluentTheme.of(context).typography.bodyLarge
                          ?.apply(fontSizeFactor: scale, color: color),
                    ),
                  ),
                  const material.DataCell(Text('Regular')),
                  const material.DataCell(Text('18px / 24px')),
                ],
              ),
              material.DataRow(
                cells: [
                  material.DataCell(
                    Text(
                      'Body Strong',
                      style: FluentTheme.of(context).typography.bodyStrong
                          ?.apply(fontSizeFactor: scale, color: color),
                    ),
                  ),
                  const material.DataCell(Text('Semibold text')),
                  const material.DataCell(Text('14px / 20px')),
                ],
              ),
              material.DataRow(
                color: WidgetStateProperty.all(Colors.white),
                cells: [
                  material.DataCell(
                    Text(
                      'Body',
                      style: FluentTheme.of(context).typography.body?.apply(
                        fontSizeFactor: scale,
                        color: color,
                      ),
                    ),
                  ),
                  const material.DataCell(Text('Regular')),
                  const material.DataCell(Text('14px / 20px')),
                ],
              ),
              material.DataRow(
                cells: [
                  material.DataCell(
                    Text(
                      'Caption',
                      style: FluentTheme.of(context).typography.caption?.apply(
                        fontSizeFactor: scale,
                        color: color,
                      ),
                    ),
                  ),
                  const material.DataCell(Text('Regular Small')),
                  const material.DataCell(Text('12px / 16px')),
                ],
              ),
            ],
          ),
        */],
      ),
      content: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: 25),
            Expanded(
              child: SingleChildScrollView(
                child: material.DataTable(
                  dataRowMaxHeight: 92 * (scale + 0.1),
                
                  ///decoration: const BoxDecoration(border: BoxBorder.fromBorderSide(BorderSide.none)),
                  columns: const <material.DataColumn>[
                    material.DataColumn(label: Text('Name')),
                    material.DataColumn(label: Text('Weight')),
                    material.DataColumn(label: Text('Size / Height')),
                  ],
                  rows: <material.DataRow>[
                    material.DataRow(
                      color: WidgetStateProperty.all(Colors.white),
                      cells: [
                        material.DataCell(
                          Text(
                            'Display',
                            style: FluentTheme.of(context).typography.display
                                ?.apply(fontSizeFactor: scale, color: color),
                          ),
                        ),
                        const material.DataCell(Text('Semibold display')),
                        const material.DataCell(Text('68px / 92px')),
                      ],
                    ),
                    material.DataRow(
                      cells: [
                        material.DataCell(
                          Text(
                            'Title Large',
                            style: FluentTheme.of(context).typography.titleLarge
                                ?.apply(fontSizeFactor: scale, color: color),
                          ),
                        ),
                        const material.DataCell(Text('Semibold display')),
                        const material.DataCell(Text('40px / 52px')),
                      ],
                    ),
                    material.DataRow(
                      color: WidgetStateProperty.all(Colors.white),
                      cells: [
                        material.DataCell(
                          Text(
                            'Title',
                            style: FluentTheme.of(context).typography.title
                                ?.apply(fontSizeFactor: scale, color: color),
                          ),
                        ),
                        const material.DataCell(Text('Semibold display')),
                        const material.DataCell(Text('28px / 36px')),
                      ],
                    ),
                    material.DataRow(
                      cells: [
                        material.DataCell(
                          Text(
                            'Subtitle',
                            style: FluentTheme.of(context).typography.subtitle
                                ?.apply(fontSizeFactor: scale, color: color),
                          ),
                        ),
                        const material.DataCell(Text('Semibold display')),
                        const material.DataCell(Text('20px / 28px')),
                      ],
                    ),
                    material.DataRow(
                      color: WidgetStateProperty.all(Colors.white),
                      cells: [
                        material.DataCell(
                          Text(
                            'Body Large',
                            style: FluentTheme.of(context).typography.bodyLarge
                                ?.apply(fontSizeFactor: scale, color: color),
                          ),
                        ),
                        const material.DataCell(Text('Regular')),
                        const material.DataCell(Text('18px / 24px')),
                      ],
                    ),
                    material.DataRow(
                      cells: [
                        material.DataCell(
                          Text(
                            'Body Strong',
                            style: FluentTheme.of(context).typography.bodyStrong
                                ?.apply(fontSizeFactor: scale, color: color),
                          ),
                        ),
                        const material.DataCell(Text('Semibold text')),
                        const material.DataCell(Text('14px / 20px')),
                      ],
                    ),
                    material.DataRow(
                      color: WidgetStateProperty.all(Colors.white),
                      cells: [
                        material.DataCell(
                          Text(
                            'Body',
                            style: FluentTheme.of(context).typography.body
                                ?.apply(fontSizeFactor: scale, color: color),
                          ),
                        ),
                        const material.DataCell(Text('Regular')),
                        const material.DataCell(Text('14px / 20px')),
                      ],
                    ),
                    material.DataRow(
                      cells: [
                        material.DataCell(
                          Text(
                            'Caption',
                            style: FluentTheme.of(context).typography.caption
                                ?.apply(fontSizeFactor: scale, color: color),
                          ),
                        ),
                        const material.DataCell(Text('Regular Small')),
                        const material.DataCell(Text('12px / 16px')),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 10),
            Semantics(
              label: 'Scale',
              child: Slider(
                vertical: true,
                value: scale,
                onChanged: (final v) => setState(() => scale = v),
                label: scale.toStringAsFixed(2),
                max: 2,
                min: 0.5,
                // style: SliderThemeData(useThumbBall: false),
              ),
            ),
            SizedBox(width: 10,)
          ],
        ),
    
    );
  }
}

Widget buildColorBox(final Color color) {
  const boxSize = 25.0;
  return Container(
    height: boxSize,
    width: boxSize,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(4),
    ),
  );
}
