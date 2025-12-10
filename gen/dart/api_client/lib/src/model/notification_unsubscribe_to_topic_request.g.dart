// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_unsubscribe_to_topic_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$NotificationUnsubscribeToTopicRequestCWProxy {
  NotificationUnsubscribeToTopicRequest topic(String topic);

  NotificationUnsubscribeToTopicRequest token(String token);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `NotificationUnsubscribeToTopicRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// NotificationUnsubscribeToTopicRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  NotificationUnsubscribeToTopicRequest call({String topic, String token});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfNotificationUnsubscribeToTopicRequest.copyWith(...)` or call `instanceOfNotificationUnsubscribeToTopicRequest.copyWith.fieldName(value)` for a single field.
class _$NotificationUnsubscribeToTopicRequestCWProxyImpl
    implements _$NotificationUnsubscribeToTopicRequestCWProxy {
  const _$NotificationUnsubscribeToTopicRequestCWProxyImpl(this._value);

  final NotificationUnsubscribeToTopicRequest _value;

  @override
  NotificationUnsubscribeToTopicRequest topic(String topic) =>
      call(topic: topic);

  @override
  NotificationUnsubscribeToTopicRequest token(String token) =>
      call(token: token);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `NotificationUnsubscribeToTopicRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// NotificationUnsubscribeToTopicRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  NotificationUnsubscribeToTopicRequest call({
    Object? topic = const $CopyWithPlaceholder(),
    Object? token = const $CopyWithPlaceholder(),
  }) {
    return NotificationUnsubscribeToTopicRequest(
      topic: topic == const $CopyWithPlaceholder() || topic == null
          ? _value.topic
          // ignore: cast_nullable_to_non_nullable
          : topic as String,
      token: token == const $CopyWithPlaceholder() || token == null
          ? _value.token
          // ignore: cast_nullable_to_non_nullable
          : token as String,
    );
  }
}

extension $NotificationUnsubscribeToTopicRequestCopyWith
    on NotificationUnsubscribeToTopicRequest {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfNotificationUnsubscribeToTopicRequest.copyWith(...)` or `instanceOfNotificationUnsubscribeToTopicRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$NotificationUnsubscribeToTopicRequestCWProxy get copyWith =>
      _$NotificationUnsubscribeToTopicRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationUnsubscribeToTopicRequest
_$NotificationUnsubscribeToTopicRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate('NotificationUnsubscribeToTopicRequest', json, (
      $checkedConvert,
    ) {
      $checkKeys(json, requiredKeys: const ['topic', 'token']);
      final val = NotificationUnsubscribeToTopicRequest(
        topic: $checkedConvert('topic', (v) => v as String),
        token: $checkedConvert('token', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$NotificationUnsubscribeToTopicRequestToJson(
  NotificationUnsubscribeToTopicRequest instance,
) => <String, dynamic>{'topic': instance.topic, 'token': instance.token};
