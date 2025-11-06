//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/order.dart';
import 'package:api_client/src/model/payment.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'place_order_response.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PlaceOrderResponse {
  /// Returns a new [PlaceOrderResponse] instance.
  const PlaceOrderResponse({required this.order, required this.payment});

  @JsonKey(name: r'order', required: true, includeIfNull: false)
  final Order order;

  @JsonKey(name: r'payment', required: true, includeIfNull: false)
  final Payment payment;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlaceOrderResponse &&
          other.order == order &&
          other.payment == payment;

  @override
  int get hashCode => order.hashCode + payment.hashCode;

  factory PlaceOrderResponse.fromJson(Map<String, dynamic> json) =>
      _$PlaceOrderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceOrderResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
