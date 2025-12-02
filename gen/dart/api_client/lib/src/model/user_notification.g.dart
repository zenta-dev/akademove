// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_notification.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UserNotificationCWProxy {
  UserNotification id(String id);

  UserNotification userId(String userId);

  UserNotification title(String title);

  UserNotification body(String body);

  UserNotification data(Object? data);

  UserNotification messageId(String? messageId);

  UserNotification isRead(bool isRead);

  UserNotification createdAt(DateTime createdAt);

  UserNotification readAt(DateTime? readAt);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UserNotification(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UserNotification(...).copyWith(id: 12, name: "My name")
  /// ```
  UserNotification call({
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
/// Use as `instanceOfUserNotification.copyWith(...)` or call `instanceOfUserNotification.copyWith.fieldName(value)` for a single field.
class _$UserNotificationCWProxyImpl implements _$UserNotificationCWProxy {
  const _$UserNotificationCWProxyImpl(this._value);

  final UserNotification _value;

  @override
  UserNotification id(String id) => call(id: id);

  @override
  UserNotification userId(String userId) => call(userId: userId);

  @override
  UserNotification title(String title) => call(title: title);

  @override
  UserNotification body(String body) => call(body: body);

  @override
  UserNotification data(Object? data) => call(data: data);

  @override
  UserNotification messageId(String? messageId) => call(messageId: messageId);

  @override
  UserNotification isRead(bool isRead) => call(isRead: isRead);

  @override
  UserNotification createdAt(DateTime createdAt) => call(createdAt: createdAt);

  @override
  UserNotification readAt(DateTime? readAt) => call(readAt: readAt);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UserNotification(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UserNotification(...).copyWith(id: 12, name: "My name")
  /// ```
  UserNotification call({
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
    return UserNotification(
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

extension $UserNotificationCopyWith on UserNotification {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfUserNotification.copyWith(...)` or `instanceOfUserNotification.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UserNotificationCWProxy get copyWith => _$UserNotificationCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserNotification _$UserNotificationFromJson(Map<String, dynamic> json) =>
    $checkedCreate('UserNotification', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['id', 'userId', 'title', 'body', 'isRead', 'createdAt']);
      final val = UserNotification(
        id: $checkedConvert('id', (v) => v as String),
        userId: $checkedConvert('userId', (v) => v as String),
        title: $checkedConvert('title', (v) => v as String),
        body: $checkedConvert('body', (v) => v as String),
        data: $checkedConvert('data', (v) => v),
        messageId: $checkedConvert('messageId', (v) => v as String?),
        isRead: $checkedConvert('isRead', (v) => v as bool),
        createdAt: $checkedConvert('createdAt', (v) => DateTime.parse(v as String)),
        readAt: $checkedConvert('readAt', (v) => v == null ? null : DateTime.parse(v as String)),
      );
      return val;
    });

Map<String, dynamic> _$UserNotificationToJson(UserNotification instance) => <String, dynamic>{
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
