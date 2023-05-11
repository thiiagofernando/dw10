import '../../models/payment_type_model.dart';

abstract class PaymentTypeRepositories {
  Future<List<PaymentTypeModel>> findAll(bool? enabled);
  Future<void> save(PaymentTypeModel model);
  Future<PaymentTypeModel> getByI(int id);
}
