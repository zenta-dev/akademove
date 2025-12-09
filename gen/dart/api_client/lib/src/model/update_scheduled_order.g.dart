// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_scheduled_order.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UpdateScheduledOrderCWProxy {
  UpdateScheduledOrder scheduledAt(DateTime? scheduledAt);

  UpdateScheduledOrder cancelReason(String? cancelReason);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UpdateScheduledOrder(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UpdateScheduledOrder(...).copyWith(id: 12, name: "My name")
  /// ```
  UpdateScheduledOrder call({DateTime? scheduledAt, String? cancelReason});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfUpdateScheduledOrder.copyWith(...)` or call `instanceOfUpdateScheduledOrder.copyWith.fieldName(value)` for a single field.
class _$UpdateScheduledOrderCWProxyImpl
    implements _$UpdateScheduledOrderCWProxy {
  const _$UpdateScheduledOrderCWProxyImpl(this._value);

  final UpdateScheduledOrder _value;

  @override
  UpdateScheduledOrder scheduledAt(DateTime? scheduledAt) =>
      call(scheduledAt: scheduledAt);

  @override
  UpdateScheduledOrder cancelReason(String? cancelReason) =>
      call(cancelReason: cancelReason);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UpdateScheduledOrder(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UpdateScheduledOrder(...).copyWith(id: 12, name: "My name")
  /// ```
  UpdateScheduledOrder call({
    Object? scheduledAt = const $CopyWithPlaceholder(),
    Object? cancelReason = const $CopyWithPlaceholder(),
  }) {
    return UpdateScheduledOrder(
      scheduledAt: scheduledAt == const $CopyWithPlaceholder()
          ? _value.scheduledAt
          // ignore: cast_nullable_to_non_nullable
          : scheduledAt as DateTime?,
      cancelReason: cancelReason == const $CopyWithPlaceholder()
          ? _value.cancelReason
          // ignore: cast_nullable_to_non_nullable
          : cancelReason as String?,
    );
  }
}

extension $UpdateScheduledOrderCopyWith on UpdateScheduledOrder {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfUpdateScheduledOrder.copyWith(...)` or `instanceOfUpdateScheduledOrder.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UpdateScheduledOrderCWProxy get copyWith =>
      _$UpdateScheduledOrderCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateScheduledOrder _$UpdateScheduledOrderFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('UpdateScheduledOrder', json, ($checkedConvert) {
  final val = UpdateScheduledOrder(
    scheduledAt: $checkedConvert(
      'scheduledAt',
      (v) => v == null ? null : DateTime.parse(v as String),
    ),
    cancelReason: $checkedConvert('cancelReason', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$UpdateScheduledOrderToJson(
  UpdateScheduledOrder instance,
) => <String, dynamic>{
  'scheduledAt': ?instance.scheduledAt?.toIso8601String(),
  'cancelReason': ?instance.cancelReason,
};
