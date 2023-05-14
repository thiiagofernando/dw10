import 'package:flutter_modular/flutter_modular.dart';

import 'datail/product_datail_controller.dart';
import 'datail/product_datail_page.dart';
import 'home/products.controller.dart';
import 'home/products_page.dart';

class ProductsModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton((i) => ProductsController(i())),
        Bind.lazySingleton((i) => ProductDatailController(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const ProductsPage()),
        ChildRoute(
          '/datail',
          child: (context, args) => const ProductDatailPage(
            productId: null,
          ),
        ),
      ];
}
