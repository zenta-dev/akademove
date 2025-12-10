// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_status_history_job.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderStatusHistoryJobCWProxy {
  OrderStatusHistoryJob type(Object? type);

  OrderStatusHistoryJob meta(QueueMessageMeta meta);

  OrderStatusHistoryJob payload(OrderStatusHistoryJobPayload payload);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderStatusHistoryJob(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderStatusHistoryJob(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderStatusHistoryJob call({
    Object? type,
    QueueMessageMeta meta,
    OrderStatusHistoryJobPayload payload,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfOrderStatusHistoryJob.copyWith(...)` or call `instanceOfOrderStatusHistoryJob.copyWith.fieldName(value)` for a single field.
class _$OrderStatusHistoryJobCWProxyImpl
    implements _$OrderStatusHistoryJobCWProxy {
  const _$OrderStatusHistoryJobCWProxyImpl(this._value);

  final OrderStatusHistoryJob _value;

  @override
  OrderStatusHistoryJob type(Object? type) => call(type: type);

  @override
  OrderStatusHistoryJob meta(QueueMessageMeta meta) => call(meta: meta);

  @override
  OrderStatusHistoryJob payload(OrderStatusHistoryJobPayload payload) =>
      call(payload: payload);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderStatusHistoryJob(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderStatusHistoryJob(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderStatusHistoryJob call({
    Object? type = const $CopyWithPlaceholder(),
    Object? meta = const $CopyWithPlaceholder(),
    Object? payload = const $CopyWithPlaceholder(),
  }) {
    return OrderStatusHistoryJob(
      type: type == const $CopyWithPlaceholder()
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as Object?,
      meta: meta == const $CopyWithPlaceholder() || meta == null
          ? _value.meta
          // ignore: cast_nullable_to_non_nullable
          : meta as QueueMessageMeta,
      payload: payload == const $CopyWithPlaceholder() || payload == null
          ? _value.payload
          // ignore: cast_nullable_to_non_nullable
          : payload as OrderStatusHistoryJobPayload,
    );
  }
}

extension $OrderStatusHistoryJobCopyWith on OrderStatusHistoryJob {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfOrderStatusHistoryJob.copyWith(...)` or `instanceOfOrderStatusHistoryJob.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderStatusHistoryJobCWProxy get copyWith =>
      _$OrderStatusHistoryJobCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderStatusHistoryJob _$OrderStatusHistoryJobFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('OrderStatusHistoryJob', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['type', 'meta', 'payload']);
  final val = OrderStatusHistoryJob(
    type: $checkedConvert('type', (v) => v),
    meta: $checkedConvert(
      'meta',
      (v) => QueueMessageMeta.fromJson(v as Map<String, dynamic>),
    ),
    payload: $checkedConvert(
      'payload',
      (v) => OrderStatusHistoryJobPayload.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$OrderStatusHistoryJobToJson(
  OrderStatusHistoryJob instance,
) => <String, dynamic>{
  'type': instance.type,
  'meta': instance.meta.toJson(),
  'payload': instance.payload.toJson(),
};
