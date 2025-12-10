// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_status_history_job_payload.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderStatusHistoryJobPayloadCWProxy {
  OrderStatusHistoryJobPayload orderId(String orderId);

  OrderStatusHistoryJobPayload fromStatus(String? fromStatus);

  OrderStatusHistoryJobPayload toStatus(String toStatus);

  OrderStatusHistoryJobPayload changedBy(String changedBy);

  OrderStatusHistoryJobPayload changedByRole(
    OrderStatusHistoryJobPayloadChangedByRoleEnum changedByRole,
  );

  OrderStatusHistoryJobPayload reason(String? reason);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderStatusHistoryJobPayload(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderStatusHistoryJobPayload(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderStatusHistoryJobPayload call({
    String orderId,
    String? fromStatus,
    String toStatus,
    String changedBy,
    OrderStatusHistoryJobPayloadChangedByRoleEnum changedByRole,
    String? reason,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfOrderStatusHistoryJobPayload.copyWith(...)` or call `instanceOfOrderStatusHistoryJobPayload.copyWith.fieldName(value)` for a single field.
class _$OrderStatusHistoryJobPayloadCWProxyImpl
    implements _$OrderStatusHistoryJobPayloadCWProxy {
  const _$OrderStatusHistoryJobPayloadCWProxyImpl(this._value);

  final OrderStatusHistoryJobPayload _value;

  @override
  OrderStatusHistoryJobPayload orderId(String orderId) =>
      call(orderId: orderId);

  @override
  OrderStatusHistoryJobPayload fromStatus(String? fromStatus) =>
      call(fromStatus: fromStatus);

  @override
  OrderStatusHistoryJobPayload toStatus(String toStatus) =>
      call(toStatus: toStatus);

  @override
  OrderStatusHistoryJobPayload changedBy(String changedBy) =>
      call(changedBy: changedBy);

  @override
  OrderStatusHistoryJobPayload changedByRole(
    OrderStatusHistoryJobPayloadChangedByRoleEnum changedByRole,
  ) => call(changedByRole: changedByRole);

  @override
  OrderStatusHistoryJobPayload reason(String? reason) => call(reason: reason);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderStatusHistoryJobPayload(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderStatusHistoryJobPayload(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderStatusHistoryJobPayload call({
    Object? orderId = const $CopyWithPlaceholder(),
    Object? fromStatus = const $CopyWithPlaceholder(),
    Object? toStatus = const $CopyWithPlaceholder(),
    Object? changedBy = const $CopyWithPlaceholder(),
    Object? changedByRole = const $CopyWithPlaceholder(),
    Object? reason = const $CopyWithPlaceholder(),
  }) {
    return OrderStatusHistoryJobPayload(
      orderId: orderId == const $CopyWithPlaceholder() || orderId == null
          ? _value.orderId
          // ignore: cast_nullable_to_non_nullable
          : orderId as String,
      fromStatus: fromStatus == const $CopyWithPlaceholder()
          ? _value.fromStatus
          // ignore: cast_nullable_to_non_nullable
          : fromStatus as String?,
      toStatus: toStatus == const $CopyWithPlaceholder() || toStatus == null
          ? _value.toStatus
          // ignore: cast_nullable_to_non_nullable
          : toStatus as String,
      changedBy: changedBy == const $CopyWithPlaceholder() || changedBy == null
          ? _value.changedBy
          // ignore: cast_nullable_to_non_nullable
          : changedBy as String,
      changedByRole:
          changedByRole == const $CopyWithPlaceholder() || changedByRole == null
          ? _value.changedByRole
          // ignore: cast_nullable_to_non_nullable
          : changedByRole as OrderStatusHistoryJobPayloadChangedByRoleEnum,
      reason: reason == const $CopyWithPlaceholder()
          ? _value.reason
          // ignore: cast_nullable_to_non_nullable
          : reason as String?,
    );
  }
}

extension $OrderStatusHistoryJobPayloadCopyWith
    on OrderStatusHistoryJobPayload {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfOrderStatusHistoryJobPayload.copyWith(...)` or `instanceOfOrderStatusHistoryJobPayload.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderStatusHistoryJobPayloadCWProxy get copyWith =>
      _$OrderStatusHistoryJobPayloadCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderStatusHistoryJobPayload _$OrderStatusHistoryJobPayloadFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('OrderStatusHistoryJobPayload', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const [
      'orderId',
      'fromStatus',
      'toStatus',
      'changedBy',
      'changedByRole',
    ],
  );
  final val = OrderStatusHistoryJobPayload(
    orderId: $checkedConvert('orderId', (v) => v as String),
    fromStatus: $checkedConvert('fromStatus', (v) => v as String?),
    toStatus: $checkedConvert('toStatus', (v) => v as String),
    changedBy: $checkedConvert('changedBy', (v) => v as String),
    changedByRole: $checkedConvert(
      'changedByRole',
      (v) => $enumDecode(
        _$OrderStatusHistoryJobPayloadChangedByRoleEnumEnumMap,
        v,
      ),
    ),
    reason: $checkedConvert('reason', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$OrderStatusHistoryJobPayloadToJson(
  OrderStatusHistoryJobPayload instance,
) => <String, dynamic>{
  'orderId': instance.orderId,
  'fromStatus': instance.fromStatus,
  'toStatus': instance.toStatus,
  'changedBy': instance.changedBy,
  'changedByRole':
      _$OrderStatusHistoryJobPayloadChangedByRoleEnumEnumMap[instance
          .changedByRole]!,
  'reason': ?instance.reason,
};

const _$OrderStatusHistoryJobPayloadChangedByRoleEnumEnumMap = {
  OrderStatusHistoryJobPayloadChangedByRoleEnum.USER: 'USER',
  OrderStatusHistoryJobPayloadChangedByRoleEnum.DRIVER: 'DRIVER',
  OrderStatusHistoryJobPayloadChangedByRoleEnum.MERCHANT: 'MERCHANT',
  OrderStatusHistoryJobPayloadChangedByRoleEnum.OPERATOR: 'OPERATOR',
  OrderStatusHistoryJobPayloadChangedByRoleEnum.ADMIN: 'ADMIN',
  OrderStatusHistoryJobPayloadChangedByRoleEnum.SYSTEM: 'SYSTEM',
};
