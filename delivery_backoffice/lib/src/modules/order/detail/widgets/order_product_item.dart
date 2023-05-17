import 'package:flutter/material.dart';

import '../../../../core/extensions/formatter_extensions.dart';
import '../../../../core/ui/styles/text_styles.dart';

class OrderProductItem extends StatelessWidget {
  const OrderProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    final styles = context.textStyles;
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(child: Text('X-Tudão', style: styles.textRegular)),
          Text('1', style: styles.textRegular),
          Expanded(
            child: Text(
              100.0.currencyPTBR,
              textAlign: TextAlign.right,
              style: styles.textRegular,
            ),
          ),
        ],
      ),
    );
  }
}
