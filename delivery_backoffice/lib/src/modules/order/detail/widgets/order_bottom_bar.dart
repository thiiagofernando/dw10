import 'package:flutter/material.dart';

import '../../../../core/ui/styles/text_styles.dart';

class OrderBottomBar extends StatelessWidget {
  const OrderBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OrderBottomBarButtom(
          buttomColor: Colors.blue,
          image: 'assets/images/icons/finish_order_white_ico.png',
          buttomLabel: 'Finalizar',
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            topLeft: Radius.circular(10),
          ),
        ),
        OrderBottomBarButtom(
          image: 'assets/images/icons/confirm_order_white_icon.png',
          buttomLabel: 'Confirmar',
          buttomColor: Colors.green,
          borderRadius: BorderRadius.zero,
        ),
        OrderBottomBarButtom(
          image: 'assets/images/icons/cancel_order_white_icon.png',
          buttomLabel: 'Cancelar',
          buttomColor: Colors.red,
          borderRadius: BorderRadius.only(
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
  const OrderBottomBarButtom({
    super.key,
    required this.borderRadius,
    required this.buttomColor,
    required this.image,
    required this.buttomLabel,
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
              color: buttomColor,
            ),
            backgroundColor: buttomColor,
          ),
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
              )
            ],
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
