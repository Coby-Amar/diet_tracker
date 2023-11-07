import 'dart:async';

import 'package:diet_tracker/resources/models/base.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class AppAutocomplete<T extends AutoCompleteModel> extends StatelessWidget {
  final String label;
  final FutureOr<Iterable<T>> Function(TextEditingValue textEditingValue)
      optionsBuilder;
  final void Function(T option)? onSelected;
  final TextEditingValue? initialValue;
  final String? errorText;
  final TextStyle? errorStyle;

  const AppAutocomplete({
    super.key,
    required this.label,
    required this.optionsBuilder,
    this.onSelected,
    this.initialValue,
    this.errorText,
    this.errorStyle,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => RawAutocomplete<T>(
        initialValue: initialValue,
        optionsBuilder: optionsBuilder,
        onSelected: onSelected,
        optionsViewBuilder: (context, onSelected, options) =>
            _AutocompleteOption(
          onSelected: onSelected,
          options: options,
          width: constraints.biggest.width,
        ),
        displayStringForOption: (option) => option.toStringDisplay,
        fieldViewBuilder:
            (context, textEditingController, focusNode, onFieldSubmitted) =>
                TextField(
                    focusNode: focusNode,
                    controller: textEditingController,
                    onSubmitted: (value) => onFieldSubmitted(),
                    decoration: InputDecoration(
                      labelText: label,
                      errorText: errorText,
                      errorStyle: errorStyle ?? const TextStyle(height: 0),
                    )),
      ),
    );
  }
}

class _AutocompleteOption<T extends AutoCompleteModel> extends StatelessWidget {
  final Iterable<T> options;
  final double width;
  final void Function(T) onSelected;
  const _AutocompleteOption({
    super.key,
    required this.options,
    required this.onSelected,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Material(
        elevation: 4.0,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 200, maxWidth: width),
          child: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: options.length,
            itemBuilder: (BuildContext context, int index) {
              final T option = options.elementAt(index);
              return InkWell(
                onTap: () {
                  onSelected(option);
                },
                child: Builder(builder: (BuildContext context) {
                  final bool highlight =
                      AutocompleteHighlightedOption.of(context) == index;
                  if (highlight) {
                    SchedulerBinding.instance
                        .addPostFrameCallback((Duration timeStamp) {
                      Scrollable.ensureVisible(context, alignment: 0.5);
                    });
                  }
                  return Container(
                      color: highlight ? Theme.of(context).focusColor : null,
                      padding: const EdgeInsets.all(16.0),
                      child: Text(option.toStringDisplay));
                }),
              );
            },
          ),
        ),
      ),
    );
  }
}
