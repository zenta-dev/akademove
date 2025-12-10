//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'driver_metrics_job_payload.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DriverMetricsJobPayload {
  /// Returns a new [DriverMetricsJobPayload] instance.
  const DriverMetricsJobPayload({
    required this.driverId,
    required this.orderId,
    required this.metricsType,
    this.value,
  });
  @JsonKey(name: r'driverId', required: true, includeIfNull: false)
  final String driverId;

  @JsonKey(name: r'orderId', required: true, includeIfNull: false)
  final String orderId;

  @JsonKey(name: r'metricsType', required: true, includeIfNull: false)
  final DriverMetricsJobPayloadMetricsTypeEnum metricsType;

  @JsonKey(name: r'value', required: false, includeIfNull: false)
  final num? value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DriverMetricsJobPayload &&
          other.driverId == driverId &&
          other.orderId == orderId &&
          other.metricsType == metricsType &&
          other.value == value;

  @override
  int get hashCode =>
      driverId.hashCode +
      orderId.hashCode +
      metricsType.hashCode +
      value.hashCode;

  factory DriverMetricsJobPayload.fromJson(Map<String, dynamic> json) =>
      _$DriverMetricsJobPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$DriverMetricsJobPayloadToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum DriverMetricsJobPayloadMetricsTypeEnum {
  @JsonValue(r'ORDER_COMPLETED')
  ORDER_COMPLETED(r'ORDER_COMPLETED'),
  @JsonValue(r'ORDER_CANCELLED')
  ORDER_CANCELLED(r'ORDER_CANCELLED'),
  @JsonValue(r'RATING_RECEIVED')
  RATING_RECEIVED(r'RATING_RECEIVED'),
  @JsonValue(r'NO_SHOW_REPORTED')
  NO_SHOW_REPORTED(r'NO_SHOW_REPORTED');

  const DriverMetricsJobPayloadMetricsTypeEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
