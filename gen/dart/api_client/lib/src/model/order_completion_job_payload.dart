//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/driver_matching_job_payload_pickup_location.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'order_completion_job_payload.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OrderCompletionJobPayload {
  /// Returns a new [OrderCompletionJobPayload] instance.
  const OrderCompletionJobPayload({
    required this.orderId,
    required this.driverId,
    required this.driverUserId,
    required this.totalPrice,
    required this.orderType,
    required this.commissionRate,
    this.driverCurrentLocation,
  });
  @JsonKey(name: r'orderId', required: true, includeIfNull: false)
  final String orderId;

  @JsonKey(name: r'driverId', required: true, includeIfNull: false)
  final String driverId;

  @JsonKey(name: r'driverUserId', required: true, includeIfNull: false)
  final String driverUserId;

  @JsonKey(name: r'totalPrice', required: true, includeIfNull: false)
  final num totalPrice;

  @JsonKey(name: r'orderType', required: true, includeIfNull: false)
  final OrderCompletionJobPayloadOrderTypeEnum orderType;

  // minimum: 0
  // maximum: 1
  @JsonKey(name: r'commissionRate', required: true, includeIfNull: false)
  final num commissionRate;

  @JsonKey(
    name: r'driverCurrentLocation',
    required: false,
    includeIfNull: false,
  )
  final DriverMatchingJobPayloadPickupLocation? driverCurrentLocation;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderCompletionJobPayload &&
          other.orderId == orderId &&
          other.driverId == driverId &&
          other.driverUserId == driverUserId &&
          other.totalPrice == totalPrice &&
          other.orderType == orderType &&
          other.commissionRate == commissionRate &&
          other.driverCurrentLocation == driverCurrentLocation;

  @override
  int get hashCode =>
      orderId.hashCode +
      driverId.hashCode +
      driverUserId.hashCode +
      totalPrice.hashCode +
      orderType.hashCode +
      commissionRate.hashCode +
      driverCurrentLocation.hashCode;

  factory OrderCompletionJobPayload.fromJson(Map<String, dynamic> json) =>
      _$OrderCompletionJobPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$OrderCompletionJobPayloadToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum OrderCompletionJobPayloadOrderTypeEnum {
  @JsonValue(r'RIDE')
  RIDE(r'RIDE'),
  @JsonValue(r'DELIVERY')
  DELIVERY(r'DELIVERY'),
  @JsonValue(r'FOOD')
  FOOD(r'FOOD');

  const OrderCompletionJobPayloadOrderTypeEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
