// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_completion_job.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderCompletionJobCWProxy {
  OrderCompletionJob type(Object? type);

  OrderCompletionJob meta(QueueMessageMeta meta);

  OrderCompletionJob payload(OrderCompletionJobPayload payload);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderCompletionJob(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderCompletionJob(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderCompletionJob call({
    Object? type,
    QueueMessageMeta meta,
    OrderCompletionJobPayload payload,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfOrderCompletionJob.copyWith(...)` or call `instanceOfOrderCompletionJob.copyWith.fieldName(value)` for a single field.
class _$OrderCompletionJobCWProxyImpl implements _$OrderCompletionJobCWProxy {
  const _$OrderCompletionJobCWProxyImpl(this._value);

  final OrderCompletionJob _value;

  @override
  OrderCompletionJob type(Object? type) => call(type: type);

  @override
  OrderCompletionJob meta(QueueMessageMeta meta) => call(meta: meta);

  @override
  OrderCompletionJob payload(OrderCompletionJobPayload payload) =>
      call(payload: payload);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderCompletionJob(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderCompletionJob(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderCompletionJob call({
    Object? type = const $CopyWithPlaceholder(),
    Object? meta = const $CopyWithPlaceholder(),
    Object? payload = const $CopyWithPlaceholder(),
  }) {
    return OrderCompletionJob(
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
          : payload as OrderCompletionJobPayload,
    );
  }
}

extension $OrderCompletionJobCopyWith on OrderCompletionJob {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfOrderCompletionJob.copyWith(...)` or `instanceOfOrderCompletionJob.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderCompletionJobCWProxy get copyWith =>
      _$OrderCompletionJobCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderCompletionJob _$OrderCompletionJobFromJson(Map<String, dynamic> json) =>
    $checkedCreate('OrderCompletionJob', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['type', 'meta', 'payload']);
      final val = OrderCompletionJob(
        type: $checkedConvert('type', (v) => v),
        meta: $checkedConvert(
          'meta',
          (v) => QueueMessageMeta.fromJson(v as Map<String, dynamic>),
        ),
        payload: $checkedConvert(
          'payload',
          (v) => OrderCompletionJobPayload.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$OrderCompletionJobToJson(OrderCompletionJob instance) =>
    <String, dynamic>{
      'type': instance.type,
      'meta': instance.meta.toJson(),
      'payload': instance.payload.toJson(),
    };
