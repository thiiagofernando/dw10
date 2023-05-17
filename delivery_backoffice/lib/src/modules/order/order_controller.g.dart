// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$OrderController on OrderControllerBase, Store {
  late final _$_statusAtom =
      Atom(name: 'OrderControllerBase._status', context: context);

  OrderStateStatus get status {
    _$_statusAtom.reportRead();
    return super._status;
  }

  @override
  OrderStateStatus get _status => status;

  @override
  set _status(OrderStateStatus value) {
    _$_statusAtom.reportWrite(value, super._status, () {
      super._status = value;
    });
  }

  late final _$_erroMessageAtom =
      Atom(name: 'OrderControllerBase._erroMessage', context: context);

  String? get erroMessage {
    _$_erroMessageAtom.reportRead();
    return super._erroMessage;
  }

  @override
  String? get _erroMessage => erroMessage;

  @override
  set _erroMessage(String? value) {
    _$_erroMessageAtom.reportWrite(value, super._erroMessage, () {
      super._erroMessage = value;
    });
  }

  late final _$_statusFilterAtom =
      Atom(name: 'OrderControllerBase._statusFilter', context: context);

  OrdermStatus? get statusFilter {
    _$_statusFilterAtom.reportRead();
    return super._statusFilter;
  }

  @override
  OrdermStatus? get _statusFilter => statusFilter;

  @override
  set _statusFilter(OrdermStatus? value) {
    _$_statusFilterAtom.reportWrite(value, super._statusFilter, () {
      super._statusFilter = value;
    });
  }

  late final _$_ordersAtom =
      Atom(name: 'OrderControllerBase._orders', context: context);

  List<OrderModel> get orders {
    _$_ordersAtom.reportRead();
    return super._orders;
  }

  @override
  List<OrderModel> get _orders => orders;

  @override
  set _orders(List<OrderModel> value) {
    _$_ordersAtom.reportWrite(value, super._orders, () {
      super._orders = value;
    });
  }

  late final _$findOrdersAsyncAction =
      AsyncAction('OrderControllerBase.findOrders', context: context);

  @override
  Future<void> findOrders() {
    return _$findOrdersAsyncAction.run(() => super.findOrders());
  }

  late final _$showDatailModalAsyncAction =
      AsyncAction('OrderControllerBase.showDatailModal', context: context);

  @override
  Future<void> showDatailModal(OrderModel model) {
    return _$showDatailModalAsyncAction.run(() => super.showDatailModal(model));
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
