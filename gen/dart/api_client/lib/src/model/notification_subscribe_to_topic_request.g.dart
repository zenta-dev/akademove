// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_subscribe_to_topic_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$NotificationSubscribeToTopicRequestCWProxy {
  NotificationSubscribeToTopicRequest topic(String topic);

  NotificationSubscribeToTopicRequest token(String token);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `NotificationSubscribeToTopicRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// NotificationSubscribeToTopicRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  NotificationSubscribeToTopicRequest call({String topic, String token});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfNotificationSubscribeToTopicRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfNotificationSubscribeToTopicRequest.copyWith.fieldName(...)`
class _$NotificationSubscribeToTopicRequestCWProxyImpl
    implements _$NotificationSubscribeToTopicRequestCWProxy {
  const _$NotificationSubscribeToTopicRequestCWProxyImpl(this._value);

  final NotificationSubscribeToTopicRequest _value;

  @override
  NotificationSubscribeToTopicRequest topic(String topic) => this(topic: topic);

  @override
  NotificationSubscribeToTopicRequest token(String token) => this(token: token);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `NotificationSubscribeToTopicRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// NotificationSubscribeToTopicRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  NotificationSubscribeToTopicRequest call({
    Object? topic = const $CopyWithPlaceholder(),
    Object? token = const $CopyWithPlaceholder(),
  }) {
    return NotificationSubscribeToTopicRequest(
      topic: topic == const $CopyWithPlaceholder()
          ? _value.topic
          // ignore: cast_nullable_to_non_nullable
          : topic as String,
      token: token == const $CopyWithPlaceholder()
          ? _value.token
          // ignore: cast_nullable_to_non_nullable
          : token as String,
    );
  }
}

extension $NotificationSubscribeToTopicRequestCopyWith
    on NotificationSubscribeToTopicRequest {
  /// Returns a callable class that can be used as follows: `instanceOfNotificationSubscribeToTopicRequest.copyWith(...)` or like so:`instanceOfNotificationSubscribeToTopicRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$NotificationSubscribeToTopicRequestCWProxy get copyWith =>
      _$NotificationSubscribeToTopicRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationSubscribeToTopicRequest
_$NotificationSubscribeToTopicRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate('NotificationSubscribeToTopicRequest', json, (
      $checkedConvert,
    ) {
      $checkKeys(json, requiredKeys: const ['topic', 'token']);
      final val = NotificationSubscribeToTopicRequest(
        topic: $checkedConvert('topic', (v) => v as String),
        token: $checkedConvert('token', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$NotificationSubscribeToTopicRequestToJson(
  NotificationSubscribeToTopicRequest instance,
) => <String, dynamic>{'topic': instance.topic, 'token': instance.token};
