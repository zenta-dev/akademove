import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';
import 'package:equatable/equatable.dart';

class MerchantOrderState extends Equatable {
  const MerchantOrderState({
    this.orders = const OperationResult.idle(),
    this.order = const OperationResult.idle(),
    this.isMerchantWsConnected = false,
    this.incomingOrder,
  });

  final OperationResult<List<Order>> orders;
  final OperationResult<Order> order;

  /// Whether the merchant WebSocket for incoming orders is connected
  final bool isMerchantWsConnected;

  /// Incoming order that should trigger the incoming order dialog
  final Order? incomingOrder;

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
    orders,
    order,
    isMerchantWsConnected,
    incomingOrder,
  ];

  MerchantOrderState copyWith({
    OperationResult<List<Order>>? orders,
    OperationResult<Order>? order,
    bool? isMerchantWsConnected,
    Order? incomingOrder,
    bool clearIncomingOrder = false,
  }) {
    return MerchantOrderState(
      orders: orders ?? this.orders,
      order: order ?? this.order,
      isMerchantWsConnected:
          isMerchantWsConnected ?? this.isMerchantWsConnected,
      incomingOrder: clearIncomingOrder
          ? null
          : (incomingOrder ?? this.incomingOrder),
    );
  }
}
