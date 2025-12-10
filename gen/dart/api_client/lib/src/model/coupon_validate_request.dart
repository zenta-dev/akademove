//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/order_type.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'coupon_validate_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CouponValidateRequest {
  /// Returns a new [CouponValidateRequest] instance.
  const CouponValidateRequest({
    required this.code,
    required this.orderAmount,
    this.serviceType,
    this.merchantId,
  });
  @JsonKey(name: r'code', required: true, includeIfNull: true)
  final String? code;

  @JsonKey(name: r'orderAmount', required: true, includeIfNull: false)
  final num orderAmount;

  @JsonKey(name: r'serviceType', required: false, includeIfNull: false)
  final OrderType? serviceType;

  @JsonKey(name: r'merchantId', required: false, includeIfNull: false)
  final String? merchantId;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CouponValidateRequest &&
          other.code == code &&
          other.orderAmount == orderAmount &&
          other.serviceType == serviceType &&
          other.merchantId == merchantId;

  @override
  int get hashCode =>
      (code == null ? 0 : code.hashCode) +
      orderAmount.hashCode +
      serviceType.hashCode +
      (merchantId == null ? 0 : merchantId.hashCode);

  factory CouponValidateRequest.fromJson(Map<String, dynamic> json) =>
      _$CouponValidateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CouponValidateRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
