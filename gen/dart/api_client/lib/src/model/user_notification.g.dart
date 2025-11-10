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

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UserNotification(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserNotification(...).copyWith(id: 12, name: "My name")
  /// ````
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

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUserNotification.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUserNotification.copyWith.fieldName(...)`
class _$UserNotificationCWProxyImpl implements _$UserNotificationCWProxy {
  const _$UserNotificationCWProxyImpl(this._value);

  final UserNotification _value;

  @override
  UserNotification id(String id) => this(id: id);

  @override
  UserNotification userId(String userId) => this(userId: userId);

  @override
  UserNotification title(String title) => this(title: title);

  @override
  UserNotification body(String body) => this(body: body);

  @override
  UserNotification data(Object? data) => this(data: data);

  @override
  UserNotification messageId(String? messageId) => this(messageId: messageId);

  @override
  UserNotification isRead(bool isRead) => this(isRead: isRead);

  @override
  UserNotification createdAt(DateTime createdAt) => this(createdAt: createdAt);

  @override
  UserNotification readAt(DateTime? readAt) => this(readAt: readAt);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UserNotification(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserNotification(...).copyWith(id: 12, name: "My name")
  /// ````
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
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      userId: userId == const $CopyWithPlaceholder()
          ? _value.userId
          // ignore: cast_nullable_to_non_nullable
          : userId as String,
      title: title == const $CopyWithPlaceholder()
          ? _value.title
          // ignore: cast_nullable_to_non_nullable
          : title as String,
      body: body == const $CopyWithPlaceholder()
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
      isRead: isRead == const $CopyWithPlaceholder()
          ? _value.isRead
          // ignore: cast_nullable_to_non_nullable
          : isRead as bool,
      createdAt: createdAt == const $CopyWithPlaceholder()
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
  /// Returns a callable class that can be used as follows: `instanceOfUserNotification.copyWith(...)` or like so:`instanceOfUserNotification.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UserNotificationCWProxy get copyWith => _$UserNotificationCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserNotification _$UserNotificationFromJson(Map<String, dynamic> json) =>
    $checkedCreate('UserNotification', json, ($checkedConvert) {
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
      final val = UserNotification(
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

Map<String, dynamic> _$UserNotificationToJson(UserNotification instance) =>
    <String, dynamic>{
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
