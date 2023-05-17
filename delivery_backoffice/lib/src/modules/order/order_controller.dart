// ignore_for_file: prefer_final_fields

import 'dart:developer';

import 'package:mobx/mobx.dart';

import '../../models/orders/order_model.dart';
import '../../models/orders/order_status.dart';
import '../../repositories/order/order_repository.dart';
part 'order_controller.g.dart';

enum OrderStateStatus {
  inital,
  loading,
  loaded,
  error,
}

class OrderController = OrderControllerBase with _$OrderController;

abstract class OrderControllerBase with Store {
  final OrderRepository _orderRepository;

  OrderControllerBase(this._orderRepository) {
    final todayNow = DateTime.now();
    _today = DateTime(todayNow.year, todayNow.month, todayNow.day);
  }

  @readonly
  var _status = OrderStateStatus.inital;

  @readonly
  String? _erroMessage;

  @readonly
  OrdermStatus? _statusFilter;

  @readonly
  var _orders = <OrderModel>[];

  late final DateTime _today;

  @action
  Future<void> findOrders() async {
    try {
      _status = OrderStateStatus.loading;
      _orders = await _orderRepository.findAllOrderns(_today, _statusFilter);
      _status = OrderStateStatus.loaded;
    } catch (e, s) {
      log('Erro ao buscar pedidos do dia', error: e, stackTrace: s);
      _status = OrderStateStatus.error;
      _erroMessage = 'Erro ao buscar pedidos do dia';
    }
  }
}
