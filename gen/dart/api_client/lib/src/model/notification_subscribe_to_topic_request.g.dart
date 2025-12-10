// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_subscribe_to_topic_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$NotificationSubscribeToTopicRequestCWProxy {
  NotificationSubscribeToTopicRequest topic(String? topic);

  NotificationSubscribeToTopicRequest token(String? token);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `NotificationSubscribeToTopicRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// NotificationSubscribeToTopicRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  NotificationSubscribeToTopicRequest call({String? topic, String? token});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfNotificationSubscribeToTopicRequest.copyWith(...)` or call `instanceOfNotificationSubscribeToTopicRequest.copyWith.fieldName(value)` for a single field.
class _$NotificationSubscribeToTopicRequestCWProxyImpl
    implements _$NotificationSubscribeToTopicRequestCWProxy {
  const _$NotificationSubscribeToTopicRequestCWProxyImpl(this._value);

  final NotificationSubscribeToTopicRequest _value;

  @override
  NotificationSubscribeToTopicRequest topic(String? topic) =>
      call(topic: topic);

  @override
  NotificationSubscribeToTopicRequest token(String? token) =>
      call(token: token);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `NotificationSubscribeToTopicRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// NotificationSubscribeToTopicRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  NotificationSubscribeToTopicRequest call({
    Object? topic = const $CopyWithPlaceholder(),
    Object? token = const $CopyWithPlaceholder(),
  }) {
    return NotificationSubscribeToTopicRequest(
      topic: topic == const $CopyWithPlaceholder()
          ? _value.topic
          // ignore: cast_nullable_to_non_nullable
          : topic as String?,
      token: token == const $CopyWithPlaceholder()
          ? _value.token
          // ignore: cast_nullable_to_non_nullable
          : token as String?,
    );
  }
}

extension $NotificationSubscribeToTopicRequestCopyWith
    on NotificationSubscribeToTopicRequest {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfNotificationSubscribeToTopicRequest.copyWith(...)` or `instanceOfNotificationSubscribeToTopicRequest.copyWith.fieldName(...)`.
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
        topic: $checkedConvert('topic', (v) => v as String?),
        token: $checkedConvert('token', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$NotificationSubscribeToTopicRequestToJson(
  NotificationSubscribeToTopicRequest instance,
) => <String, dynamic>{'topic': instance.topic, 'token': instance.token};
