// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProductsStore on _ProductsStore, Store {
  late final _$productsAtom =
      Atom(name: '_ProductsStore.products', context: context);

  @override
  ObservableList<ProductModel> get products {
    _$productsAtom.reportRead();
    return super.products;
  }

  @override
  set products(ObservableList<ProductModel> value) {
    _$productsAtom.reportWrite(value, super.products, () {
      super.products = value;
    });
  }

  late final _$loadAsyncAction =
      AsyncAction('_ProductsStore.load', context: context);

  @override
  Future<void> load() {
    return _$loadAsyncAction.run(() => super.load());
  }

  late final _$createAsyncAction =
      AsyncAction('_ProductsStore.create', context: context);

  @override
  Future<void> create(ProductModel product) {
    return _$createAsyncAction.run(() => super.create(product));
  }

  late final _$updateAsyncAction =
      AsyncAction('_ProductsStore.update', context: context);

  @override
  Future<void> update(ProductModel product) {
    return _$updateAsyncAction.run(() => super.update(product));
  }

  late final _$deleteAsyncAction =
      AsyncAction('_ProductsStore.delete', context: context);

  @override
  Future<void> delete(String productId) {
    return _$deleteAsyncAction.run(() => super.delete(productId));
  }

  @override
  String toString() {
    return '''
products: ${products}
    ''';
  }
}
