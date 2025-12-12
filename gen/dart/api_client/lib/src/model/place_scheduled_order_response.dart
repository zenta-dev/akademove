//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/place_order_response_auto_applied_coupon.dart';
import 'package:api_client/src/model/transaction.dart';
import 'package:api_client/src/model/order.dart';
import 'package:api_client/src/model/payment.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'place_scheduled_order_response.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PlaceScheduledOrderResponse {
  /// Returns a new [PlaceScheduledOrderResponse] instance.
  const PlaceScheduledOrderResponse({
    required this.order,
    required this.payment,
    required this.transaction,
    this.autoAppliedCoupon,
  });
  @JsonKey(name: r'order', required: true, includeIfNull: false)
  final Order order;

  @JsonKey(name: r'payment', required: true, includeIfNull: false)
  final Payment payment;

  @JsonKey(name: r'transaction', required: true, includeIfNull: false)
  final Transaction transaction;

  @JsonKey(name: r'autoAppliedCoupon', required: false, includeIfNull: false)
  final PlaceOrderResponseAutoAppliedCoupon? autoAppliedCoupon;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlaceScheduledOrderResponse &&
          other.order == order &&
          other.payment == payment &&
          other.transaction == transaction &&
          other.autoAppliedCoupon == autoAppliedCoupon;

  @override
  int get hashCode =>
      order.hashCode +
      payment.hashCode +
      transaction.hashCode +
      autoAppliedCoupon.hashCode;

  factory PlaceScheduledOrderResponse.fromJson(Map<String, dynamic> json) =>
      _$PlaceScheduledOrderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceScheduledOrderResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
