// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_datail_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProductDatailController on ProductDatailControllerBase, Store {
  late final _$_statusAtom =
      Atom(name: 'ProductDatailControllerBase._status', context: context);

  ProductDatailsStateStatus get status {
    _$_statusAtom.reportRead();
    return super._status;
  }

  @override
  ProductDatailsStateStatus get _status => status;

  @override
  set _status(ProductDatailsStateStatus value) {
    _$_statusAtom.reportWrite(value, super._status, () {
      super._status = value;
    });
  }

  late final _$_errorMessageAtom =
      Atom(name: 'ProductDatailControllerBase._errorMessage', context: context);

  String? get errorMessage {
    _$_errorMessageAtom.reportRead();
    return super._errorMessage;
  }

  @override
  String? get _errorMessage => errorMessage;

  @override
  set _errorMessage(String? value) {
    _$_errorMessageAtom.reportWrite(value, super._errorMessage, () {
      super._errorMessage = value;
    });
  }

  late final _$_productModelAtom =
      Atom(name: 'ProductDatailControllerBase._productModel', context: context);

  ProductModel? get productModel {
    _$_productModelAtom.reportRead();
    return super._productModel;
  }

  @override
  ProductModel? get _productModel => productModel;

  @override
  set _productModel(ProductModel? value) {
    _$_productModelAtom.reportWrite(value, super._productModel, () {
      super._productModel = value;
    });
  }

  late final _$_imagePatchAtom =
      Atom(name: 'ProductDatailControllerBase._imagePatch', context: context);

  String? get imagePatch {
    _$_imagePatchAtom.reportRead();
    return super._imagePatch;
  }

  @override
  String? get _imagePatch => imagePatch;

  @override
  set _imagePatch(String? value) {
    _$_imagePatchAtom.reportWrite(value, super._imagePatch, () {
      super._imagePatch = value;
    });
  }

  late final _$uploadImageProductAsyncAction = AsyncAction(
      'ProductDatailControllerBase.uploadImageProduct',
      context: context);

  @override
  Future<void> uploadImageProduct(Uint8List file, String fileName) {
    return _$uploadImageProductAsyncAction
        .run(() => super.uploadImageProduct(file, fileName));
  }

  late final _$loadProductAsyncAction =
      AsyncAction('ProductDatailControllerBase.loadProduct', context: context);

  @override
  Future<void> loadProduct(int? id) {
    return _$loadProductAsyncAction.run(() => super.loadProduct(id));
  }

  late final _$deleteProductAsyncAction = AsyncAction(
      'ProductDatailControllerBase.deleteProduct',
      context: context);

  @override
  Future<void> deleteProduct() {
    return _$deleteProductAsyncAction.run(() => super.deleteProduct());
  }

  late final _$saveAsyncAction =
      AsyncAction('ProductDatailControllerBase.save', context: context);

  @override
  Future<void> save(String name, double price, String description) {
    return _$saveAsyncAction.run(() => super.save(name, price, description));
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
