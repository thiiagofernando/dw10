import 'dart:developer';

import 'package:dio/dio.dart';

import '../../core/exceptions/repository_exception.dart';
import '../../core/rest_client/costom_dio.dart';
import '../../models/product_model.dart';
import 'dart:typed_data';

import './product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final CustomDio _dio;

  ProductRepositoryImpl(this._dio);
  @override
  Future<void> deleteProdut(int id) async {
    try {
      await _dio.auth().put(
        '/products/$id',
        data: {'enabled': false},
      );
    } on DioException catch (e, s) {
      log('Erro ao Deletar Produto', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao Deletar Produto');
    }
  }

  @override
  Future<List<ProductModel>> findAll(String? name) async {
    try {
      final productResult = await _dio.auth().get(
        '/products',
        queryParameters: {
          if (name != null) 'name': name,
          'enabled': true,
        },
      );

      return productResult.data
          .map<ProductModel>(
            (p) => ProductModel.fromMap(p),
          )
          .toList();
    } on DioException catch (e, s) {
      log('Erro ao obter Produtos', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao obter Produtos');
    }
  }

  @override
  Future<ProductModel> getProdut(int id) async {
    try {
      final productResult = await _dio.auth().get(
            '/products/$id',
          );

      return ProductModel.fromMap(productResult.data);
    } on DioException catch (e, s) {
      log('Erro ao obter Produto', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao obter Produto');
    }
  }

  @override
  Future<void> save(ProductModel model) async {
    try {
      final client = _dio.auth();
      final productData = model.toMap();
      if (model.id != null) {
        await client.put(
          '/products/${model.id}',
          data: productData,
        );
      } else {
        await client.post(
          '/products/',
          data: productData,
        );
      }
    } on DioException catch (e, s) {
      log('Erro ao salvar Produto', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao salvar Produto');
    }
  }

  @override
  Future<String> uploadImageProduct(Uint8List file, String fileName) async {
    try {
      final formData = FormData.fromMap(
        {
          'file': MultipartFile.fromBytes(file, filename: fileName),
        },
      );
      final response = await _dio.auth().post('/uploads', data: formData);
      return response.data['url'];
    } on DioException catch (e, s) {
      log('Erro ao salvar Imagen', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao salvar Imagen');
    }
  }
}
