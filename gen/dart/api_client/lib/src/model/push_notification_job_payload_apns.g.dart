// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'push_notification_job_payload_apns.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PushNotificationJobPayloadApnsCWProxy {
  PushNotificationJobPayloadApns payload(
    PushNotificationJobPayloadApnsPayload? payload,
  );

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `PushNotificationJobPayloadApns(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PushNotificationJobPayloadApns(...).copyWith(id: 12, name: "My name")
  /// ```
  PushNotificationJobPayloadApns call({
    PushNotificationJobPayloadApnsPayload? payload,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfPushNotificationJobPayloadApns.copyWith(...)` or call `instanceOfPushNotificationJobPayloadApns.copyWith.fieldName(value)` for a single field.
class _$PushNotificationJobPayloadApnsCWProxyImpl
    implements _$PushNotificationJobPayloadApnsCWProxy {
  const _$PushNotificationJobPayloadApnsCWProxyImpl(this._value);

  final PushNotificationJobPayloadApns _value;

  @override
  PushNotificationJobPayloadApns payload(
    PushNotificationJobPayloadApnsPayload? payload,
  ) => call(payload: payload);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `PushNotificationJobPayloadApns(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PushNotificationJobPayloadApns(...).copyWith(id: 12, name: "My name")
  /// ```
  PushNotificationJobPayloadApns call({
    Object? payload = const $CopyWithPlaceholder(),
  }) {
    return PushNotificationJobPayloadApns(
      payload: payload == const $CopyWithPlaceholder()
          ? _value.payload
          // ignore: cast_nullable_to_non_nullable
          : payload as PushNotificationJobPayloadApnsPayload?,
    );
  }
}

extension $PushNotificationJobPayloadApnsCopyWith
    on PushNotificationJobPayloadApns {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfPushNotificationJobPayloadApns.copyWith(...)` or `instanceOfPushNotificationJobPayloadApns.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PushNotificationJobPayloadApnsCWProxy get copyWith =>
      _$PushNotificationJobPayloadApnsCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PushNotificationJobPayloadApns _$PushNotificationJobPayloadApnsFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('PushNotificationJobPayloadApns', json, ($checkedConvert) {
  final val = PushNotificationJobPayloadApns(
    payload: $checkedConvert(
      'payload',
      (v) => v == null
          ? null
          : PushNotificationJobPayloadApnsPayload.fromJson(
              v as Map<String, dynamic>,
            ),
    ),
  );
  return val;
});

Map<String, dynamic> _$PushNotificationJobPayloadApnsToJson(
  PushNotificationJobPayloadApns instance,
) => <String, dynamic>{'payload': ?instance.payload?.toJson()};
