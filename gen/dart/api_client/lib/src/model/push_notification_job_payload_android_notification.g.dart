// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'push_notification_job_payload_android_notification.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PushNotificationJobPayloadAndroidNotificationCWProxy {
  PushNotificationJobPayloadAndroidNotification clickAction(
    String? clickAction,
  );

  PushNotificationJobPayloadAndroidNotification channelId(String? channelId);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `PushNotificationJobPayloadAndroidNotification(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PushNotificationJobPayloadAndroidNotification(...).copyWith(id: 12, name: "My name")
  /// ```
  PushNotificationJobPayloadAndroidNotification call({
    String? clickAction,
    String? channelId,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfPushNotificationJobPayloadAndroidNotification.copyWith(...)` or call `instanceOfPushNotificationJobPayloadAndroidNotification.copyWith.fieldName(value)` for a single field.
class _$PushNotificationJobPayloadAndroidNotificationCWProxyImpl
    implements _$PushNotificationJobPayloadAndroidNotificationCWProxy {
  const _$PushNotificationJobPayloadAndroidNotificationCWProxyImpl(this._value);

  final PushNotificationJobPayloadAndroidNotification _value;

  @override
  PushNotificationJobPayloadAndroidNotification clickAction(
    String? clickAction,
  ) => call(clickAction: clickAction);

  @override
  PushNotificationJobPayloadAndroidNotification channelId(String? channelId) =>
      call(channelId: channelId);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `PushNotificationJobPayloadAndroidNotification(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PushNotificationJobPayloadAndroidNotification(...).copyWith(id: 12, name: "My name")
  /// ```
  PushNotificationJobPayloadAndroidNotification call({
    Object? clickAction = const $CopyWithPlaceholder(),
    Object? channelId = const $CopyWithPlaceholder(),
  }) {
    return PushNotificationJobPayloadAndroidNotification(
      clickAction: clickAction == const $CopyWithPlaceholder()
          ? _value.clickAction
          // ignore: cast_nullable_to_non_nullable
          : clickAction as String?,
      channelId: channelId == const $CopyWithPlaceholder()
          ? _value.channelId
          // ignore: cast_nullable_to_non_nullable
          : channelId as String?,
    );
  }
}

extension $PushNotificationJobPayloadAndroidNotificationCopyWith
    on PushNotificationJobPayloadAndroidNotification {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfPushNotificationJobPayloadAndroidNotification.copyWith(...)` or `instanceOfPushNotificationJobPayloadAndroidNotification.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PushNotificationJobPayloadAndroidNotificationCWProxy get copyWith =>
      _$PushNotificationJobPayloadAndroidNotificationCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PushNotificationJobPayloadAndroidNotification
_$PushNotificationJobPayloadAndroidNotificationFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('PushNotificationJobPayloadAndroidNotification', json, (
  $checkedConvert,
) {
  final val = PushNotificationJobPayloadAndroidNotification(
    clickAction: $checkedConvert('clickAction', (v) => v as String?),
    channelId: $checkedConvert('channelId', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$PushNotificationJobPayloadAndroidNotificationToJson(
  PushNotificationJobPayloadAndroidNotification instance,
) => <String, dynamic>{
  'clickAction': ?instance.clickAction,
  'channelId': ?instance.channelId,
};
