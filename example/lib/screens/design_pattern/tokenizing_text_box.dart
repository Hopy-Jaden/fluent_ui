import 'dart:async';

import 'package:example/screens/surface/avatar.dart';
import 'package:fluent_ui/fluent_ui.dart';

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
  List<String> _suggestions = <String>[];

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: PageHeader(title: const Text('Tokenizing TextBox')),
      content: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TokensInput<String>(
              values: _toppings,
              /*decoration: const InputDecoration(
                prefixIcon: Icon(Icons.local_pizza_rounded),
                hintText: 'Search for toppings',
              ),*/
              strutStyle: const StrutStyle(fontSize: 15),
              onChanged: _onChanged,
              onSubmitted: _onSubmitted,
              TokenBuilder: _TokenBuilder,
              onTextChanged: _onSearchChanged,
            ),
          ),
          if (_suggestions.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: _suggestions.length,
                itemBuilder: (BuildContext context, int index) {
                  return ToppingSuggestion(_suggestions[index], onTap: _selectSuggestion);
                },
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _onSearchChanged(String value) async {
    final List<String> results = await _suggestionCallback(value);
    setState(() {
      _suggestions = results.where((String topping) => !_toppings.contains(topping)).toList();
    });
  }

  Widget _TokenBuilder(BuildContext context, String topping) {
    return ToppingInputToken(topping: topping, onDeleted: _onTokenDeleted, onSelected: _onTokenTapped);
  }

  void _selectSuggestion(String topping) {
    setState(() {
      _toppings.add(topping);
      _suggestions = <String>[];
    });
  }

  void _onTokenTapped(String topping) {}

  void _onTokenDeleted(String topping) {
    setState(() {
      _toppings.remove(topping);
      _suggestions = <String>[];
    });
  }

  void _onSubmitted(String text) {
    if (text.trim().isNotEmpty) {
      setState(() {
        _toppings = <String>[..._toppings, text.trim()];
      });
    } else {
      _TokenFocusNode.unfocus();
      setState(() {
        _toppings = <String>[];
      });
    }
  }

  void _onChanged(List<String> data) {
    setState(() {
      _toppings = data;
    });
  }

  FutureOr<List<String>> _suggestionCallback(String text) {
    if (text.isNotEmpty) {
      return _pizzaToppings.where((String topping) {
        return topping.toLowerCase().contains(text.toLowerCase());
      }).toList();
    }
    return const <String>[];
  }
}

class TokensInput<T> extends StatefulWidget {
  const TokensInput({
    super.key,
    required this.values,
    //this.decoration = const InputDecoration(),
    this.style,
    this.strutStyle,
    required this.TokenBuilder,
    required this.onChanged,
    this.onTokenTapped,
    this.onSubmitted,
    this.onTextChanged,
  });

  final List<T> values;
  //final InputDecoration decoration;
  final TextStyle? style;
  final StrutStyle? strutStyle;

  final ValueChanged<List<T>> onChanged;
  final ValueChanged<T>? onTokenTapped;
  final ValueChanged<String>? onSubmitted;
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

      // If the current number and the previous number of replacements are different, then
      // the user has deleted the InputToken using the keyboard. In this case, we trigger
      // the onChanged callback. We need to be sure also that the current number of
      // replacements is different from the input Token to avoid double-deletion.
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
      //minLines: 1,
      //maxLines: 3,
      textInputAction: TextInputAction.done,
      //style: widget.style,
      //strutStyle: widget.strutStyle,
      controller: controller,
      items: _pizzaToppings
          .where((String topping) => !widget.values.contains(topping))
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
      /*onSelected: (AutoSuggestBoxItem item) {
        final List<T> newValues = <T>[...widget.values, item.value as T];
        widget.onChanged(newValues);
      },*/
      onChanged: (text, reason) {
        widget.onTextChanged?.call(controller.textWithoutReplacements);
      },
      //onChanged: (String value) => widget.onTextChanged?.call(controller.textWithoutReplacements),
      onSelected: (AutoSuggestBoxItem item) {
        widget.onSubmitted?.call(controller.textWithoutReplacements);
        final List<T> newValues = <T>[...widget.values, item.value as T];
        widget.onChanged(newValues);
      },
      
      //(String value) => widget.onSubmitted?.call(controller.textWithoutReplacements),
    );

    /*return TextBox(
      minLines: 1,
      maxLines: 3,
      textInputAction: TextInputAction.done,
      style: widget.style,
      strutStyle: widget.strutStyle,
      controller: controller,
      onChanged: (String value) => widget.onTextChanged?.call(controller.textWithoutReplacements),
      onSubmitted: (String value) => widget.onSubmitted?.call(controller.textWithoutReplacements),
    );*/
  }
}

class TokensInputEditingController<T> extends TextEditingController {
  TokensInputEditingController(this.values, this.TokenBuilder)
    : super(text: String.fromCharCode(kObjectReplacementChar) * values.length);

  // This constant character acts as a placeholder in the TextField text value.
  // There will be one character for each of the InputToken displayed.
  static const int kObjectReplacementChar = 0xFFFE;

  List<T> values;

  final Widget Function(BuildContext context, T data) TokenBuilder;

  /// Called whenever Token is either added or removed
  /// from the outside the context of the text field.
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
    final Iterable<WidgetSpan> TokenWidgets = values.map(
      (T v) => WidgetSpan(child: TokenBuilder(context, v)),
    );

    return TextSpan(
      style: style,
      children: <InlineSpan>[
        ...TokenWidgets,
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
    return ListTile(
      key: ObjectKey(topping),
      leading: Avatar(child: Text(topping[0].toUpperCase())),
      title: Text(topping),
      onPressed: () => onTap?.call(topping),
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
        children: [Token(
          key: ObjectKey(topping),
          child: Text(topping),
          isRemovable: true,
          onRemoved: () => onDeleted(topping),
          onSelected: (bool value) => onSelected(topping),
          //materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          //padding: const EdgeInsets.all(2),
        ),]
      ),
    );
  }
}
