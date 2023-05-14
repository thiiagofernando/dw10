import 'package:flutter_modular/flutter_modular.dart';

import '../../core/rest_client/costom_dio.dart';
import '../../core/storage/session_storage.dart';
import '../../core/storage/storage.dart';
import '../../repositories/payment-type/payment_type_repositories.dart';
import '../../repositories/payment-type/payment_type_repositories_impl.dart';

class CoreModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton<Storage>((i) => SessionStorage(), export: true),
        Bind.lazySingleton((i) => CustomDio(i()), export: true),
        Bind.lazySingleton<PaymentTypeRepositories>((i) => PaymentTypeRepositoriesImpl(i()), export: true),
      ];
}
