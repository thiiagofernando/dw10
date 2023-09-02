import 'package:flutter/material.dart';

import '../../../core/extensions/formatter_extensions.dart';
import '../../../core/ui/helpers/size_extensions.dart';
import '../../../core/ui/styles/text_styles.dart';
import '../../../dto/order/order_dto.dart';
import '../order_controller.dart';
import 'widgets/order_bottom_bar.dart';
import 'widgets/order_info_title.dart';
import 'widgets/order_product_item.dart';

class OrderDetailModal extends StatefulWidget {
  final OrderController controller;
  final OrderDto order;
  const OrderDetailModal({
    super.key,
    required this.controller,
    required this.order,
  });

  @override
  State<OrderDetailModal> createState() => _OrderDetailModalState();
}

class _OrderDetailModalState extends State<OrderDetailModal> {
  void _closeModal() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final styles = context.textStyles;
    final screenWidth = context.screenWidth;
    return Material(
      color: Colors.black26,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: Colors.white,
        elevation: 10,
        child: Container(
          width: screenWidth * (screenWidth > 1200 ? .5 : .7),
          padding: const EdgeInsets.all(30),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Detalhes do Pedido ${widget.order.id}',
                        style: context.textStyles.textTitle,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        onPressed: _closeModal,
                        icon: const Icon(Icons.close),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text('Nome do Cliente', style: context.textStyles.textBold),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(widget.order.user.name, style: context.textStyles.textRegular),
                  ],
                ),
                const Divider(),
                ...widget.order.orderProduct
                    .map(
                      (op) => OrderProductItem(
                        orderProduct: op,
                      ),
                    )
                    .toList(),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total do Pedido',
                        style: styles.textExtraBold.copyWith(fontSize: 18),
                      ),
                      Text(
                        widget.order.orderProduct
                            .fold<double>(
                              0.0,
                              (preveiewsValuie, p) => preveiewsValuie + p.totalPrice,
                            )
                            .currencyPTBR,
                        style: styles.textExtraBold.copyWith(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                OrderInfoTitle(
                  label: 'Endereço de Entrega:',
                  info: widget.order.address,
                ),
                const Divider(),
                OrderInfoTitle(
                  label: 'Pagamento:',
                  info: widget.order.paymentTypeModel.name,
                ),
                const SizedBox(
                  height: 10,
                ),
                OrderBottomBar(controller: widget.controller, order: widget.order),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
