// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_get_unread_count200_response_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$NotificationGetUnreadCount200ResponseDataCWProxy {
  NotificationGetUnreadCount200ResponseData count(num count);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `NotificationGetUnreadCount200ResponseData(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// NotificationGetUnreadCount200ResponseData(...).copyWith(id: 12, name: "My name")
  /// ```
  NotificationGetUnreadCount200ResponseData call({num count});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfNotificationGetUnreadCount200ResponseData.copyWith(...)` or call `instanceOfNotificationGetUnreadCount200ResponseData.copyWith.fieldName(value)` for a single field.
class _$NotificationGetUnreadCount200ResponseDataCWProxyImpl
    implements _$NotificationGetUnreadCount200ResponseDataCWProxy {
  const _$NotificationGetUnreadCount200ResponseDataCWProxyImpl(this._value);

  final NotificationGetUnreadCount200ResponseData _value;

  @override
  NotificationGetUnreadCount200ResponseData count(num count) =>
      call(count: count);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `NotificationGetUnreadCount200ResponseData(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// NotificationGetUnreadCount200ResponseData(...).copyWith(id: 12, name: "My name")
  /// ```
  NotificationGetUnreadCount200ResponseData call({
    Object? count = const $CopyWithPlaceholder(),
  }) {
    return NotificationGetUnreadCount200ResponseData(
      count: count == const $CopyWithPlaceholder() || count == null
          ? _value.count
          // ignore: cast_nullable_to_non_nullable
          : count as num,
    );
  }
}

extension $NotificationGetUnreadCount200ResponseDataCopyWith
    on NotificationGetUnreadCount200ResponseData {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfNotificationGetUnreadCount200ResponseData.copyWith(...)` or `instanceOfNotificationGetUnreadCount200ResponseData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$NotificationGetUnreadCount200ResponseDataCWProxy get copyWith =>
      _$NotificationGetUnreadCount200ResponseDataCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationGetUnreadCount200ResponseData
_$NotificationGetUnreadCount200ResponseDataFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('NotificationGetUnreadCount200ResponseData', json, (
  $checkedConvert,
) {
  $checkKeys(json, requiredKeys: const ['count']);
  final val = NotificationGetUnreadCount200ResponseData(
    count: $checkedConvert('count', (v) => v as num),
  );
  return val;
});

Map<String, dynamic> _$NotificationGetUnreadCount200ResponseDataToJson(
  NotificationGetUnreadCount200ResponseData instance,
) => <String, dynamic>{'count': instance.count};
