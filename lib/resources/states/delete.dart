import 'package:diet_tracker/resources/models/base.dart';
import 'package:mobx/mobx.dart';

part 'delete.g.dart';

class DeleteState<T extends UpdateableModel> extends _DeleteState<T>
    with _$DeleteState {}

abstract class _DeleteState<T extends UpdateableModel> with Store {
  @observable
  List<T> selectedModels = [];

  @computed
  bool get deleteModeOn => selectedModels.isNotEmpty;

  @action
  Future<void> addToDeleteQueue(T model) async {
    selectedModels.add(model);
  }

  @action
  Future<void> removeFromDeleteQueue(T model) async {
    selectedModels.remove(model);
  }
}
