// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_mark_as_read200_response_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$NotificationMarkAsRead200ResponseDataCWProxy {
  NotificationMarkAsRead200ResponseData id(String id);

  NotificationMarkAsRead200ResponseData userId(String userId);

  NotificationMarkAsRead200ResponseData title(String title);

  NotificationMarkAsRead200ResponseData body(String body);

  NotificationMarkAsRead200ResponseData data(Object? data);

  NotificationMarkAsRead200ResponseData messageId(String? messageId);

  NotificationMarkAsRead200ResponseData isRead(bool isRead);

  NotificationMarkAsRead200ResponseData createdAt(DateTime createdAt);

  NotificationMarkAsRead200ResponseData readAt(DateTime? readAt);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `NotificationMarkAsRead200ResponseData(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// NotificationMarkAsRead200ResponseData(...).copyWith(id: 12, name: "My name")
  /// ```
  NotificationMarkAsRead200ResponseData call({
    String id,
    String userId,
    String title,
    String body,
    Object? data,
    String? messageId,
    bool isRead,
    DateTime createdAt,
    DateTime? readAt,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfNotificationMarkAsRead200ResponseData.copyWith(...)` or call `instanceOfNotificationMarkAsRead200ResponseData.copyWith.fieldName(value)` for a single field.
class _$NotificationMarkAsRead200ResponseDataCWProxyImpl
    implements _$NotificationMarkAsRead200ResponseDataCWProxy {
  const _$NotificationMarkAsRead200ResponseDataCWProxyImpl(this._value);

  final NotificationMarkAsRead200ResponseData _value;

  @override
  NotificationMarkAsRead200ResponseData id(String id) => call(id: id);

  @override
  NotificationMarkAsRead200ResponseData userId(String userId) =>
      call(userId: userId);

  @override
  NotificationMarkAsRead200ResponseData title(String title) =>
      call(title: title);

  @override
  NotificationMarkAsRead200ResponseData body(String body) => call(body: body);

  @override
  NotificationMarkAsRead200ResponseData data(Object? data) => call(data: data);

  @override
  NotificationMarkAsRead200ResponseData messageId(String? messageId) =>
      call(messageId: messageId);

  @override
  NotificationMarkAsRead200ResponseData isRead(bool isRead) =>
      call(isRead: isRead);

  @override
  NotificationMarkAsRead200ResponseData createdAt(DateTime createdAt) =>
      call(createdAt: createdAt);

  @override
  NotificationMarkAsRead200ResponseData readAt(DateTime? readAt) =>
      call(readAt: readAt);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `NotificationMarkAsRead200ResponseData(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// NotificationMarkAsRead200ResponseData(...).copyWith(id: 12, name: "My name")
  /// ```
  NotificationMarkAsRead200ResponseData call({
    Object? id = const $CopyWithPlaceholder(),
    Object? userId = const $CopyWithPlaceholder(),
    Object? title = const $CopyWithPlaceholder(),
    Object? body = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? messageId = const $CopyWithPlaceholder(),
    Object? isRead = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? readAt = const $CopyWithPlaceholder(),
  }) {
    return NotificationMarkAsRead200ResponseData(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      userId: userId == const $CopyWithPlaceholder() || userId == null
          ? _value.userId
          // ignore: cast_nullable_to_non_nullable
          : userId as String,
      title: title == const $CopyWithPlaceholder() || title == null
          ? _value.title
          // ignore: cast_nullable_to_non_nullable
          : title as String,
      body: body == const $CopyWithPlaceholder() || body == null
          ? _value.body
          // ignore: cast_nullable_to_non_nullable
          : body as String,
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as Object?,
      messageId: messageId == const $CopyWithPlaceholder()
          ? _value.messageId
          // ignore: cast_nullable_to_non_nullable
          : messageId as String?,
      isRead: isRead == const $CopyWithPlaceholder() || isRead == null
          ? _value.isRead
          // ignore: cast_nullable_to_non_nullable
          : isRead as bool,
      createdAt: createdAt == const $CopyWithPlaceholder() || createdAt == null
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime,
      readAt: readAt == const $CopyWithPlaceholder()
          ? _value.readAt
          // ignore: cast_nullable_to_non_nullable
          : readAt as DateTime?,
    );
  }
}

extension $NotificationMarkAsRead200ResponseDataCopyWith
    on NotificationMarkAsRead200ResponseData {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfNotificationMarkAsRead200ResponseData.copyWith(...)` or `instanceOfNotificationMarkAsRead200ResponseData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$NotificationMarkAsRead200ResponseDataCWProxy get copyWith =>
      _$NotificationMarkAsRead200ResponseDataCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationMarkAsRead200ResponseData
_$NotificationMarkAsRead200ResponseDataFromJson(Map<String, dynamic> json) =>
    $checkedCreate('NotificationMarkAsRead200ResponseData', json, (
      $checkedConvert,
    ) {
      $checkKeys(
        json,
        requiredKeys: const [
          'id',
          'userId',
          'title',
          'body',
          'isRead',
          'createdAt',
        ],
      );
      final val = NotificationMarkAsRead200ResponseData(
        id: $checkedConvert('id', (v) => v as String),
        userId: $checkedConvert('userId', (v) => v as String),
        title: $checkedConvert('title', (v) => v as String),
        body: $checkedConvert('body', (v) => v as String),
        data: $checkedConvert('data', (v) => v),
        messageId: $checkedConvert('messageId', (v) => v as String?),
        isRead: $checkedConvert('isRead', (v) => v as bool),
        createdAt: $checkedConvert(
          'createdAt',
          (v) => DateTime.parse(v as String),
        ),
        readAt: $checkedConvert(
          'readAt',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
      );
      return val;
    });

Map<String, dynamic> _$NotificationMarkAsRead200ResponseDataToJson(
  NotificationMarkAsRead200ResponseData instance,
) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'title': instance.title,
  'body': instance.body,
  'data': ?instance.data,
  'messageId': ?instance.messageId,
  'isRead': instance.isRead,
  'createdAt': instance.createdAt.toIso8601String(),
  'readAt': ?instance.readAt?.toIso8601String(),
};
