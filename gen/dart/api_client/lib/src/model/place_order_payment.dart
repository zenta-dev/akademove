//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/payment_provider.dart';
import 'package:api_client/src/model/payment_method.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'place_order_payment.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PlaceOrderPayment {
  /// Returns a new [PlaceOrderPayment] instance.
  const PlaceOrderPayment({required this.method, required this.provider});

  @JsonKey(name: r'method', required: true, includeIfNull: false)
  final PaymentMethod method;

  @JsonKey(name: r'provider', required: true, includeIfNull: false)
  final PaymentProvider provider;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlaceOrderPayment &&
          other.method == method &&
          other.provider == provider;

  @override
  int get hashCode => method.hashCode + provider.hashCode;

  factory PlaceOrderPayment.fromJson(Map<String, dynamic> json) =>
      _$PlaceOrderPaymentFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceOrderPaymentToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
