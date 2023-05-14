import 'dart:typed_data';

import '../../models/product_model.dart';

abstract class ProductRepository {
  Future<List<ProductModel>> findAll(String? name);
  Future<ProductModel> getProdut(int id);
  Future<void> save(ProductModel model);
  Future<String> uploadImageProduct(Uint8List file, String fileName);
  Future<void> deleteProdut(int id);
}
