// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'push_notification_job_payload_apns_payload.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PushNotificationJobPayloadApnsPayloadCWProxy {
  PushNotificationJobPayloadApnsPayload aps(
    PushNotificationJobPayloadApnsPayloadAps? aps,
  );

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `PushNotificationJobPayloadApnsPayload(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PushNotificationJobPayloadApnsPayload(...).copyWith(id: 12, name: "My name")
  /// ```
  PushNotificationJobPayloadApnsPayload call({
    PushNotificationJobPayloadApnsPayloadAps? aps,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfPushNotificationJobPayloadApnsPayload.copyWith(...)` or call `instanceOfPushNotificationJobPayloadApnsPayload.copyWith.fieldName(value)` for a single field.
class _$PushNotificationJobPayloadApnsPayloadCWProxyImpl
    implements _$PushNotificationJobPayloadApnsPayloadCWProxy {
  const _$PushNotificationJobPayloadApnsPayloadCWProxyImpl(this._value);

  final PushNotificationJobPayloadApnsPayload _value;

  @override
  PushNotificationJobPayloadApnsPayload aps(
    PushNotificationJobPayloadApnsPayloadAps? aps,
  ) => call(aps: aps);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `PushNotificationJobPayloadApnsPayload(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PushNotificationJobPayloadApnsPayload(...).copyWith(id: 12, name: "My name")
  /// ```
  PushNotificationJobPayloadApnsPayload call({
    Object? aps = const $CopyWithPlaceholder(),
  }) {
    return PushNotificationJobPayloadApnsPayload(
      aps: aps == const $CopyWithPlaceholder()
          ? _value.aps
          // ignore: cast_nullable_to_non_nullable
          : aps as PushNotificationJobPayloadApnsPayloadAps?,
    );
  }
}

extension $PushNotificationJobPayloadApnsPayloadCopyWith
    on PushNotificationJobPayloadApnsPayload {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfPushNotificationJobPayloadApnsPayload.copyWith(...)` or `instanceOfPushNotificationJobPayloadApnsPayload.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PushNotificationJobPayloadApnsPayloadCWProxy get copyWith =>
      _$PushNotificationJobPayloadApnsPayloadCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PushNotificationJobPayloadApnsPayload
_$PushNotificationJobPayloadApnsPayloadFromJson(Map<String, dynamic> json) =>
    $checkedCreate('PushNotificationJobPayloadApnsPayload', json, (
      $checkedConvert,
    ) {
      final val = PushNotificationJobPayloadApnsPayload(
        aps: $checkedConvert(
          'aps',
          (v) => v == null
              ? null
              : PushNotificationJobPayloadApnsPayloadAps.fromJson(
                  v as Map<String, dynamic>,
                ),
        ),
      );
      return val;
    });

Map<String, dynamic> _$PushNotificationJobPayloadApnsPayloadToJson(
  PushNotificationJobPayloadApnsPayload instance,
) => <String, dynamic>{'aps': ?instance.aps?.toJson()};
