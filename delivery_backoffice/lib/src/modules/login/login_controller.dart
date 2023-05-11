import 'dart:developer';

import 'package:mobx/mobx.dart';
import '../../core/exceptions/unauthorized_exeption.dart';
import '../../services/auth/login_service.dart';
part 'login_controller.g.dart';

enum LoginStateStatus {
  initial,
  loading,
  success,
  errror;
}

class LoginController = LoginControllerBase with _$LoginController;

abstract class LoginControllerBase with Store {
  final LoginService _loginService;

  @readonly
  String? _errorMessage;

  @readonly
  var _loginStatus = LoginStateStatus.initial;

  LoginControllerBase(this._loginService);

  @action
  Future<void> login(String email, String password) async {
    try {
      _loginStatus = LoginStateStatus.loading;
      await _loginService.execute(email, password);
      _loginStatus = LoginStateStatus.success;
    } on UnauthorizedExeption {
      _errorMessage = 'Login ou senha inválidos';
      _loginStatus = LoginStateStatus.errror;
    } catch (e, s) {
      log('Erro ao realizar login', error: e, stackTrace: s);
      _errorMessage = 'Tente novamente mais tarde';
      _loginStatus = LoginStateStatus.errror;
    }
  }
}
