// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'push_notification_job_payload_webpush_fcm_options.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PushNotificationJobPayloadWebpushFcmOptionsCWProxy {
  PushNotificationJobPayloadWebpushFcmOptions link(String? link);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `PushNotificationJobPayloadWebpushFcmOptions(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PushNotificationJobPayloadWebpushFcmOptions(...).copyWith(id: 12, name: "My name")
  /// ```
  PushNotificationJobPayloadWebpushFcmOptions call({String? link});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfPushNotificationJobPayloadWebpushFcmOptions.copyWith(...)` or call `instanceOfPushNotificationJobPayloadWebpushFcmOptions.copyWith.fieldName(value)` for a single field.
class _$PushNotificationJobPayloadWebpushFcmOptionsCWProxyImpl
    implements _$PushNotificationJobPayloadWebpushFcmOptionsCWProxy {
  const _$PushNotificationJobPayloadWebpushFcmOptionsCWProxyImpl(this._value);

  final PushNotificationJobPayloadWebpushFcmOptions _value;

  @override
  PushNotificationJobPayloadWebpushFcmOptions link(String? link) =>
      call(link: link);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `PushNotificationJobPayloadWebpushFcmOptions(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PushNotificationJobPayloadWebpushFcmOptions(...).copyWith(id: 12, name: "My name")
  /// ```
  PushNotificationJobPayloadWebpushFcmOptions call({
    Object? link = const $CopyWithPlaceholder(),
  }) {
    return PushNotificationJobPayloadWebpushFcmOptions(
      link: link == const $CopyWithPlaceholder()
          ? _value.link
          // ignore: cast_nullable_to_non_nullable
          : link as String?,
    );
  }
}

extension $PushNotificationJobPayloadWebpushFcmOptionsCopyWith
    on PushNotificationJobPayloadWebpushFcmOptions {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfPushNotificationJobPayloadWebpushFcmOptions.copyWith(...)` or `instanceOfPushNotificationJobPayloadWebpushFcmOptions.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PushNotificationJobPayloadWebpushFcmOptionsCWProxy get copyWith =>
      _$PushNotificationJobPayloadWebpushFcmOptionsCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PushNotificationJobPayloadWebpushFcmOptions
_$PushNotificationJobPayloadWebpushFcmOptionsFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('PushNotificationJobPayloadWebpushFcmOptions', json, (
  $checkedConvert,
) {
  final val = PushNotificationJobPayloadWebpushFcmOptions(
    link: $checkedConvert('link', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$PushNotificationJobPayloadWebpushFcmOptionsToJson(
  PushNotificationJobPayloadWebpushFcmOptions instance,
) => <String, dynamic>{'link': ?instance.link};
