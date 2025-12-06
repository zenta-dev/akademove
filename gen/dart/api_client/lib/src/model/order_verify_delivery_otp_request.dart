//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'order_verify_delivery_otp_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OrderVerifyDeliveryOTPRequest {
  /// Returns a new [OrderVerifyDeliveryOTPRequest] instance.
  const OrderVerifyDeliveryOTPRequest({required this.otp});

  @JsonKey(name: r'otp', required: true, includeIfNull: false)
  final String otp;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderVerifyDeliveryOTPRequest && other.otp == otp;

  @override
  int get hashCode => otp.hashCode;

  factory OrderVerifyDeliveryOTPRequest.fromJson(Map<String, dynamic> json) =>
      _$OrderVerifyDeliveryOTPRequestFromJson(json);

  Map<String, dynamic> toJson() => _$OrderVerifyDeliveryOTPRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
