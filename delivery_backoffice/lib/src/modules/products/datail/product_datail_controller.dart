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
  ProductModel? _productModel;

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
  Future<void> loadProduct(int? id) async {
    try {
      _status = ProductDatailsStateStatus.loading;
      _productModel = null;
      _imagePatch = null;
      if (id != null) {
        _productModel = await _productRepository.getProdut(id);
        _imagePatch = _productModel!.image;
      }
      _status = ProductDatailsStateStatus.loaded;
    } catch (e, s) {
      log('Erro ao carregar produto', error: e, stackTrace: s);
      _status = ProductDatailsStateStatus.errorLoadProduct;
      _errorMessage = 'Erro ao carregar produto ';
    }
  }

  @action
  Future<void> deleteProduct() async {
    try {
      _status = ProductDatailsStateStatus.loading;
      if (_productModel != null && _productModel!.id != null) {
        await _productRepository.deleteProdut(_productModel!.id!);
        _status = ProductDatailsStateStatus.deleted;
      } else {
        await Future.delayed(Duration.zero);
        _status = ProductDatailsStateStatus.error;
        _errorMessage = 'Produto não cadastrado, não é permitido deletar o produto ';
      }
    } catch (e, s) {
      log('Erro ao deletar produto', error: e, stackTrace: s);
      _status = ProductDatailsStateStatus.errorLoadProduct;
      _errorMessage = 'Erro ao deletar produto ';
    }
  }

  @action
  Future<void> save(String name, double price, String description) async {
    try {
      _status = ProductDatailsStateStatus.loading;
      final product = ProductModel(
        id: _productModel?.id,
        name: name,
        description: description,
        price: price,
        enabled: _productModel?.enabled ?? true,
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
