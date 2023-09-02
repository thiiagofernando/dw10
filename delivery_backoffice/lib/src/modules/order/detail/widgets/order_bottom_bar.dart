import 'package:flutter/material.dart';

import '../../../../core/ui/styles/text_styles.dart';
import '../../../../dto/order/order_dto.dart';
import '../../../../models/orders/order_status.dart';
import '../../order_controller.dart';

class OrderBottomBar extends StatelessWidget {
  final OrderController controller;
  final OrderDto order;
  const OrderBottomBar({super.key, required this.controller, required this.order});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OrderBottomBarButtom(
          buttomColor: Colors.blue,
          image: 'assets/images/icons/finish_order_white_ico.png',
          buttomLabel: 'Finalizar',
          onPress: order.status == OrdermStatus.confirmado
              ? () {
                  controller.changeStatus(OrdermStatus.finalizado);
                }
              : null,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(10),
            topLeft: Radius.circular(10),
          ),
        ),
        OrderBottomBarButtom(
          image: 'assets/images/icons/confirm_order_white_icon.png',
          buttomLabel: 'Confirmar',
          buttomColor: Colors.green,
          borderRadius: BorderRadius.zero,
          onPress: order.status == OrdermStatus.pendente
              ? () {
                  controller.changeStatus(OrdermStatus.confirmado);
                }
              : null,
        ),
        OrderBottomBarButtom(
          image: 'assets/images/icons/cancel_order_white_icon.png',
          buttomLabel: 'Cancelar',
          buttomColor: Colors.red,
          onPress: order.status != OrdermStatus.cancelado && order.status != OrdermStatus.finalizado
              ? () {
                  controller.changeStatus(OrdermStatus.cancelado);
                }
              : null,
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
      ],
    );
  }
}

class OrderBottomBarButtom extends StatelessWidget {
  final BorderRadius borderRadius;
  final Color buttomColor;
  final String image;
  final String buttomLabel;
  final VoidCallback? onPress;
  const OrderBottomBarButtom({
    super.key,
    required this.borderRadius,
    required this.buttomColor,
    required this.image,
    required this.buttomLabel,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.tight,
      child: SizedBox(
        height: 60,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: borderRadius,
            ),
            side: BorderSide(
              color: onPress != null ? buttomColor : Colors.transparent,
            ),
            backgroundColor: buttomColor,
          ),
          onPressed: onPress,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(image),
              const SizedBox(
                width: 5,
              ),
              Text(
                buttomLabel,
                style: context.textStyles.textBold.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
