// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_status_history.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderStatusHistoryCWProxy {
  OrderStatusHistory id(num id);

  OrderStatusHistory orderId(String orderId);

  OrderStatusHistory previousStatus(OrderStatus? previousStatus);

  OrderStatusHistory newStatus(OrderStatus newStatus);

  OrderStatusHistory changedBy(String? changedBy);

  OrderStatusHistory changedByRole(OrderStatusHistoryRole? changedByRole);

  OrderStatusHistory reason(String? reason);

  OrderStatusHistory metadata(Map<String, Object>? metadata);

  OrderStatusHistory changedAt(DateTime changedAt);

  OrderStatusHistory changedByUser(DriverUser? changedByUser);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderStatusHistory(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderStatusHistory(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderStatusHistory call({
    num id,
    String orderId,
    OrderStatus? previousStatus,
    OrderStatus newStatus,
    String? changedBy,
    OrderStatusHistoryRole? changedByRole,
    String? reason,
    Map<String, Object>? metadata,
    DateTime changedAt,
    DriverUser? changedByUser,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfOrderStatusHistory.copyWith(...)` or call `instanceOfOrderStatusHistory.copyWith.fieldName(value)` for a single field.
class _$OrderStatusHistoryCWProxyImpl implements _$OrderStatusHistoryCWProxy {
  const _$OrderStatusHistoryCWProxyImpl(this._value);

  final OrderStatusHistory _value;

  @override
  OrderStatusHistory id(num id) => call(id: id);

  @override
  OrderStatusHistory orderId(String orderId) => call(orderId: orderId);

  @override
  OrderStatusHistory previousStatus(OrderStatus? previousStatus) =>
      call(previousStatus: previousStatus);

  @override
  OrderStatusHistory newStatus(OrderStatus newStatus) =>
      call(newStatus: newStatus);

  @override
  OrderStatusHistory changedBy(String? changedBy) => call(changedBy: changedBy);

  @override
  OrderStatusHistory changedByRole(OrderStatusHistoryRole? changedByRole) =>
      call(changedByRole: changedByRole);

  @override
  OrderStatusHistory reason(String? reason) => call(reason: reason);

  @override
  OrderStatusHistory metadata(Map<String, Object>? metadata) =>
      call(metadata: metadata);

  @override
  OrderStatusHistory changedAt(DateTime changedAt) =>
      call(changedAt: changedAt);

  @override
  OrderStatusHistory changedByUser(DriverUser? changedByUser) =>
      call(changedByUser: changedByUser);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderStatusHistory(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderStatusHistory(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderStatusHistory call({
    Object? id = const $CopyWithPlaceholder(),
    Object? orderId = const $CopyWithPlaceholder(),
    Object? previousStatus = const $CopyWithPlaceholder(),
    Object? newStatus = const $CopyWithPlaceholder(),
    Object? changedBy = const $CopyWithPlaceholder(),
    Object? changedByRole = const $CopyWithPlaceholder(),
    Object? reason = const $CopyWithPlaceholder(),
    Object? metadata = const $CopyWithPlaceholder(),
    Object? changedAt = const $CopyWithPlaceholder(),
    Object? changedByUser = const $CopyWithPlaceholder(),
  }) {
    return OrderStatusHistory(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as num,
      orderId: orderId == const $CopyWithPlaceholder() || orderId == null
          ? _value.orderId
          // ignore: cast_nullable_to_non_nullable
          : orderId as String,
      previousStatus: previousStatus == const $CopyWithPlaceholder()
          ? _value.previousStatus
          // ignore: cast_nullable_to_non_nullable
          : previousStatus as OrderStatus?,
      newStatus: newStatus == const $CopyWithPlaceholder() || newStatus == null
          ? _value.newStatus
          // ignore: cast_nullable_to_non_nullable
          : newStatus as OrderStatus,
      changedBy: changedBy == const $CopyWithPlaceholder()
          ? _value.changedBy
          // ignore: cast_nullable_to_non_nullable
          : changedBy as String?,
      changedByRole: changedByRole == const $CopyWithPlaceholder()
          ? _value.changedByRole
          // ignore: cast_nullable_to_non_nullable
          : changedByRole as OrderStatusHistoryRole?,
      reason: reason == const $CopyWithPlaceholder()
          ? _value.reason
          // ignore: cast_nullable_to_non_nullable
          : reason as String?,
      metadata: metadata == const $CopyWithPlaceholder()
          ? _value.metadata
          // ignore: cast_nullable_to_non_nullable
          : metadata as Map<String, Object>?,
      changedAt: changedAt == const $CopyWithPlaceholder() || changedAt == null
          ? _value.changedAt
          // ignore: cast_nullable_to_non_nullable
          : changedAt as DateTime,
      changedByUser: changedByUser == const $CopyWithPlaceholder()
          ? _value.changedByUser
          // ignore: cast_nullable_to_non_nullable
          : changedByUser as DriverUser?,
    );
  }
}

extension $OrderStatusHistoryCopyWith on OrderStatusHistory {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfOrderStatusHistory.copyWith(...)` or `instanceOfOrderStatusHistory.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderStatusHistoryCWProxy get copyWith =>
      _$OrderStatusHistoryCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderStatusHistory _$OrderStatusHistoryFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('OrderStatusHistory', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const [
      'id',
      'orderId',
      'previousStatus',
      'newStatus',
      'changedBy',
      'changedByRole',
      'reason',
      'metadata',
      'changedAt',
    ],
  );
  final val = OrderStatusHistory(
    id: $checkedConvert('id', (v) => v as num),
    orderId: $checkedConvert('orderId', (v) => v as String),
    previousStatus: $checkedConvert(
      'previousStatus',
      (v) => $enumDecodeNullable(_$OrderStatusEnumMap, v),
    ),
    newStatus: $checkedConvert(
      'newStatus',
      (v) => $enumDecode(_$OrderStatusEnumMap, v),
    ),
    changedBy: $checkedConvert('changedBy', (v) => v as String?),
    changedByRole: $checkedConvert(
      'changedByRole',
      (v) => $enumDecodeNullable(_$OrderStatusHistoryRoleEnumMap, v),
    ),
    reason: $checkedConvert('reason', (v) => v as String?),
    metadata: $checkedConvert(
      'metadata',
      (v) =>
          (v as Map<String, dynamic>?)?.map((k, e) => MapEntry(k, e as Object)),
    ),
    changedAt: $checkedConvert('changedAt', (v) => DateTime.parse(v as String)),
    changedByUser: $checkedConvert(
      'changedByUser',
      (v) => v == null ? null : DriverUser.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$OrderStatusHistoryToJson(OrderStatusHistory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'orderId': instance.orderId,
      'previousStatus': _$OrderStatusEnumMap[instance.previousStatus],
      'newStatus': _$OrderStatusEnumMap[instance.newStatus]!,
      'changedBy': instance.changedBy,
      'changedByRole': _$OrderStatusHistoryRoleEnumMap[instance.changedByRole],
      'reason': instance.reason,
      'metadata': instance.metadata,
      'changedAt': instance.changedAt.toIso8601String(),
      'changedByUser': ?instance.changedByUser?.toJson(),
    };

const _$OrderStatusEnumMap = {
  OrderStatus.SCHEDULED: 'SCHEDULED',
  OrderStatus.REQUESTED: 'REQUESTED',
  OrderStatus.MATCHING: 'MATCHING',
  OrderStatus.ACCEPTED: 'ACCEPTED',
  OrderStatus.PREPARING: 'PREPARING',
  OrderStatus.READY_FOR_PICKUP: 'READY_FOR_PICKUP',
  OrderStatus.ARRIVING: 'ARRIVING',
  OrderStatus.IN_TRIP: 'IN_TRIP',
  OrderStatus.COMPLETED: 'COMPLETED',
  OrderStatus.CANCELLED_BY_USER: 'CANCELLED_BY_USER',
  OrderStatus.CANCELLED_BY_DRIVER: 'CANCELLED_BY_DRIVER',
  OrderStatus.CANCELLED_BY_MERCHANT: 'CANCELLED_BY_MERCHANT',
  OrderStatus.CANCELLED_BY_SYSTEM: 'CANCELLED_BY_SYSTEM',
  OrderStatus.NO_SHOW: 'NO_SHOW',
};

const _$OrderStatusHistoryRoleEnumMap = {
  OrderStatusHistoryRole.USER: 'USER',
  OrderStatusHistoryRole.DRIVER: 'DRIVER',
  OrderStatusHistoryRole.MERCHANT: 'MERCHANT',
  OrderStatusHistoryRole.OPERATOR: 'OPERATOR',
  OrderStatusHistoryRole.ADMIN: 'ADMIN',
  OrderStatusHistoryRole.SYSTEM: 'SYSTEM',
};
