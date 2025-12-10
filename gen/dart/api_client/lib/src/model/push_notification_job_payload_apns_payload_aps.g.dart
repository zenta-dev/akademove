// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'push_notification_job_payload_apns_payload_aps.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PushNotificationJobPayloadApnsPayloadApsCWProxy {
  PushNotificationJobPayloadApnsPayloadAps category(String? category);

  PushNotificationJobPayloadApnsPayloadAps sound(String? sound);

  PushNotificationJobPayloadApnsPayloadAps badge(num? badge);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `PushNotificationJobPayloadApnsPayloadAps(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PushNotificationJobPayloadApnsPayloadAps(...).copyWith(id: 12, name: "My name")
  /// ```
  PushNotificationJobPayloadApnsPayloadAps call({
    String? category,
    String? sound,
    num? badge,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfPushNotificationJobPayloadApnsPayloadAps.copyWith(...)` or call `instanceOfPushNotificationJobPayloadApnsPayloadAps.copyWith.fieldName(value)` for a single field.
class _$PushNotificationJobPayloadApnsPayloadApsCWProxyImpl
    implements _$PushNotificationJobPayloadApnsPayloadApsCWProxy {
  const _$PushNotificationJobPayloadApnsPayloadApsCWProxyImpl(this._value);

  final PushNotificationJobPayloadApnsPayloadAps _value;

  @override
  PushNotificationJobPayloadApnsPayloadAps category(String? category) =>
      call(category: category);

  @override
  PushNotificationJobPayloadApnsPayloadAps sound(String? sound) =>
      call(sound: sound);

  @override
  PushNotificationJobPayloadApnsPayloadAps badge(num? badge) =>
      call(badge: badge);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `PushNotificationJobPayloadApnsPayloadAps(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PushNotificationJobPayloadApnsPayloadAps(...).copyWith(id: 12, name: "My name")
  /// ```
  PushNotificationJobPayloadApnsPayloadAps call({
    Object? category = const $CopyWithPlaceholder(),
    Object? sound = const $CopyWithPlaceholder(),
    Object? badge = const $CopyWithPlaceholder(),
  }) {
    return PushNotificationJobPayloadApnsPayloadAps(
      category: category == const $CopyWithPlaceholder()
          ? _value.category
          // ignore: cast_nullable_to_non_nullable
          : category as String?,
      sound: sound == const $CopyWithPlaceholder()
          ? _value.sound
          // ignore: cast_nullable_to_non_nullable
          : sound as String?,
      badge: badge == const $CopyWithPlaceholder()
          ? _value.badge
          // ignore: cast_nullable_to_non_nullable
          : badge as num?,
    );
  }
}

extension $PushNotificationJobPayloadApnsPayloadApsCopyWith
    on PushNotificationJobPayloadApnsPayloadAps {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfPushNotificationJobPayloadApnsPayloadAps.copyWith(...)` or `instanceOfPushNotificationJobPayloadApnsPayloadAps.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PushNotificationJobPayloadApnsPayloadApsCWProxy get copyWith =>
      _$PushNotificationJobPayloadApnsPayloadApsCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PushNotificationJobPayloadApnsPayloadAps
_$PushNotificationJobPayloadApnsPayloadApsFromJson(Map<String, dynamic> json) =>
    $checkedCreate('PushNotificationJobPayloadApnsPayloadAps', json, (
      $checkedConvert,
    ) {
      final val = PushNotificationJobPayloadApnsPayloadAps(
        category: $checkedConvert('category', (v) => v as String?),
        sound: $checkedConvert('sound', (v) => v as String?),
        badge: $checkedConvert('badge', (v) => v as num?),
      );
      return val;
    });

Map<String, dynamic> _$PushNotificationJobPayloadApnsPayloadApsToJson(
  PushNotificationJobPayloadApnsPayloadAps instance,
) => <String, dynamic>{
  'category': ?instance.category,
  'sound': ?instance.sound,
  'badge': ?instance.badge,
};
