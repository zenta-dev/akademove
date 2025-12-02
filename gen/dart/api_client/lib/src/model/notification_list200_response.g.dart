// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_list200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$NotificationList200ResponseCWProxy {
  NotificationList200Response message(String message);

  NotificationList200Response data(List<UserNotification> data);

  NotificationList200Response pagination(PaginationResult? pagination);

  NotificationList200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `NotificationList200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// NotificationList200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  NotificationList200Response call({
    String message,
    List<UserNotification> data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfNotificationList200Response.copyWith(...)` or call `instanceOfNotificationList200Response.copyWith.fieldName(value)` for a single field.
class _$NotificationList200ResponseCWProxyImpl implements _$NotificationList200ResponseCWProxy {
  const _$NotificationList200ResponseCWProxyImpl(this._value);

  final NotificationList200Response _value;

  @override
  NotificationList200Response message(String message) => call(message: message);

  @override
  NotificationList200Response data(List<UserNotification> data) => call(data: data);

  @override
  NotificationList200Response pagination(PaginationResult? pagination) => call(pagination: pagination);

  @override
  NotificationList200Response totalPages(int? totalPages) => call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `NotificationList200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// NotificationList200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  NotificationList200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return NotificationList200Response(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as List<UserNotification>,
      pagination: pagination == const $CopyWithPlaceholder()
          ? _value.pagination
          // ignore: cast_nullable_to_non_nullable
          : pagination as PaginationResult?,
      totalPages: totalPages == const $CopyWithPlaceholder()
          ? _value.totalPages
          // ignore: cast_nullable_to_non_nullable
          : totalPages as int?,
    );
  }
}

extension $NotificationList200ResponseCopyWith on NotificationList200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfNotificationList200Response.copyWith(...)` or `instanceOfNotificationList200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$NotificationList200ResponseCWProxy get copyWith => _$NotificationList200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationList200Response _$NotificationList200ResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('NotificationList200Response', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['message', 'data']);
      final val = NotificationList200Response(
        message: $checkedConvert('message', (v) => v as String),
        data: $checkedConvert(
          'data',
          (v) => (v as List<dynamic>).map((e) => UserNotification.fromJson(e as Map<String, dynamic>)).toList(),
        ),
        pagination: $checkedConvert(
          'pagination',
          (v) => v == null ? null : PaginationResult.fromJson(v as Map<String, dynamic>),
        ),
        totalPages: $checkedConvert('totalPages', (v) => (v as num?)?.toInt()),
      );
      return val;
    });

Map<String, dynamic> _$NotificationList200ResponseToJson(NotificationList200Response instance) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.map((e) => e.toJson()).toList(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
