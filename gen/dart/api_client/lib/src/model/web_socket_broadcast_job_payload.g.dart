// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_socket_broadcast_job_payload.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$WebSocketBroadcastJobPayloadCWProxy {
  WebSocketBroadcastJobPayload roomName(String roomName);

  WebSocketBroadcastJobPayload event(String event);

  WebSocketBroadcastJobPayload target(
    WebSocketBroadcastJobPayloadTargetEnum? target,
  );

  WebSocketBroadcastJobPayload data(Map<String, Object> data);

  WebSocketBroadcastJobPayload excludeUserIds(List<String>? excludeUserIds);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `WebSocketBroadcastJobPayload(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// WebSocketBroadcastJobPayload(...).copyWith(id: 12, name: "My name")
  /// ```
  WebSocketBroadcastJobPayload call({
    String roomName,
    String event,
    WebSocketBroadcastJobPayloadTargetEnum? target,
    Map<String, Object> data,
    List<String>? excludeUserIds,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfWebSocketBroadcastJobPayload.copyWith(...)` or call `instanceOfWebSocketBroadcastJobPayload.copyWith.fieldName(value)` for a single field.
class _$WebSocketBroadcastJobPayloadCWProxyImpl
    implements _$WebSocketBroadcastJobPayloadCWProxy {
  const _$WebSocketBroadcastJobPayloadCWProxyImpl(this._value);

  final WebSocketBroadcastJobPayload _value;

  @override
  WebSocketBroadcastJobPayload roomName(String roomName) =>
      call(roomName: roomName);

  @override
  WebSocketBroadcastJobPayload event(String event) => call(event: event);

  @override
  WebSocketBroadcastJobPayload target(
    WebSocketBroadcastJobPayloadTargetEnum? target,
  ) => call(target: target);

  @override
  WebSocketBroadcastJobPayload data(Map<String, Object> data) =>
      call(data: data);

  @override
  WebSocketBroadcastJobPayload excludeUserIds(List<String>? excludeUserIds) =>
      call(excludeUserIds: excludeUserIds);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `WebSocketBroadcastJobPayload(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// WebSocketBroadcastJobPayload(...).copyWith(id: 12, name: "My name")
  /// ```
  WebSocketBroadcastJobPayload call({
    Object? roomName = const $CopyWithPlaceholder(),
    Object? event = const $CopyWithPlaceholder(),
    Object? target = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? excludeUserIds = const $CopyWithPlaceholder(),
  }) {
    return WebSocketBroadcastJobPayload(
      roomName: roomName == const $CopyWithPlaceholder() || roomName == null
          ? _value.roomName
          // ignore: cast_nullable_to_non_nullable
          : roomName as String,
      event: event == const $CopyWithPlaceholder() || event == null
          ? _value.event
          // ignore: cast_nullable_to_non_nullable
          : event as String,
      target: target == const $CopyWithPlaceholder()
          ? _value.target
          // ignore: cast_nullable_to_non_nullable
          : target as WebSocketBroadcastJobPayloadTargetEnum?,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as Map<String, Object>,
      excludeUserIds: excludeUserIds == const $CopyWithPlaceholder()
          ? _value.excludeUserIds
          // ignore: cast_nullable_to_non_nullable
          : excludeUserIds as List<String>?,
    );
  }
}

extension $WebSocketBroadcastJobPayloadCopyWith
    on WebSocketBroadcastJobPayload {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfWebSocketBroadcastJobPayload.copyWith(...)` or `instanceOfWebSocketBroadcastJobPayload.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$WebSocketBroadcastJobPayloadCWProxy get copyWith =>
      _$WebSocketBroadcastJobPayloadCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebSocketBroadcastJobPayload _$WebSocketBroadcastJobPayloadFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('WebSocketBroadcastJobPayload', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['roomName', 'event', 'data']);
  final val = WebSocketBroadcastJobPayload(
    roomName: $checkedConvert('roomName', (v) => v as String),
    event: $checkedConvert('event', (v) => v as String),
    target: $checkedConvert(
      'target',
      (v) => $enumDecodeNullable(
        _$WebSocketBroadcastJobPayloadTargetEnumEnumMap,
        v,
      ),
    ),
    data: $checkedConvert(
      'data',
      (v) =>
          (v as Map<String, dynamic>).map((k, e) => MapEntry(k, e as Object)),
    ),
    excludeUserIds: $checkedConvert(
      'excludeUserIds',
      (v) => (v as List<dynamic>?)?.map((e) => e as String).toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$WebSocketBroadcastJobPayloadToJson(
  WebSocketBroadcastJobPayload instance,
) => <String, dynamic>{
  'roomName': instance.roomName,
  'event': instance.event,
  'target': ?_$WebSocketBroadcastJobPayloadTargetEnumEnumMap[instance.target],
  'data': instance.data,
  'excludeUserIds': ?instance.excludeUserIds,
};

const _$WebSocketBroadcastJobPayloadTargetEnumEnumMap = {
  WebSocketBroadcastJobPayloadTargetEnum.USER: 'USER',
  WebSocketBroadcastJobPayloadTargetEnum.DRIVER: 'DRIVER',
  WebSocketBroadcastJobPayloadTargetEnum.MERCHANT: 'MERCHANT',
  WebSocketBroadcastJobPayloadTargetEnum.ALL: 'ALL',
};
