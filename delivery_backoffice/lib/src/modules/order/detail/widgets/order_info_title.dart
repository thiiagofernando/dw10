import 'package:flutter/material.dart';

import '../../../../core/ui/styles/text_styles.dart';

class OrderInfoTitle extends StatelessWidget {
  final String label;
  final String info;
  const OrderInfoTitle({super.key, required this.label, required this.info});

  @override
  Widget build(BuildContext context) {
    final styles = context.textStyles;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label, style: styles.textBold),
          const SizedBox(
            width: 10,
          ),
          Text(info, style: styles.textMediun),
        ],
      ),
    );
  }
}
