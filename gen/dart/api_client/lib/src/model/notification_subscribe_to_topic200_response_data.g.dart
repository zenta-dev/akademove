// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_subscribe_to_topic200_response_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$NotificationSubscribeToTopic200ResponseDataCWProxy {
  NotificationSubscribeToTopic200ResponseData successCount(num successCount);

  NotificationSubscribeToTopic200ResponseData failureCount(num failureCount);

  NotificationSubscribeToTopic200ResponseData errors(Object? errors);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `NotificationSubscribeToTopic200ResponseData(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// NotificationSubscribeToTopic200ResponseData(...).copyWith(id: 12, name: "My name")
  /// ```
  NotificationSubscribeToTopic200ResponseData call({
    num successCount,
    num failureCount,
    Object? errors,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfNotificationSubscribeToTopic200ResponseData.copyWith(...)` or call `instanceOfNotificationSubscribeToTopic200ResponseData.copyWith.fieldName(value)` for a single field.
class _$NotificationSubscribeToTopic200ResponseDataCWProxyImpl
    implements _$NotificationSubscribeToTopic200ResponseDataCWProxy {
  const _$NotificationSubscribeToTopic200ResponseDataCWProxyImpl(this._value);

  final NotificationSubscribeToTopic200ResponseData _value;

  @override
  NotificationSubscribeToTopic200ResponseData successCount(num successCount) =>
      call(successCount: successCount);

  @override
  NotificationSubscribeToTopic200ResponseData failureCount(num failureCount) =>
      call(failureCount: failureCount);

  @override
  NotificationSubscribeToTopic200ResponseData errors(Object? errors) =>
      call(errors: errors);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `NotificationSubscribeToTopic200ResponseData(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// NotificationSubscribeToTopic200ResponseData(...).copyWith(id: 12, name: "My name")
  /// ```
  NotificationSubscribeToTopic200ResponseData call({
    Object? successCount = const $CopyWithPlaceholder(),
    Object? failureCount = const $CopyWithPlaceholder(),
    Object? errors = const $CopyWithPlaceholder(),
  }) {
    return NotificationSubscribeToTopic200ResponseData(
      successCount:
          successCount == const $CopyWithPlaceholder() || successCount == null
          ? _value.successCount
          // ignore: cast_nullable_to_non_nullable
          : successCount as num,
      failureCount:
          failureCount == const $CopyWithPlaceholder() || failureCount == null
          ? _value.failureCount
          // ignore: cast_nullable_to_non_nullable
          : failureCount as num,
      errors: errors == const $CopyWithPlaceholder()
          ? _value.errors
          // ignore: cast_nullable_to_non_nullable
          : errors as Object?,
    );
  }
}

extension $NotificationSubscribeToTopic200ResponseDataCopyWith
    on NotificationSubscribeToTopic200ResponseData {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfNotificationSubscribeToTopic200ResponseData.copyWith(...)` or `instanceOfNotificationSubscribeToTopic200ResponseData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$NotificationSubscribeToTopic200ResponseDataCWProxy get copyWith =>
      _$NotificationSubscribeToTopic200ResponseDataCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationSubscribeToTopic200ResponseData
_$NotificationSubscribeToTopic200ResponseDataFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('NotificationSubscribeToTopic200ResponseData', json, (
  $checkedConvert,
) {
  $checkKeys(json, requiredKeys: const ['successCount', 'failureCount']);
  final val = NotificationSubscribeToTopic200ResponseData(
    successCount: $checkedConvert('successCount', (v) => v as num),
    failureCount: $checkedConvert('failureCount', (v) => v as num),
    errors: $checkedConvert('errors', (v) => v),
  );
  return val;
});

Map<String, dynamic> _$NotificationSubscribeToTopic200ResponseDataToJson(
  NotificationSubscribeToTopic200ResponseData instance,
) => <String, dynamic>{
  'successCount': instance.successCount,
  'failureCount': instance.failureCount,
  'errors': ?instance.errors,
};
