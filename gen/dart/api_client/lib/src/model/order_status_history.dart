//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/order_status.dart';
import 'package:api_client/src/model/order_status_history_role.dart';
import 'package:api_client/src/model/driver_user.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'order_status_history.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OrderStatusHistory {
  /// Returns a new [OrderStatusHistory] instance.
  const OrderStatusHistory({
    required this.id,
    required this.orderId,
    required this.previousStatus,
    required this.newStatus,
    required this.changedBy,
    required this.changedByRole,
    required this.reason,
    required this.metadata,
    required this.changedAt,
    this.changedByUser,
  });
  // minimum: 0
  // maximum: 9007199254740991
  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final int id;

  @JsonKey(name: r'orderId', required: true, includeIfNull: false)
  final String orderId;

  @JsonKey(name: r'previousStatus', required: true, includeIfNull: true)
  final OrderStatus? previousStatus;

  @JsonKey(name: r'newStatus', required: true, includeIfNull: false)
  final OrderStatus newStatus;

  @JsonKey(name: r'changedBy', required: true, includeIfNull: true)
  final String? changedBy;

  @JsonKey(name: r'changedByRole', required: true, includeIfNull: true)
  final OrderStatusHistoryRole? changedByRole;

  @JsonKey(name: r'reason', required: true, includeIfNull: true)
  final String? reason;

  @JsonKey(name: r'metadata', required: true, includeIfNull: true)
  final Map<String, Object>? metadata;

  @JsonKey(name: r'changedAt', required: true, includeIfNull: false)
  final DateTime changedAt;

  @JsonKey(name: r'changedByUser', required: false, includeIfNull: false)
  final DriverUser? changedByUser;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderStatusHistory &&
          other.id == id &&
          other.orderId == orderId &&
          other.previousStatus == previousStatus &&
          other.newStatus == newStatus &&
          other.changedBy == changedBy &&
          other.changedByRole == changedByRole &&
          other.reason == reason &&
          other.metadata == metadata &&
          other.changedAt == changedAt &&
          other.changedByUser == changedByUser;

  @override
  int get hashCode =>
      id.hashCode +
      orderId.hashCode +
      (previousStatus == null ? 0 : previousStatus.hashCode) +
      newStatus.hashCode +
      (changedBy == null ? 0 : changedBy.hashCode) +
      (changedByRole == null ? 0 : changedByRole.hashCode) +
      (reason == null ? 0 : reason.hashCode) +
      (metadata == null ? 0 : metadata.hashCode) +
      changedAt.hashCode +
      changedByUser.hashCode;

  factory OrderStatusHistory.fromJson(Map<String, dynamic> json) =>
      _$OrderStatusHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$OrderStatusHistoryToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
