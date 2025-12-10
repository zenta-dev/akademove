// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'push_notification_job_payload_android.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PushNotificationJobPayloadAndroidCWProxy {
  PushNotificationJobPayloadAndroid priority(
    PushNotificationJobPayloadAndroidPriorityEnum? priority,
  );

  PushNotificationJobPayloadAndroid notification(
    PushNotificationJobPayloadAndroidNotification? notification,
  );

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `PushNotificationJobPayloadAndroid(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PushNotificationJobPayloadAndroid(...).copyWith(id: 12, name: "My name")
  /// ```
  PushNotificationJobPayloadAndroid call({
    PushNotificationJobPayloadAndroidPriorityEnum? priority,
    PushNotificationJobPayloadAndroidNotification? notification,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfPushNotificationJobPayloadAndroid.copyWith(...)` or call `instanceOfPushNotificationJobPayloadAndroid.copyWith.fieldName(value)` for a single field.
class _$PushNotificationJobPayloadAndroidCWProxyImpl
    implements _$PushNotificationJobPayloadAndroidCWProxy {
  const _$PushNotificationJobPayloadAndroidCWProxyImpl(this._value);

  final PushNotificationJobPayloadAndroid _value;

  @override
  PushNotificationJobPayloadAndroid priority(
    PushNotificationJobPayloadAndroidPriorityEnum? priority,
  ) => call(priority: priority);

  @override
  PushNotificationJobPayloadAndroid notification(
    PushNotificationJobPayloadAndroidNotification? notification,
  ) => call(notification: notification);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `PushNotificationJobPayloadAndroid(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PushNotificationJobPayloadAndroid(...).copyWith(id: 12, name: "My name")
  /// ```
  PushNotificationJobPayloadAndroid call({
    Object? priority = const $CopyWithPlaceholder(),
    Object? notification = const $CopyWithPlaceholder(),
  }) {
    return PushNotificationJobPayloadAndroid(
      priority: priority == const $CopyWithPlaceholder()
          ? _value.priority
          // ignore: cast_nullable_to_non_nullable
          : priority as PushNotificationJobPayloadAndroidPriorityEnum?,
      notification: notification == const $CopyWithPlaceholder()
          ? _value.notification
          // ignore: cast_nullable_to_non_nullable
          : notification as PushNotificationJobPayloadAndroidNotification?,
    );
  }
}

extension $PushNotificationJobPayloadAndroidCopyWith
    on PushNotificationJobPayloadAndroid {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfPushNotificationJobPayloadAndroid.copyWith(...)` or `instanceOfPushNotificationJobPayloadAndroid.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PushNotificationJobPayloadAndroidCWProxy get copyWith =>
      _$PushNotificationJobPayloadAndroidCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PushNotificationJobPayloadAndroid _$PushNotificationJobPayloadAndroidFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('PushNotificationJobPayloadAndroid', json, (
  $checkedConvert,
) {
  final val = PushNotificationJobPayloadAndroid(
    priority: $checkedConvert(
      'priority',
      (v) => $enumDecodeNullable(
        _$PushNotificationJobPayloadAndroidPriorityEnumEnumMap,
        v,
      ),
    ),
    notification: $checkedConvert(
      'notification',
      (v) => v == null
          ? null
          : PushNotificationJobPayloadAndroidNotification.fromJson(
              v as Map<String, dynamic>,
            ),
    ),
  );
  return val;
});

Map<String, dynamic> _$PushNotificationJobPayloadAndroidToJson(
  PushNotificationJobPayloadAndroid instance,
) => <String, dynamic>{
  'priority':
      ?_$PushNotificationJobPayloadAndroidPriorityEnumEnumMap[instance
          .priority],
  'notification': ?instance.notification?.toJson(),
};

const _$PushNotificationJobPayloadAndroidPriorityEnumEnumMap = {
  PushNotificationJobPayloadAndroidPriorityEnum.high: 'high',
  PushNotificationJobPayloadAndroidPriorityEnum.normal: 'normal',
};
