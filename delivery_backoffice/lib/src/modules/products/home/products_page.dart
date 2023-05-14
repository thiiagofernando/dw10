import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../core/ui/helpers/debouncer.dart';
import '../../../core/ui/helpers/loader.dart';
import '../../../core/ui/helpers/messages.dart';
import '../../../core/ui/widgets/base_header.dart';
import 'products.controller.dart';
import 'widgets/products_item.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> with Loader, Messages {
  final controller = Modular.get<ProductsController>();
  late final ReactionDisposer statusDisposer;
  final debouncer = Debouncer(milliseconds: 600);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      statusDisposer = reaction((_) => controller.status, (status) {
        switch (status) {
          case ProductStateStatus.initial:
            break;
          case ProductStateStatus.loading:
            showLoader();
            break;
          case ProductStateStatus.loaded:
            hideLoader();
            break;
          case ProductStateStatus.error:
            hideLoader();
            showError('Erro ao Buscar Produtos');
            break;
        }
      });
      controller.loadProducts();
    });
    super.initState();
  }

  @override
  void dispose() {
    statusDisposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[50],
      padding: const EdgeInsets.only(left: 40, top: 40, right: 30),
      child: Column(
        children: [
          BaseHeader(
            title: 'ADMINISTRAR PRODUTOS',
            buttomLabel: 'ADICIONAR',
            searchChange: (value) {
              debouncer.call(() {
                controller.filterByName(value);
              });
            },
            buttomPressed: () async {
              await Modular.to.pushNamed('/products/datail');
              controller.loadProducts();
            },
          ),
          const SizedBox(
            height: 50,
          ),
          Expanded(
            child: Observer(
              builder: (_) {
                return GridView.builder(
                  itemCount: controller.products.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    mainAxisExtent: 280,
                    mainAxisSpacing: 20,
                    maxCrossAxisExtent: 280,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return ProductsItem(product: controller.products[index]);
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
