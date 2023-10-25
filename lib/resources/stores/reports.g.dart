// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reports.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ReportsStore on _ReportsStore, Store {
  late final _$reportsAtom =
      Atom(name: '_ReportsStore.reports', context: context);

  @override
  ObservableList<ReportModel> get reports {
    _$reportsAtom.reportRead();
    return super.reports;
  }

  @override
  set reports(ObservableList<ReportModel> value) {
    _$reportsAtom.reportWrite(value, super.reports, () {
      super.reports = value;
    });
  }

  late final _$loadAsyncAction =
      AsyncAction('_ReportsStore.load', context: context);

  @override
  Future<void> load() {
    return _$loadAsyncAction.run(() => super.load());
  }

  late final _$createAsyncAction =
      AsyncAction('_ReportsStore.create', context: context);

  @override
  Future<void> create(ReportWithEntries reportWithEntries) {
    return _$createAsyncAction.run(() => super.create(reportWithEntries));
  }

  late final _$deleteAsyncAction =
      AsyncAction('_ReportsStore.delete', context: context);

  @override
  Future<void> delete(String reportId) {
    return _$deleteAsyncAction.run(() => super.delete(reportId));
  }

  @override
  String toString() {
    return '''
reports: ${reports}
    ''';
  }
}
