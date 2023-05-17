import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/ui/styles/text_styles.dart';
import '../../modules/order/order_controller.dart';
import 'order_model.dart';

class OrderItem extends StatelessWidget {
  final OrderModel order;
  const OrderItem({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final textStyles = context.textStyles;
    return InkWell(
      onTap: () {
        context.read<OrderController>().showDatailModal(order);
      },
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Text('Pedido ', style: textStyles.textExtraBold),
                    Text(
                      order.id.toString(),
                      style: textStyles.textExtraBold,
                    ),
                    Expanded(
                      child: Text(
                        order.status.name,
                        textAlign: TextAlign.end,
                        style: textStyles.textExtraBold.copyWith(fontSize: 20, color: order.status.color),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                      height: double.infinity,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const VerticalDivider(
            thickness: 1,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
