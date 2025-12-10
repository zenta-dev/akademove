//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'order_status_history_job_payload.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OrderStatusHistoryJobPayload {
  /// Returns a new [OrderStatusHistoryJobPayload] instance.
  const OrderStatusHistoryJobPayload({
    required this.orderId,
    required this.fromStatus,
    required this.toStatus,
    required this.changedBy,
    required this.changedByRole,
    this.reason,
  });
  @JsonKey(name: r'orderId', required: true, includeIfNull: false)
  final String orderId;

  @JsonKey(name: r'fromStatus', required: true, includeIfNull: true)
  final String? fromStatus;

  @JsonKey(name: r'toStatus', required: true, includeIfNull: false)
  final String toStatus;

  @JsonKey(name: r'changedBy', required: true, includeIfNull: false)
  final String changedBy;

  @JsonKey(name: r'changedByRole', required: true, includeIfNull: false)
  final OrderStatusHistoryJobPayloadChangedByRoleEnum changedByRole;

  @JsonKey(name: r'reason', required: false, includeIfNull: false)
  final String? reason;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderStatusHistoryJobPayload &&
          other.orderId == orderId &&
          other.fromStatus == fromStatus &&
          other.toStatus == toStatus &&
          other.changedBy == changedBy &&
          other.changedByRole == changedByRole &&
          other.reason == reason;

  @override
  int get hashCode =>
      orderId.hashCode +
      (fromStatus == null ? 0 : fromStatus.hashCode) +
      toStatus.hashCode +
      changedBy.hashCode +
      changedByRole.hashCode +
      reason.hashCode;

  factory OrderStatusHistoryJobPayload.fromJson(Map<String, dynamic> json) =>
      _$OrderStatusHistoryJobPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$OrderStatusHistoryJobPayloadToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum OrderStatusHistoryJobPayloadChangedByRoleEnum {
  @JsonValue(r'USER')
  USER(r'USER'),
  @JsonValue(r'DRIVER')
  DRIVER(r'DRIVER'),
  @JsonValue(r'MERCHANT')
  MERCHANT(r'MERCHANT'),
  @JsonValue(r'OPERATOR')
  OPERATOR(r'OPERATOR'),
  @JsonValue(r'ADMIN')
  ADMIN(r'ADMIN'),
  @JsonValue(r'SYSTEM')
  SYSTEM(r'SYSTEM');

  const OrderStatusHistoryJobPayloadChangedByRoleEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
