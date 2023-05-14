import 'dart:developer';
import 'dart:typed_data';

import 'package:mobx/mobx.dart';

import '../../../models/product_model.dart';
import '../../../repositories/products/product_repository.dart';
part 'product_datail_controller.g.dart';

enum ProductDatailsStateStatus {
  initial,
  loading,
  loaded,
  error,
  errorLoadProduct,
  deleted,
  uploaded,
  saved,
}

class ProductDatailController = ProductDatailControllerBase with _$ProductDatailController;

abstract class ProductDatailControllerBase with Store {
  final ProductRepository _productRepository;

  @readonly
  // ignore: prefer_final_fields
  var _status = ProductDatailsStateStatus.initial;

  @readonly
  String? _errorMessage;

  @readonly
  String? _imagePatch;
  ProductDatailControllerBase(this._productRepository);

  @action
  Future<void> uploadImageProduct(Uint8List file, String fileName) async {
    _status = ProductDatailsStateStatus.loading;
    _imagePatch = await _productRepository.uploadImageProduct(file, fileName);
    _status = ProductDatailsStateStatus.uploaded;
  }

  @action
  Future<void> save(String name, double price, String description) async {
    try {
      _status = ProductDatailsStateStatus.loading;
      final product = ProductModel(
        name: name,
        description: description,
        price: price,
        enabled: true,
        image: _imagePatch!,
      );

      await _productRepository.save(product);
      _status = ProductDatailsStateStatus.saved;
    } catch (e, s) {
      _status = ProductDatailsStateStatus.error;
      log('Erro ao salvar o Produto', error: e, stackTrace: s);
      _errorMessage = 'Erro ao salvar o Produto';
    }
  }
}
