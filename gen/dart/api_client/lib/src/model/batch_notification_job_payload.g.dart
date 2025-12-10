// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'batch_notification_job_payload.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BatchNotificationJobPayloadCWProxy {
  BatchNotificationJobPayload orderId(String orderId);

  BatchNotificationJobPayload driverUserIds(List<String> driverUserIds);

  BatchNotificationJobPayload notification(
    BatchNotificationJobPayloadNotification notification,
  );

  BatchNotificationJobPayload sendWebSocket(bool? sendWebSocket);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `BatchNotificationJobPayload(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BatchNotificationJobPayload(...).copyWith(id: 12, name: "My name")
  /// ```
  BatchNotificationJobPayload call({
    String orderId,
    List<String> driverUserIds,
    BatchNotificationJobPayloadNotification notification,
    bool? sendWebSocket,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfBatchNotificationJobPayload.copyWith(...)` or call `instanceOfBatchNotificationJobPayload.copyWith.fieldName(value)` for a single field.
class _$BatchNotificationJobPayloadCWProxyImpl
    implements _$BatchNotificationJobPayloadCWProxy {
  const _$BatchNotificationJobPayloadCWProxyImpl(this._value);

  final BatchNotificationJobPayload _value;

  @override
  BatchNotificationJobPayload orderId(String orderId) => call(orderId: orderId);

  @override
  BatchNotificationJobPayload driverUserIds(List<String> driverUserIds) =>
      call(driverUserIds: driverUserIds);

  @override
  BatchNotificationJobPayload notification(
    BatchNotificationJobPayloadNotification notification,
  ) => call(notification: notification);

  @override
  BatchNotificationJobPayload sendWebSocket(bool? sendWebSocket) =>
      call(sendWebSocket: sendWebSocket);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `BatchNotificationJobPayload(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BatchNotificationJobPayload(...).copyWith(id: 12, name: "My name")
  /// ```
  BatchNotificationJobPayload call({
    Object? orderId = const $CopyWithPlaceholder(),
    Object? driverUserIds = const $CopyWithPlaceholder(),
    Object? notification = const $CopyWithPlaceholder(),
    Object? sendWebSocket = const $CopyWithPlaceholder(),
  }) {
    return BatchNotificationJobPayload(
      orderId: orderId == const $CopyWithPlaceholder() || orderId == null
          ? _value.orderId
          // ignore: cast_nullable_to_non_nullable
          : orderId as String,
      driverUserIds:
          driverUserIds == const $CopyWithPlaceholder() || driverUserIds == null
          ? _value.driverUserIds
          // ignore: cast_nullable_to_non_nullable
          : driverUserIds as List<String>,
      notification:
          notification == const $CopyWithPlaceholder() || notification == null
          ? _value.notification
          // ignore: cast_nullable_to_non_nullable
          : notification as BatchNotificationJobPayloadNotification,
      sendWebSocket: sendWebSocket == const $CopyWithPlaceholder()
          ? _value.sendWebSocket
          // ignore: cast_nullable_to_non_nullable
          : sendWebSocket as bool?,
    );
  }
}

extension $BatchNotificationJobPayloadCopyWith on BatchNotificationJobPayload {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfBatchNotificationJobPayload.copyWith(...)` or `instanceOfBatchNotificationJobPayload.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BatchNotificationJobPayloadCWProxy get copyWith =>
      _$BatchNotificationJobPayloadCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BatchNotificationJobPayload _$BatchNotificationJobPayloadFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('BatchNotificationJobPayload', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const ['orderId', 'driverUserIds', 'notification'],
  );
  final val = BatchNotificationJobPayload(
    orderId: $checkedConvert('orderId', (v) => v as String),
    driverUserIds: $checkedConvert(
      'driverUserIds',
      (v) => (v as List<dynamic>).map((e) => e as String).toList(),
    ),
    notification: $checkedConvert(
      'notification',
      (v) => BatchNotificationJobPayloadNotification.fromJson(
        v as Map<String, dynamic>,
      ),
    ),
    sendWebSocket: $checkedConvert('sendWebSocket', (v) => v as bool? ?? true),
  );
  return val;
});

Map<String, dynamic> _$BatchNotificationJobPayloadToJson(
  BatchNotificationJobPayload instance,
) => <String, dynamic>{
  'orderId': instance.orderId,
  'driverUserIds': instance.driverUserIds,
  'notification': instance.notification.toJson(),
  'sendWebSocket': ?instance.sendWebSocket,
};
