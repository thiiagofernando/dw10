import 'dart:developer';

import 'package:mobx/mobx.dart';
import '../../../models/payment_type_model.dart';
import '../../../repositories/payment-type/payment_type_repositories.dart';
part 'payment_type_controller.g.dart';

enum PaymentTypeStateStatus {
  inital,
  loading,
  loaded,
  error,
  addOrUpdatePayment,
  saved,
}

class PaymentTypeController = PaymentTypeControllerBase with _$PaymentTypeController;

abstract class PaymentTypeControllerBase with Store {
  final PaymentTypeRepositories _paymentTypeRepositories;

  @readonly
  var _status = PaymentTypeStateStatus.inital;

  @readonly
  var _paymentTypes = <PaymentTypeModel>[];

  @readonly
  String? _errorMessage;

  @readonly
  bool? _filteEnabled;

  @readonly
  PaymentTypeModel? _paymentTypeSelected;

  PaymentTypeControllerBase(this._paymentTypeRepositories);

  @action
  void changeFilter(bool? enabled) => _filteEnabled = enabled;

  @action
  Future<void> loadiPayments() async {
    try {
      _status = PaymentTypeStateStatus.loading;
      _paymentTypes = await _paymentTypeRepositories.findAll(_filteEnabled);
      _status = PaymentTypeStateStatus.loaded;
    } catch (e, s) {
      log('Erro ao carregas as formas de pagamento', error: e, stackTrace: s);
      _status = PaymentTypeStateStatus.error;
      _errorMessage = 'Erro ao carregas as formas de pagamento';
    }
  }

  @action
  Future<void> addPayment() async {
    _status = PaymentTypeStateStatus.loaded;
    await Future.delayed(Duration.zero);
    _paymentTypeSelected = null;
    _status = PaymentTypeStateStatus.addOrUpdatePayment;
  }

  @action
  Future<void> editPayment(PaymentTypeModel paymentTypeModel) async {
    _status = PaymentTypeStateStatus.loaded;
    await Future.delayed(Duration.zero);
    _paymentTypeSelected = paymentTypeModel;
    _status = PaymentTypeStateStatus.addOrUpdatePayment;
  }

  @action
  Future<void> savePayment({
    int? id,
    required String name,
    required String acronym,
    required bool enabled,
  }) async {
    _status = PaymentTypeStateStatus.loaded;
    final PaymentTypeModel model = PaymentTypeModel(id: id, name: name, acronym: acronym, enabled: enabled);
    await _paymentTypeRepositories.save(model);
    _status = PaymentTypeStateStatus.saved;
  }
}
