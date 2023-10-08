import 'dart:async';

import 'package:diet_tracker/providers/models.dart';
import 'package:diet_tracker/validations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class AutocompleteFormField<T extends BaseModel> extends StatelessWidget {
  final String label;
  final void Function(T?) onSaved;
  final FutureOr<Iterable<T>> Function(TextEditingValue textEditingValue)
      optionsBuilder;
  final List<ValidationFunction<T>>? validations;

  const AutocompleteFormField({
    super.key,
    required this.label,
    required this.onSaved,
    required this.optionsBuilder,
    required this.validations,
  });

  @override
  Widget build(BuildContext context) {
    final validator =
        validations != null ? Validations().compose<T>(validations!) : null;
    return FormField<T>(
      validator: validator,
      onSaved: onSaved,
      builder: (field) => RawAutocomplete<T>(
          optionsBuilder: optionsBuilder,
          onSelected: (option) => field.didChange(option),
          optionsViewBuilder: (context, onSelected, options) =>
              _AutocompleteOption(onSelected: onSelected, options: options),
          fieldViewBuilder:
              (context, textEditingController, focusNode, onFieldSubmitted) =>
                  TextField(
                    focusNode: focusNode,
                    controller: textEditingController,
                    onSubmitted: (value) => onFieldSubmitted(),
                    decoration: InputDecoration(
                      labelText: label,
                      errorText: field.errorText,
                    ),
                  )),
    );
  }
}

class _AutocompleteOption<T extends BaseModel> extends StatelessWidget {
  final Iterable<T> options;
  final void Function(T) onSelected;
  const _AutocompleteOption({
    super.key,
    required this.options,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Material(
        elevation: 4.0,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 200.00),
          child: ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: options.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) => Text('test'
                // onTap: () => onSelected(options.elementAt(index)),
                // child: Text('test'),
                // child: Builder(builder: (BuildContext context) {
                //   final bool highlight =
                //       AutocompleteHighlightedOption.of(context) == index;
                //   if (highlight) {
                //     SchedulerBinding.instance
                //         .addPostFrameCallback((Duration timeStamp) {
                //       Scrollable.ensureVisible(context, alignment: 0.5);
                //     });
                //   }
                //   return Container(
                //     color: highlight ? Theme.of(context).focusColor : null,
                //     padding: const EdgeInsets.all(16.0),
                //     child: Text('test'),
                //   );
                // }),
                ),
          ),
        ),
      ),
    );
  }
}
