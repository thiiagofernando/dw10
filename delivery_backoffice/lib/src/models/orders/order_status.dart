import 'package:flutter/material.dart';

enum OrdermStatus {
  pendente('Pendente', 'P', Colors.blue),
  confirmado('Confirmado', 'C', Colors.green),
  finalizado('Finalizado', 'F', Colors.black),
  cancelado('Cancelado', 'R', Colors.red);

  final String name;
  final String acronym;
  final Color color;

  const OrdermStatus(this.name, this.acronym, this.color);

  static OrdermStatus parse(String acronym) {
    return values.firstWhere((element) => element.acronym == acronym);
  }
}
