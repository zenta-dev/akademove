// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_list200_response_data_inner.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$NotificationList200ResponseDataInnerCWProxy {
  NotificationList200ResponseDataInner id(String? id);

  NotificationList200ResponseDataInner userId(String? userId);

  NotificationList200ResponseDataInner title(String? title);

  NotificationList200ResponseDataInner body(String? body);

  NotificationList200ResponseDataInner data(Object? data);

  NotificationList200ResponseDataInner messageId(String? messageId);

  NotificationList200ResponseDataInner isRead(bool isRead);

  NotificationList200ResponseDataInner createdAt(DateTime? createdAt);

  NotificationList200ResponseDataInner readAt(DateTime? readAt);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `NotificationList200ResponseDataInner(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// NotificationList200ResponseDataInner(...).copyWith(id: 12, name: "My name")
  /// ```
  NotificationList200ResponseDataInner call({
    String? id,
    String? userId,
    String? title,
    String? body,
    Object? data,
    String? messageId,
    bool isRead,
    DateTime? createdAt,
    DateTime? readAt,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfNotificationList200ResponseDataInner.copyWith(...)` or call `instanceOfNotificationList200ResponseDataInner.copyWith.fieldName(value)` for a single field.
class _$NotificationList200ResponseDataInnerCWProxyImpl
    implements _$NotificationList200ResponseDataInnerCWProxy {
  const _$NotificationList200ResponseDataInnerCWProxyImpl(this._value);

  final NotificationList200ResponseDataInner _value;

  @override
  NotificationList200ResponseDataInner id(String? id) => call(id: id);

  @override
  NotificationList200ResponseDataInner userId(String? userId) =>
      call(userId: userId);

  @override
  NotificationList200ResponseDataInner title(String? title) =>
      call(title: title);

  @override
  NotificationList200ResponseDataInner body(String? body) => call(body: body);

  @override
  NotificationList200ResponseDataInner data(Object? data) => call(data: data);

  @override
  NotificationList200ResponseDataInner messageId(String? messageId) =>
      call(messageId: messageId);

  @override
  NotificationList200ResponseDataInner isRead(bool isRead) =>
      call(isRead: isRead);

  @override
  NotificationList200ResponseDataInner createdAt(DateTime? createdAt) =>
      call(createdAt: createdAt);

  @override
  NotificationList200ResponseDataInner readAt(DateTime? readAt) =>
      call(readAt: readAt);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `NotificationList200ResponseDataInner(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// NotificationList200ResponseDataInner(...).copyWith(id: 12, name: "My name")
  /// ```
  NotificationList200ResponseDataInner call({
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
    return NotificationList200ResponseDataInner(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String?,
      userId: userId == const $CopyWithPlaceholder()
          ? _value.userId
          // ignore: cast_nullable_to_non_nullable
          : userId as String?,
      title: title == const $CopyWithPlaceholder()
          ? _value.title
          // ignore: cast_nullable_to_non_nullable
          : title as String?,
      body: body == const $CopyWithPlaceholder()
          ? _value.body
          // ignore: cast_nullable_to_non_nullable
          : body as String?,
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
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime?,
      readAt: readAt == const $CopyWithPlaceholder()
          ? _value.readAt
          // ignore: cast_nullable_to_non_nullable
          : readAt as DateTime?,
    );
  }
}

extension $NotificationList200ResponseDataInnerCopyWith
    on NotificationList200ResponseDataInner {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfNotificationList200ResponseDataInner.copyWith(...)` or `instanceOfNotificationList200ResponseDataInner.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$NotificationList200ResponseDataInnerCWProxy get copyWith =>
      _$NotificationList200ResponseDataInnerCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationList200ResponseDataInner
_$NotificationList200ResponseDataInnerFromJson(Map<String, dynamic> json) =>
    $checkedCreate('NotificationList200ResponseDataInner', json, (
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
      final val = NotificationList200ResponseDataInner(
        id: $checkedConvert('id', (v) => v as String?),
        userId: $checkedConvert('userId', (v) => v as String?),
        title: $checkedConvert('title', (v) => v as String?),
        body: $checkedConvert('body', (v) => v as String?),
        data: $checkedConvert('data', (v) => v),
        messageId: $checkedConvert('messageId', (v) => v as String?),
        isRead: $checkedConvert('isRead', (v) => v as bool),
        createdAt: $checkedConvert(
          'createdAt',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
        readAt: $checkedConvert(
          'readAt',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
      );
      return val;
    });

Map<String, dynamic> _$NotificationList200ResponseDataInnerToJson(
  NotificationList200ResponseDataInner instance,
) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'title': instance.title,
  'body': instance.body,
  'data': ?instance.data,
  'messageId': ?instance.messageId,
  'isRead': instance.isRead,
  'createdAt': instance.createdAt?.toIso8601String(),
  'readAt': ?instance.readAt?.toIso8601String(),
};
