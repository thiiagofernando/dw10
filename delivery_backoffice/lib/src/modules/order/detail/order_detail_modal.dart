import 'package:flutter/material.dart';

import '../../../core/extensions/formatter_extensions.dart';
import '../../../core/ui/helpers/size_extensions.dart';
import '../../../core/ui/styles/text_styles.dart';
import 'widgets/order_bottom_bar.dart';
import 'widgets/order_info_title.dart';
import 'widgets/order_product_item.dart';

class OrderDetailModal extends StatefulWidget {
  const OrderDetailModal({super.key});

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
                        'Detalhes do Pedido',
                        style: context.textStyles.textTitle,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        onPressed: _closeModal,
                        icon: const Icon(Icons.close),
                      ),
                    )
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
                    Text('Thiago Fernando', style: context.textStyles.textRegular),
                  ],
                ),
                const Divider(),
                ...List.generate(3, (index) => index).map((e) => const OrderProductItem()).toList(),
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
                        300.0.currencyPTBR,
                        style: styles.textExtraBold.copyWith(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                const OrderInfoTitle(
                  label: 'Endereço de Entreda:',
                  info: 'Rua 10, casa 13',
                ),
                const Divider(),
                const OrderInfoTitle(
                  label: 'Pagamento:',
                  info: 'Cartão de Crédito',
                ),
                const SizedBox(
                  height: 10,
                ),
                const OrderBottomBar()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
