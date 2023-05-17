import 'package:flutter/material.dart';

import '../../../core/ui/widgets/base_header.dart';
import '../../../models/orders/order_status.dart';

class OrderHeader extends StatefulWidget {
  const OrderHeader({super.key});

  @override
  State<OrderHeader> createState() => _OrderHeaderState();
}

class _OrderHeaderState extends State<OrderHeader> {
  OrdermStatus? statusSelecionado;
  @override
  Widget build(BuildContext context) {
    return BaseHeader(
      title: 'Pedidos do Dia',
      addButtom: false,
      filterWidget: DropdownButton<OrdermStatus>(
        value: statusSelecionado,
        items: [
          const DropdownMenuItem(value: null, child: Text('Todos')),
          ...OrdermStatus.values.map((s) => DropdownMenuItem(value: s, child: Text(s.name))).toList()
        ],
        onChanged: (value) {
          setState(() {
            statusSelecionado = value;
          });
        },
      ),
    );
  }
}
