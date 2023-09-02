import 'dart:developer';

import '../../dto/order/order_dto.dart';
import '../../dto/order/order_product_dto.dart';
import '../../models/orders/order_model.dart';
import '../../models/payment_type_model.dart';
import '../../models/user_model.dart';
import '../../repositories/payment-type/payment_type_repository.dart';
import '../../repositories/products/product_repository.dart';
import '../../repositories/user/user_repository.dart';
import 'get_order_by_id.dart';

class GetOrderByIdImpl extends GetOrderById {
  final PaymentTypeRepository _paymentTypeRepository;
  final UserRepository _userRepository;
  final ProductRepository _productRepository;
  GetOrderByIdImpl(
    this._paymentTypeRepository,
    this._userRepository,
    this._productRepository,
  );
  @override
  Future<OrderDto> call(OrderModel order) => orderDtoParse(order);

  Future<OrderDto> orderDtoParse(OrderModel order) async {
    final paymentTypeFuture = _paymentTypeRepository.getByI(order.paymentTypeId);
    final userFuture = _userRepository.getById(order.userId);
    final orderProductFuture = orderProductParse(order);

    final responses = await Future.wait([paymentTypeFuture, userFuture, orderProductFuture]);

    return OrderDto(
      id: order.id,
      date: order.date,
      status: order.status,
      orderProduct: responses[2] as List<OrderProductDto>,
      user: responses[1] as UserModel,
      address: order.address,
      cpf: order.cpf,
      paymentTypeModel: responses[0] as PaymentTypeModel,
    );
  }

  Future<List<OrderProductDto>> orderProductParse(OrderModel order) async {
    try {
      final orderProducts = <OrderProductDto>[];

      final productsFuture = order.orderProducts.map((e) => _productRepository.getProdut(e.id)).toList();
      final products = await Future.wait(productsFuture);

      for (var i = 0; i < order.orderProducts.length; i++) {
        final orderProduct = order.orderProducts[i];
        final productDto = OrderProductDto(
          product: products[i],
          amout: orderProduct.amount,
          totalPrice: orderProduct.totalPrice,
        );
        orderProducts.add(productDto);
      }

      return orderProducts;
    } on Exception catch (e) {
      log('Erro $e');
      throw Exception(e);
    }
  }
}
