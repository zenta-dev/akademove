// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_list200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$NotificationList200ResponseCWProxy {
  NotificationList200Response message(String message);

  NotificationList200Response data(List<UserNotification> data);

  NotificationList200Response totalPages(int? totalPages);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `NotificationList200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// NotificationList200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  NotificationList200Response call({
    String message,
    List<UserNotification> data,
    int? totalPages,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfNotificationList200Response.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfNotificationList200Response.copyWith.fieldName(...)`
class _$NotificationList200ResponseCWProxyImpl
    implements _$NotificationList200ResponseCWProxy {
  const _$NotificationList200ResponseCWProxyImpl(this._value);

  final NotificationList200Response _value;

  @override
  NotificationList200Response message(String message) => this(message: message);

  @override
  NotificationList200Response data(List<UserNotification> data) =>
      this(data: data);

  @override
  NotificationList200Response totalPages(int? totalPages) =>
      this(totalPages: totalPages);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `NotificationList200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// NotificationList200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  NotificationList200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return NotificationList200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as List<UserNotification>,
      totalPages: totalPages == const $CopyWithPlaceholder()
          ? _value.totalPages
          // ignore: cast_nullable_to_non_nullable
          : totalPages as int?,
    );
  }
}

extension $NotificationList200ResponseCopyWith on NotificationList200Response {
  /// Returns a callable class that can be used as follows: `instanceOfNotificationList200Response.copyWith(...)` or like so:`instanceOfNotificationList200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$NotificationList200ResponseCWProxy get copyWith =>
      _$NotificationList200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationList200Response _$NotificationList200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('NotificationList200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = NotificationList200Response(
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) => (v as List<dynamic>)
          .map((e) => UserNotification.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
    totalPages: $checkedConvert('totalPages', (v) => (v as num?)?.toInt()),
  );
  return val;
});

Map<String, dynamic> _$NotificationList200ResponseToJson(
  NotificationList200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.map((e) => e.toJson()).toList(),
  'totalPages': ?instance.totalPages,
};
