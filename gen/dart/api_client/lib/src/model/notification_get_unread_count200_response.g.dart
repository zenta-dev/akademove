// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_get_unread_count200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$NotificationGetUnreadCount200ResponseCWProxy {
  NotificationGetUnreadCount200Response message(String? message);

  NotificationGetUnreadCount200Response data(
    NotificationGetUnreadCount200ResponseData data,
  );

  NotificationGetUnreadCount200Response pagination(
    PaginationResult? pagination,
  );

  NotificationGetUnreadCount200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `NotificationGetUnreadCount200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// NotificationGetUnreadCount200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  NotificationGetUnreadCount200Response call({
    String? message,
    NotificationGetUnreadCount200ResponseData data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfNotificationGetUnreadCount200Response.copyWith(...)` or call `instanceOfNotificationGetUnreadCount200Response.copyWith.fieldName(value)` for a single field.
class _$NotificationGetUnreadCount200ResponseCWProxyImpl
    implements _$NotificationGetUnreadCount200ResponseCWProxy {
  const _$NotificationGetUnreadCount200ResponseCWProxyImpl(this._value);

  final NotificationGetUnreadCount200Response _value;

  @override
  NotificationGetUnreadCount200Response message(String? message) =>
      call(message: message);

  @override
  NotificationGetUnreadCount200Response data(
    NotificationGetUnreadCount200ResponseData data,
  ) => call(data: data);

  @override
  NotificationGetUnreadCount200Response pagination(
    PaginationResult? pagination,
  ) => call(pagination: pagination);

  @override
  NotificationGetUnreadCount200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `NotificationGetUnreadCount200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// NotificationGetUnreadCount200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  NotificationGetUnreadCount200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return NotificationGetUnreadCount200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String?,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as NotificationGetUnreadCount200ResponseData,
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

extension $NotificationGetUnreadCount200ResponseCopyWith
    on NotificationGetUnreadCount200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfNotificationGetUnreadCount200Response.copyWith(...)` or `instanceOfNotificationGetUnreadCount200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$NotificationGetUnreadCount200ResponseCWProxy get copyWith =>
      _$NotificationGetUnreadCount200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationGetUnreadCount200Response
_$NotificationGetUnreadCount200ResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('NotificationGetUnreadCount200Response', json, (
      $checkedConvert,
    ) {
      $checkKeys(json, requiredKeys: const ['message', 'data']);
      final val = NotificationGetUnreadCount200Response(
        message: $checkedConvert('message', (v) => v as String?),
        data: $checkedConvert(
          'data',
          (v) => NotificationGetUnreadCount200ResponseData.fromJson(
            v as Map<String, dynamic>,
          ),
        ),
        pagination: $checkedConvert(
          'pagination',
          (v) => v == null
              ? null
              : PaginationResult.fromJson(v as Map<String, dynamic>),
        ),
        totalPages: $checkedConvert('totalPages', (v) => (v as num?)?.toInt()),
      );
      return val;
    });

Map<String, dynamic> _$NotificationGetUnreadCount200ResponseToJson(
  NotificationGetUnreadCount200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
