// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'queue_message.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$QueueMessageCWProxy {
  QueueMessage type(Object? type);

  QueueMessage meta(QueueMessageMeta meta);

  QueueMessage payload(WebSocketBroadcastJobPayload payload);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `QueueMessage(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// QueueMessage(...).copyWith(id: 12, name: "My name")
  /// ```
  QueueMessage call({
    Object? type,
    QueueMessageMeta meta,
    WebSocketBroadcastJobPayload payload,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfQueueMessage.copyWith(...)` or call `instanceOfQueueMessage.copyWith.fieldName(value)` for a single field.
class _$QueueMessageCWProxyImpl implements _$QueueMessageCWProxy {
  const _$QueueMessageCWProxyImpl(this._value);

  final QueueMessage _value;

  @override
  QueueMessage type(Object? type) => call(type: type);

  @override
  QueueMessage meta(QueueMessageMeta meta) => call(meta: meta);

  @override
  QueueMessage payload(WebSocketBroadcastJobPayload payload) =>
      call(payload: payload);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `QueueMessage(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// QueueMessage(...).copyWith(id: 12, name: "My name")
  /// ```
  QueueMessage call({
    Object? type = const $CopyWithPlaceholder(),
    Object? meta = const $CopyWithPlaceholder(),
    Object? payload = const $CopyWithPlaceholder(),
  }) {
    return QueueMessage(
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
          : payload as WebSocketBroadcastJobPayload,
    );
  }
}

extension $QueueMessageCopyWith on QueueMessage {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfQueueMessage.copyWith(...)` or `instanceOfQueueMessage.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$QueueMessageCWProxy get copyWith => _$QueueMessageCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QueueMessage _$QueueMessageFromJson(Map<String, dynamic> json) =>
    $checkedCreate('QueueMessage', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['type', 'meta', 'payload']);
      final val = QueueMessage(
        type: $checkedConvert('type', (v) => v),
        meta: $checkedConvert(
          'meta',
          (v) => QueueMessageMeta.fromJson(v as Map<String, dynamic>),
        ),
        payload: $checkedConvert(
          'payload',
          (v) =>
              WebSocketBroadcastJobPayload.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$QueueMessageToJson(QueueMessage instance) =>
    <String, dynamic>{
      'type': instance.type,
      'meta': instance.meta.toJson(),
      'payload': instance.payload.toJson(),
    };
