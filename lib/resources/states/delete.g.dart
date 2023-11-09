// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DeleteState<T extends UpdateableModel> on _DeleteState<T>, Store {
  Computed<bool>? _$deleteModeOnComputed;

  @override
  bool get deleteModeOn =>
      (_$deleteModeOnComputed ??= Computed<bool>(() => super.deleteModeOn,
              name: '_DeleteState.deleteModeOn'))
          .value;

  late final _$selectedModelsAtom =
      Atom(name: '_DeleteState.selectedModels', context: context);

  @override
  List<T> get selectedModels {
    _$selectedModelsAtom.reportRead();
    return super.selectedModels;
  }

  @override
  set selectedModels(List<T> value) {
    _$selectedModelsAtom.reportWrite(value, super.selectedModels, () {
      super.selectedModels = value;
    });
  }

  late final _$addToDeleteQueueAsyncAction =
      AsyncAction('_DeleteState.addToDeleteQueue', context: context);

  @override
  Future<void> addToDeleteQueue(T model) {
    return _$addToDeleteQueueAsyncAction
        .run(() => super.addToDeleteQueue(model));
  }

  late final _$removeFromDeleteQueueAsyncAction =
      AsyncAction('_DeleteState.removeFromDeleteQueue', context: context);

  @override
  Future<void> removeFromDeleteQueue(T model) {
    return _$removeFromDeleteQueueAsyncAction
        .run(() => super.removeFromDeleteQueue(model));
  }

  @override
  String toString() {
    return '''
selectedModels: ${selectedModels},
deleteModeOn: ${deleteModeOn}
    ''';
  }
}
