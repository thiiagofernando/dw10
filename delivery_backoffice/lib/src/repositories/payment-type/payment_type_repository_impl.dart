import 'dart:developer';

import 'package:dio/dio.dart';

import '../../core/exceptions/repository_exception.dart';
import '../../core/rest_client/costom_dio.dart';
import '../../models/payment_type_model.dart';
import 'payment_type_repository.dart';

class PaymentTypeRepositoryImpl implements PaymentTypeRepository {
  final CustomDio _dio;

  PaymentTypeRepositoryImpl(this._dio);
  @override
  Future<List<PaymentTypeModel>> findAll(bool? enabled) async {
    try {
      final paymentResult = await _dio.auth().get(
        '/payment-types',
        queryParameters: {
          if (enabled != null) 'enabled': enabled,
        },
      );

      return paymentResult.data
          .map<PaymentTypeModel>(
            (p) => PaymentTypeModel.fromMap(p),
          )
          .toList();
    } on DioException catch (e, s) {
      log('Erro ao buscar formas de pagamento', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar formas de pagamento');
    }
  }

  @override
  Future<PaymentTypeModel> getByI(int id) async {
    try {
      final paymentResult = await _dio.auth().get(
            '/payment-types/$id',
          );

      return PaymentTypeModel.fromMap(paymentResult.data);
    } on DioException catch (e, s) {
      log('Erro ao buscar forma de pagamento $id', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar forma de pagamento $id');
    }
  }

  @override
  Future<void> save(PaymentTypeModel model) async {
    try {
      final client = _dio.auth();
      if (model.id != null) {
        await client.put(
          '/payment-types/${model.id}',
          data: model.toJson(),
        );
      } else {
        await client.post(
          '/payment-types/',
          data: model.toJson(),
        );
      }
    } on DioException catch (e, s) {
      log('Erro ao salvar forma de pagamento ', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao salvar forma de pagamento ');
    }
  }
}
