// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fcm_notification_log.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$FCMNotificationLogCWProxy {
  FCMNotificationLog id(String id);

  FCMNotificationLog userId(String userId);

  FCMNotificationLog token(String? token);

  FCMNotificationLog topic(String? topic);

  FCMNotificationLog title(String title);

  FCMNotificationLog body(String body);

  FCMNotificationLog data(Object? data);

  FCMNotificationLog messageId(String? messageId);

  FCMNotificationLog status(FCMNotificationLogStatusEnum status);

  FCMNotificationLog error(String? error);

  FCMNotificationLog sentAt(DateTime sentAt);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `FCMNotificationLog(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// FCMNotificationLog(...).copyWith(id: 12, name: "My name")
  /// ````
  FCMNotificationLog call({
    String id,
    String userId,
    String? token,
    String? topic,
    String title,
    String body,
    Object? data,
    String? messageId,
    FCMNotificationLogStatusEnum status,
    String? error,
    DateTime sentAt,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfFCMNotificationLog.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfFCMNotificationLog.copyWith.fieldName(...)`
class _$FCMNotificationLogCWProxyImpl implements _$FCMNotificationLogCWProxy {
  const _$FCMNotificationLogCWProxyImpl(this._value);

  final FCMNotificationLog _value;

  @override
  FCMNotificationLog id(String id) => this(id: id);

  @override
  FCMNotificationLog userId(String userId) => this(userId: userId);

  @override
  FCMNotificationLog token(String? token) => this(token: token);

  @override
  FCMNotificationLog topic(String? topic) => this(topic: topic);

  @override
  FCMNotificationLog title(String title) => this(title: title);

  @override
  FCMNotificationLog body(String body) => this(body: body);

  @override
  FCMNotificationLog data(Object? data) => this(data: data);

  @override
  FCMNotificationLog messageId(String? messageId) => this(messageId: messageId);

  @override
  FCMNotificationLog status(FCMNotificationLogStatusEnum status) =>
      this(status: status);

  @override
  FCMNotificationLog error(String? error) => this(error: error);

  @override
  FCMNotificationLog sentAt(DateTime sentAt) => this(sentAt: sentAt);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `FCMNotificationLog(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// FCMNotificationLog(...).copyWith(id: 12, name: "My name")
  /// ````
  FCMNotificationLog call({
    Object? id = const $CopyWithPlaceholder(),
    Object? userId = const $CopyWithPlaceholder(),
    Object? token = const $CopyWithPlaceholder(),
    Object? topic = const $CopyWithPlaceholder(),
    Object? title = const $CopyWithPlaceholder(),
    Object? body = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? messageId = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? error = const $CopyWithPlaceholder(),
    Object? sentAt = const $CopyWithPlaceholder(),
  }) {
    return FCMNotificationLog(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      userId: userId == const $CopyWithPlaceholder()
          ? _value.userId
          // ignore: cast_nullable_to_non_nullable
          : userId as String,
      token: token == const $CopyWithPlaceholder()
          ? _value.token
          // ignore: cast_nullable_to_non_nullable
          : token as String?,
      topic: topic == const $CopyWithPlaceholder()
          ? _value.topic
          // ignore: cast_nullable_to_non_nullable
          : topic as String?,
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
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as FCMNotificationLogStatusEnum,
      error: error == const $CopyWithPlaceholder()
          ? _value.error
          // ignore: cast_nullable_to_non_nullable
          : error as String?,
      sentAt: sentAt == const $CopyWithPlaceholder()
          ? _value.sentAt
          // ignore: cast_nullable_to_non_nullable
          : sentAt as DateTime,
    );
  }
}

extension $FCMNotificationLogCopyWith on FCMNotificationLog {
  /// Returns a callable class that can be used as follows: `instanceOfFCMNotificationLog.copyWith(...)` or like so:`instanceOfFCMNotificationLog.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$FCMNotificationLogCWProxy get copyWith =>
      _$FCMNotificationLogCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FCMNotificationLog _$FCMNotificationLogFromJson(Map<String, dynamic> json) =>
    $checkedCreate('FCMNotificationLog', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'id',
          'userId',
          'title',
          'body',
          'status',
          'sentAt',
        ],
      );
      final val = FCMNotificationLog(
        id: $checkedConvert('id', (v) => v as String),
        userId: $checkedConvert('userId', (v) => v as String),
        token: $checkedConvert('token', (v) => v as String?),
        topic: $checkedConvert('topic', (v) => v as String?),
        title: $checkedConvert('title', (v) => v as String),
        body: $checkedConvert('body', (v) => v as String),
        data: $checkedConvert('data', (v) => v),
        messageId: $checkedConvert('messageId', (v) => v as String?),
        status: $checkedConvert(
          'status',
          (v) => $enumDecode(_$FCMNotificationLogStatusEnumEnumMap, v),
        ),
        error: $checkedConvert('error', (v) => v as String?),
        sentAt: $checkedConvert('sentAt', (v) => DateTime.parse(v as String)),
      );
      return val;
    });

Map<String, dynamic> _$FCMNotificationLogToJson(FCMNotificationLog instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'token': ?instance.token,
      'topic': ?instance.topic,
      'title': instance.title,
      'body': instance.body,
      'data': ?instance.data,
      'messageId': ?instance.messageId,
      'status': _$FCMNotificationLogStatusEnumEnumMap[instance.status]!,
      'error': ?instance.error,
      'sentAt': instance.sentAt.toIso8601String(),
    };

const _$FCMNotificationLogStatusEnumEnumMap = {
  FCMNotificationLogStatusEnum.success: 'success',
  FCMNotificationLogStatusEnum.failed: 'failed',
};
