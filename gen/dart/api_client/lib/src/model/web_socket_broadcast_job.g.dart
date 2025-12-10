// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_socket_broadcast_job.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$WebSocketBroadcastJobCWProxy {
  WebSocketBroadcastJob type(Object? type);

  WebSocketBroadcastJob meta(QueueMessageMeta meta);

  WebSocketBroadcastJob payload(WebSocketBroadcastJobPayload payload);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `WebSocketBroadcastJob(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// WebSocketBroadcastJob(...).copyWith(id: 12, name: "My name")
  /// ```
  WebSocketBroadcastJob call({
    Object? type,
    QueueMessageMeta meta,
    WebSocketBroadcastJobPayload payload,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfWebSocketBroadcastJob.copyWith(...)` or call `instanceOfWebSocketBroadcastJob.copyWith.fieldName(value)` for a single field.
class _$WebSocketBroadcastJobCWProxyImpl
    implements _$WebSocketBroadcastJobCWProxy {
  const _$WebSocketBroadcastJobCWProxyImpl(this._value);

  final WebSocketBroadcastJob _value;

  @override
  WebSocketBroadcastJob type(Object? type) => call(type: type);

  @override
  WebSocketBroadcastJob meta(QueueMessageMeta meta) => call(meta: meta);

  @override
  WebSocketBroadcastJob payload(WebSocketBroadcastJobPayload payload) =>
      call(payload: payload);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `WebSocketBroadcastJob(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// WebSocketBroadcastJob(...).copyWith(id: 12, name: "My name")
  /// ```
  WebSocketBroadcastJob call({
    Object? type = const $CopyWithPlaceholder(),
    Object? meta = const $CopyWithPlaceholder(),
    Object? payload = const $CopyWithPlaceholder(),
  }) {
    return WebSocketBroadcastJob(
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

extension $WebSocketBroadcastJobCopyWith on WebSocketBroadcastJob {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfWebSocketBroadcastJob.copyWith(...)` or `instanceOfWebSocketBroadcastJob.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$WebSocketBroadcastJobCWProxy get copyWith =>
      _$WebSocketBroadcastJobCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebSocketBroadcastJob _$WebSocketBroadcastJobFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('WebSocketBroadcastJob', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['type', 'meta', 'payload']);
  final val = WebSocketBroadcastJob(
    type: $checkedConvert('type', (v) => v),
    meta: $checkedConvert(
      'meta',
      (v) => QueueMessageMeta.fromJson(v as Map<String, dynamic>),
    ),
    payload: $checkedConvert(
      'payload',
      (v) => WebSocketBroadcastJobPayload.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$WebSocketBroadcastJobToJson(
  WebSocketBroadcastJob instance,
) => <String, dynamic>{
  'type': instance.type,
  'meta': instance.meta.toJson(),
  'payload': instance.payload.toJson(),
};
