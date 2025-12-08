import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';
import 'package:equatable/equatable.dart';

class MerchantOrderState extends Equatable {
  const MerchantOrderState({
    this.orders = const OperationResult.idle(),
    this.order = const OperationResult.idle(),
  });

  final OperationResult<List<Order>> orders;
  final OperationResult<Order> order;

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [orders, order];

  MerchantOrderState copyWith({
    OperationResult<List<Order>>? orders,
    OperationResult<Order>? order,
  }) {
    return MerchantOrderState(
      orders: orders ?? this.orders,
      order: order ?? this.order,
    );
  }
}
