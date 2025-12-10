// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_timeout_job.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderTimeoutJobCWProxy {
  OrderTimeoutJob type(Object? type);

  OrderTimeoutJob meta(QueueMessageMeta meta);

  OrderTimeoutJob payload(OrderTimeoutJobPayload payload);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderTimeoutJob(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderTimeoutJob(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderTimeoutJob call({
    Object? type,
    QueueMessageMeta meta,
    OrderTimeoutJobPayload payload,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfOrderTimeoutJob.copyWith(...)` or call `instanceOfOrderTimeoutJob.copyWith.fieldName(value)` for a single field.
class _$OrderTimeoutJobCWProxyImpl implements _$OrderTimeoutJobCWProxy {
  const _$OrderTimeoutJobCWProxyImpl(this._value);

  final OrderTimeoutJob _value;

  @override
  OrderTimeoutJob type(Object? type) => call(type: type);

  @override
  OrderTimeoutJob meta(QueueMessageMeta meta) => call(meta: meta);

  @override
  OrderTimeoutJob payload(OrderTimeoutJobPayload payload) =>
      call(payload: payload);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderTimeoutJob(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderTimeoutJob(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderTimeoutJob call({
    Object? type = const $CopyWithPlaceholder(),
    Object? meta = const $CopyWithPlaceholder(),
    Object? payload = const $CopyWithPlaceholder(),
  }) {
    return OrderTimeoutJob(
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
          : payload as OrderTimeoutJobPayload,
    );
  }
}

extension $OrderTimeoutJobCopyWith on OrderTimeoutJob {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfOrderTimeoutJob.copyWith(...)` or `instanceOfOrderTimeoutJob.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderTimeoutJobCWProxy get copyWith => _$OrderTimeoutJobCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderTimeoutJob _$OrderTimeoutJobFromJson(Map<String, dynamic> json) =>
    $checkedCreate('OrderTimeoutJob', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['type', 'meta', 'payload']);
      final val = OrderTimeoutJob(
        type: $checkedConvert('type', (v) => v),
        meta: $checkedConvert(
          'meta',
          (v) => QueueMessageMeta.fromJson(v as Map<String, dynamic>),
        ),
        payload: $checkedConvert(
          'payload',
          (v) => OrderTimeoutJobPayload.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$OrderTimeoutJobToJson(OrderTimeoutJob instance) =>
    <String, dynamic>{
      'type': instance.type,
      'meta': instance.meta.toJson(),
      'payload': instance.payload.toJson(),
    };
