import '../../models/orders/order_model.dart';
import '../../models/orders/order_status.dart';

abstract class OrderRepository {
  Future<List<OrderModel>> findAllOrderns(DateTime date, OrdermStatus? status);
  Future<OrderModel> getById(int id);
  Future<void> changeStatus(int id, OrdermStatus status);
}
