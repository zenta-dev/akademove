//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'order_verify_delivery_otp200_response_data.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OrderVerifyDeliveryOTP200ResponseData {
  /// Returns a new [OrderVerifyDeliveryOTP200ResponseData] instance.
  const OrderVerifyDeliveryOTP200ResponseData({required this.verified});

  @JsonKey(name: r'verified', required: true, includeIfNull: false)
  final bool verified;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderVerifyDeliveryOTP200ResponseData &&
          other.verified == verified;

  @override
  int get hashCode => verified.hashCode;

  factory OrderVerifyDeliveryOTP200ResponseData.fromJson(
    Map<String, dynamic> json,
  ) => _$OrderVerifyDeliveryOTP200ResponseDataFromJson(json);

  Map<String, dynamic> toJson() =>
      _$OrderVerifyDeliveryOTP200ResponseDataToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
