// ignore_for_file: prefer_final_fields

import 'dart:developer';

import 'package:mobx/mobx.dart';

import '../../dto/order/order_dto.dart';
import '../../models/orders/order_model.dart';
import '../../models/orders/order_status.dart';
import '../../repositories/order/order_repository.dart';
import '../../services/order/get_order_by_id.dart';
part 'order_controller.g.dart';

enum OrderStateStatus { inital, loading, loaded, error, showDatailModal, statusChanged }

class OrderController = OrderControllerBase with _$OrderController;

abstract class OrderControllerBase with Store {
  final OrderRepository _orderRepository;
  final GetOrderById _getOrderById;

  OrderControllerBase(this._orderRepository, this._getOrderById) {
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
  OrderDto? _orderSelected;

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

  @action
  void changeStatusFilter(OrdermStatus? status) {
    _statusFilter = status;
    findOrders();
  }

  @action
  Future<void> showDatailModal(OrderModel model) async {
    _status = OrderStateStatus.loading;
    _orderSelected = await _getOrderById(model);
    _status = OrderStateStatus.showDatailModal;
  }

  @action
  Future<void> changeStatus(OrdermStatus status) async {
    _status = OrderStateStatus.loaded;
    await _orderRepository.changeStatus(_orderSelected!.id, status);
    _status = OrderStateStatus.statusChanged;
  }
}
