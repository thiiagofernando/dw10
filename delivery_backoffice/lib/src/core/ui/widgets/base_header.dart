// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../styles/text_styles.dart';

class BaseHeader extends StatelessWidget {
  final String title;
  final ValueChanged<String>? searchChange;
  final String buttomLabel;
  final VoidCallback? buttomPressed;
  final bool addButtom;
  final Widget? filterWidget;
  const BaseHeader({
    Key? key,
    required this.title,
    this.searchChange,
    required this.buttomLabel,
    this.buttomPressed,
    this.addButtom = true,
    this.filterWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        return Wrap(
          children: [
            Visibility(
              visible: filterWidget == null,
              replacement: filterWidget ?? const SizedBox.shrink(),
              child: SizedBox(
                width: constraints.maxWidth * .15,
                child: TextFormField(
                  onChanged: searchChange,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    prefixIcon: Icon(
                      Icons.search,
                      size: constraints.maxWidth * 0.02,
                    ),
                    label: Text(
                      'Buscar',
                      style: context.textStyles.textRegular.copyWith(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              width: constraints.maxWidth * .65,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: context.textStyles.textTitle.copyWith(
                  decoration: TextDecoration.underline,
                  decorationThickness: 2,
                ),
              ),
            ),
            Visibility(
              visible: addButtom,
              child: SizedBox(
                height: 40,
                width: constraints.maxWidth * .17,
                child: FittedBox(
                  child: OutlinedButton.icon(
                    onPressed: buttomPressed,
                    icon: Icon(
                      Icons.add,
                      size: constraints.maxWidth * 0.02,
                    ),
                    label: Text(buttomLabel),
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
