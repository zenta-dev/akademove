// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'push_notification_job_payload.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PushNotificationJobPayloadCWProxy {
  PushNotificationJobPayload toUserId(String toUserId);

  PushNotificationJobPayload fromUserId(String? fromUserId);

  PushNotificationJobPayload title(String title);

  PushNotificationJobPayload body(String body);

  PushNotificationJobPayload data(Map<String, String>? data);

  PushNotificationJobPayload android(
    PushNotificationJobPayloadAndroid? android,
  );

  PushNotificationJobPayload apns(PushNotificationJobPayloadApns? apns);

  PushNotificationJobPayload webpush(
    PushNotificationJobPayloadWebpush? webpush,
  );

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `PushNotificationJobPayload(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PushNotificationJobPayload(...).copyWith(id: 12, name: "My name")
  /// ```
  PushNotificationJobPayload call({
    String toUserId,
    String? fromUserId,
    String title,
    String body,
    Map<String, String>? data,
    PushNotificationJobPayloadAndroid? android,
    PushNotificationJobPayloadApns? apns,
    PushNotificationJobPayloadWebpush? webpush,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfPushNotificationJobPayload.copyWith(...)` or call `instanceOfPushNotificationJobPayload.copyWith.fieldName(value)` for a single field.
class _$PushNotificationJobPayloadCWProxyImpl
    implements _$PushNotificationJobPayloadCWProxy {
  const _$PushNotificationJobPayloadCWProxyImpl(this._value);

  final PushNotificationJobPayload _value;

  @override
  PushNotificationJobPayload toUserId(String toUserId) =>
      call(toUserId: toUserId);

  @override
  PushNotificationJobPayload fromUserId(String? fromUserId) =>
      call(fromUserId: fromUserId);

  @override
  PushNotificationJobPayload title(String title) => call(title: title);

  @override
  PushNotificationJobPayload body(String body) => call(body: body);

  @override
  PushNotificationJobPayload data(Map<String, String>? data) =>
      call(data: data);

  @override
  PushNotificationJobPayload android(
    PushNotificationJobPayloadAndroid? android,
  ) => call(android: android);

  @override
  PushNotificationJobPayload apns(PushNotificationJobPayloadApns? apns) =>
      call(apns: apns);

  @override
  PushNotificationJobPayload webpush(
    PushNotificationJobPayloadWebpush? webpush,
  ) => call(webpush: webpush);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `PushNotificationJobPayload(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PushNotificationJobPayload(...).copyWith(id: 12, name: "My name")
  /// ```
  PushNotificationJobPayload call({
    Object? toUserId = const $CopyWithPlaceholder(),
    Object? fromUserId = const $CopyWithPlaceholder(),
    Object? title = const $CopyWithPlaceholder(),
    Object? body = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? android = const $CopyWithPlaceholder(),
    Object? apns = const $CopyWithPlaceholder(),
    Object? webpush = const $CopyWithPlaceholder(),
  }) {
    return PushNotificationJobPayload(
      toUserId: toUserId == const $CopyWithPlaceholder() || toUserId == null
          ? _value.toUserId
          // ignore: cast_nullable_to_non_nullable
          : toUserId as String,
      fromUserId: fromUserId == const $CopyWithPlaceholder()
          ? _value.fromUserId
          // ignore: cast_nullable_to_non_nullable
          : fromUserId as String?,
      title: title == const $CopyWithPlaceholder() || title == null
          ? _value.title
          // ignore: cast_nullable_to_non_nullable
          : title as String,
      body: body == const $CopyWithPlaceholder() || body == null
          ? _value.body
          // ignore: cast_nullable_to_non_nullable
          : body as String,
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as Map<String, String>?,
      android: android == const $CopyWithPlaceholder()
          ? _value.android
          // ignore: cast_nullable_to_non_nullable
          : android as PushNotificationJobPayloadAndroid?,
      apns: apns == const $CopyWithPlaceholder()
          ? _value.apns
          // ignore: cast_nullable_to_non_nullable
          : apns as PushNotificationJobPayloadApns?,
      webpush: webpush == const $CopyWithPlaceholder()
          ? _value.webpush
          // ignore: cast_nullable_to_non_nullable
          : webpush as PushNotificationJobPayloadWebpush?,
    );
  }
}

extension $PushNotificationJobPayloadCopyWith on PushNotificationJobPayload {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfPushNotificationJobPayload.copyWith(...)` or `instanceOfPushNotificationJobPayload.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PushNotificationJobPayloadCWProxy get copyWith =>
      _$PushNotificationJobPayloadCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PushNotificationJobPayload _$PushNotificationJobPayloadFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('PushNotificationJobPayload', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['toUserId', 'title', 'body']);
  final val = PushNotificationJobPayload(
    toUserId: $checkedConvert('toUserId', (v) => v as String),
    fromUserId: $checkedConvert('fromUserId', (v) => v as String?),
    title: $checkedConvert('title', (v) => v as String),
    body: $checkedConvert('body', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) =>
          (v as Map<String, dynamic>?)?.map((k, e) => MapEntry(k, e as String)),
    ),
    android: $checkedConvert(
      'android',
      (v) => v == null
          ? null
          : PushNotificationJobPayloadAndroid.fromJson(
              v as Map<String, dynamic>,
            ),
    ),
    apns: $checkedConvert(
      'apns',
      (v) => v == null
          ? null
          : PushNotificationJobPayloadApns.fromJson(v as Map<String, dynamic>),
    ),
    webpush: $checkedConvert(
      'webpush',
      (v) => v == null
          ? null
          : PushNotificationJobPayloadWebpush.fromJson(
              v as Map<String, dynamic>,
            ),
    ),
  );
  return val;
});

Map<String, dynamic> _$PushNotificationJobPayloadToJson(
  PushNotificationJobPayload instance,
) => <String, dynamic>{
  'toUserId': instance.toUserId,
  'fromUserId': ?instance.fromUserId,
  'title': instance.title,
  'body': instance.body,
  'data': ?instance.data,
  'android': ?instance.android?.toJson(),
  'apns': ?instance.apns?.toJson(),
  'webpush': ?instance.webpush?.toJson(),
};
