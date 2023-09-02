import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../core/ui/helpers/loader.dart';
import '../../core/ui/helpers/messages.dart';
import '../../models/orders/order_item.dart';
import 'detail/order_detail_modal.dart';
import 'order_controller.dart';
import 'widgets/order_header.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with Loader, Messages {
  final controller = Modular.get<OrderController>();
  late final ReactionDisposer statusDisposer;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      statusDisposer = reaction((_) => controller.status, (status) {
        switch (status) {
          case OrderStateStatus.inital:
            break;
          case OrderStateStatus.loading:
            showLoader();
            break;
          case OrderStateStatus.loaded:
            hideLoader();
            break;
          case OrderStateStatus.error:
            hideLoader();
            showError(controller.erroMessage ?? 'Erro Interno');
            break;
          case OrderStateStatus.showDatailModal:
            hideLoader();
            showOrderDatail();
            break;
        }
      });
      controller.findOrders();
    });
  }

  void showOrderDatail() {
    showDialog(
      context: context,
      builder: (context) {
        return OrderDetailModal(
          controller: controller,
          order: controller.orderSelected!,
        );
      },
    );
  }

  @override
  void dispose() {
    statusDisposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          padding: const EdgeInsets.only(top: 40),
          child: Column(
            children: [
              const OrderHeader(),
              const SizedBox(
                height: 50,
              ),
              Expanded(
                child: Observer(
                  builder: (_) {
                    return GridView.builder(
                      itemCount: controller.orders.length,
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        mainAxisExtent: 91,
                        maxCrossAxisExtent: 600,
                      ),
                      itemBuilder: (context, index) {
                        return OrderItem(order: controller.orders[index]);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
