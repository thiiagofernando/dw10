// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:developer';

import 'package:dio/dio.dart';

import '../../core/exceptions/repository_exception.dart';
import '../../core/rest_client/costom_dio.dart';
import '../../models/user_model.dart';
import 'user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final CustomDio _dio;
  UserRepositoryImpl(
    this._dio,
  );
  @override
  Future<UserModel> getById(int id) async {
    try {
      final userResponse = await _dio.get('/users/$id');
      return UserModel.fromMap(userResponse.data);
    } on DioException catch (e, s) {
      log('Erro ao buscar o usuário', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar usuário');
    }
  }
}
