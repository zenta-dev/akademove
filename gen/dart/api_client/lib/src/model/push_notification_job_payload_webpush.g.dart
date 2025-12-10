// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'push_notification_job_payload_webpush.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PushNotificationJobPayloadWebpushCWProxy {
  PushNotificationJobPayloadWebpush fcmOptions(
    PushNotificationJobPayloadWebpushFcmOptions? fcmOptions,
  );

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `PushNotificationJobPayloadWebpush(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PushNotificationJobPayloadWebpush(...).copyWith(id: 12, name: "My name")
  /// ```
  PushNotificationJobPayloadWebpush call({
    PushNotificationJobPayloadWebpushFcmOptions? fcmOptions,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfPushNotificationJobPayloadWebpush.copyWith(...)` or call `instanceOfPushNotificationJobPayloadWebpush.copyWith.fieldName(value)` for a single field.
class _$PushNotificationJobPayloadWebpushCWProxyImpl
    implements _$PushNotificationJobPayloadWebpushCWProxy {
  const _$PushNotificationJobPayloadWebpushCWProxyImpl(this._value);

  final PushNotificationJobPayloadWebpush _value;

  @override
  PushNotificationJobPayloadWebpush fcmOptions(
    PushNotificationJobPayloadWebpushFcmOptions? fcmOptions,
  ) => call(fcmOptions: fcmOptions);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `PushNotificationJobPayloadWebpush(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PushNotificationJobPayloadWebpush(...).copyWith(id: 12, name: "My name")
  /// ```
  PushNotificationJobPayloadWebpush call({
    Object? fcmOptions = const $CopyWithPlaceholder(),
  }) {
    return PushNotificationJobPayloadWebpush(
      fcmOptions: fcmOptions == const $CopyWithPlaceholder()
          ? _value.fcmOptions
          // ignore: cast_nullable_to_non_nullable
          : fcmOptions as PushNotificationJobPayloadWebpushFcmOptions?,
    );
  }
}

extension $PushNotificationJobPayloadWebpushCopyWith
    on PushNotificationJobPayloadWebpush {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfPushNotificationJobPayloadWebpush.copyWith(...)` or `instanceOfPushNotificationJobPayloadWebpush.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PushNotificationJobPayloadWebpushCWProxy get copyWith =>
      _$PushNotificationJobPayloadWebpushCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PushNotificationJobPayloadWebpush _$PushNotificationJobPayloadWebpushFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('PushNotificationJobPayloadWebpush', json, (
  $checkedConvert,
) {
  final val = PushNotificationJobPayloadWebpush(
    fcmOptions: $checkedConvert(
      'fcmOptions',
      (v) => v == null
          ? null
          : PushNotificationJobPayloadWebpushFcmOptions.fromJson(
              v as Map<String, dynamic>,
            ),
    ),
  );
  return val;
});

Map<String, dynamic> _$PushNotificationJobPayloadWebpushToJson(
  PushNotificationJobPayloadWebpush instance,
) => <String, dynamic>{'fcmOptions': ?instance.fcmOptions?.toJson()};
