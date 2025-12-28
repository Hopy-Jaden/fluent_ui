import 'dart:async';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';

const List<String> _pizzaToppings = <String>[
  'Olives',
  'Tomato',
  'Cheese',
  'Pepperoni',
  'Bacon',
  'Onion',
  'Jalapeno',
  'Mushrooms',
  'Pineapple',
];

class TokenizingTextBoxPage extends StatefulWidget {
  const TokenizingTextBoxPage({super.key});

  @override
  TokenizingTextBoxPageState createState() {
    return TokenizingTextBoxPageState();
  }
}

class TokenizingTextBoxPageState extends State<TokenizingTextBoxPage> {
  final FocusNode _TokenFocusNode = FocusNode();
  List<String> _toppings = <String>[_pizzaToppings.first];
  String _currentText = '';

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: PageHeader(title: const Text('Tokenizing TextBox')),
      content: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: RawKeyboardListener(
              focusNode: _TokenFocusNode,
              onKey: (event) {
                if (event is RawKeyDownEvent) {
                  if (event.logicalKey == LogicalKeyboardKey.enter) {
                    // Handle Enter key press
                    if (_currentText.trim().isNotEmpty) {
                      setState(() {
                        _toppings = <String>[..._toppings, _currentText.trim()];
                      });
                    }
                  }
                }
              },
              child: TokensInput<String>(
                values: _toppings,
                strutStyle: const StrutStyle(fontSize: 15),
                onChanged: _onChanged,
                TokenBuilder: _TokenBuilder,
                onTextChanged: _onSearchChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onSearchChanged(String value) async {
    _currentText = value;
    setState(() {});
  }

  Widget _TokenBuilder(BuildContext context, String topping) {
    return ToppingInputToken(topping: topping, onDeleted: _onTokenDeleted, onSelected: _onTokenTapped);
  }

  void _onTokenTapped(String topping) {}

  void _onTokenDeleted(String topping) {
    setState(() {
      _toppings.remove(topping);
    });
  }

  void _onChanged(List<String> data) {
    setState(() {
      _toppings = data;
    });
  }

  @override
  void initState() {
    super.initState();
    _TokenFocusNode.requestFocus();
  }

  @override
  void dispose() {
    _TokenFocusNode.dispose();
    super.dispose();
  }
}

class TokensInput<T> extends StatefulWidget {
  const TokensInput({
    super.key,
    required this.values,
    this.style,
    this.strutStyle,
    required this.TokenBuilder,
    required this.onChanged,
    this.onTokenTapped,
    this.onTextChanged,
  });

  final List<T> values;
  final TextStyle? style;
  final StrutStyle? strutStyle;

  final ValueChanged<List<T>> onChanged;
  final ValueChanged<T>? onTokenTapped;
  final ValueChanged<String>? onTextChanged;

  final Widget Function(BuildContext context, T data) TokenBuilder;

  @override
  TokensInputState<T> createState() => TokensInputState<T>();
}

class TokensInputState<T> extends State<TokensInput<T>> {
  @visibleForTesting
  late final TokensInputEditingController<T> controller;

  String _previousText = '';
  TextSelection? _previousSelection;

  @override
  void initState() {
    super.initState();

    controller = TokensInputEditingController<T>(<T>[...widget.values], widget.TokenBuilder);
    controller.addListener(_textListener);
  }

  @override
  void dispose() {
    controller.removeListener(_textListener);
    controller.dispose();

    super.dispose();
  }

  void _textListener() {
    final String currentText = controller.text;

    if (_previousSelection != null) {
      final int currentNumber = countReplacements(currentText);
      final int previousNumber = countReplacements(_previousText);

      final int cursorEnd = _previousSelection!.extentOffset;
      final int cursorStart = _previousSelection!.baseOffset;

      final List<T> values = <T>[...widget.values];

      if (currentNumber < previousNumber && currentNumber != values.length) {
        if (cursorStart == cursorEnd) {
          values.removeRange(cursorStart - 1, cursorEnd);
        } else {
          if (cursorStart > cursorEnd) {
            values.removeRange(cursorEnd, cursorStart);
          } else {
            values.removeRange(cursorStart, cursorEnd);
          }
        }
        widget.onChanged(values);
      }
    }

    _previousText = currentText;
    _previousSelection = controller.selection;
  }

  static int countReplacements(String text) {
    return text.codeUnits
        .where((int u) => u == TokensInputEditingController.kObjectReplacementChar)
        .length;
  }

  @override
  Widget build(BuildContext context) {
    controller.updateValues(<T>[...widget.values]);
    return AutoSuggestBox(
      textInputAction: TextInputAction.none,
      controller: controller,
      items: _pizzaToppings
          .where((String topping) =>
              !widget.values.contains(topping) &&
              topping.toLowerCase().contains(controller.textWithoutReplacements.toLowerCase()))
          .map<AutoSuggestBoxItem>((String topping) {
        return AutoSuggestBoxItem(
          value: topping,
          label: topping,
          child: ToppingSuggestion(topping, onTap: (String value) {
            final List<T> newValues = <T>[...widget.values, value as T];
            widget.onChanged(newValues);
          }),
        );
      }).toList(),
      onChanged: (text, reason) {
        widget.onTextChanged?.call(controller.textWithoutReplacements);
      },
      onSelected: (AutoSuggestBoxItem item) {
        final List<T> newValues = <T>[...widget.values, item.value as T];
        widget.onChanged(newValues);
      },
    );
  }
}

class TokensInputEditingController<T> extends TextEditingController {
  TokensInputEditingController(this.values, this.TokenBuilder)
      : super(text: String.fromCharCode(kObjectReplacementChar) * values.length);

  static const int kObjectReplacementChar = 0xFFFE;

  List<T> values;

  final Widget Function(BuildContext context, T data) TokenBuilder;

  void updateValues(List<T> values) {
    if (values.length != this.values.length) {
      final String char = String.fromCharCode(kObjectReplacementChar);
      final int length = values.length;
      value = TextEditingValue(
        text: char * length,
        selection: TextSelection.collapsed(offset: length),
      );
      this.values = values;
    }
  }

  String get textWithoutReplacements {
    final String char = String.fromCharCode(kObjectReplacementChar);
    return text.replaceAll(RegExp(char), '');
  }

  String get textWithReplacements => text;

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) {
    final Iterable<WidgetSpan> tokenWidgets = values.map(
      (T v) => WidgetSpan(child: TokenBuilder(context, v)),
    );

    return TextSpan(
      style: style,
      children: <InlineSpan>[
        ...tokenWidgets,
        if (textWithoutReplacements.isNotEmpty) TextSpan(text: textWithoutReplacements),
      ],
    );
  }
}

class ToppingSuggestion extends StatelessWidget {
  const ToppingSuggestion(this.topping, {super.key, this.onTap});

  final String topping;
  final ValueChanged<String>? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: ObjectKey(topping),
      onTap: () => onTap?.call(topping),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Avatar(child: Text(topping[0].toUpperCase())),
          Text(
            topping,
          ),
        ],
      ),
    );
  }
}

class ToppingInputToken extends StatelessWidget {
  const ToppingInputToken({
    super.key,
    required this.topping,
    required this.onDeleted,
    required this.onSelected,
  });

  final String topping;
  final ValueChanged<String> onDeleted;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 3),
      child: Wrap(
        children: [
          Token(
            key: ObjectKey(topping),
            child: Text(topping),
            isRemovable: true,
            onRemoved: () => onDeleted(topping),
            onSelected: (bool value) => onSelected(topping),
            contentPadding: EdgeInsetsGeometry.symmetric(vertical: 1.0, horizontal: 5),
          ),
        ],
      ),
    );
  }
}
