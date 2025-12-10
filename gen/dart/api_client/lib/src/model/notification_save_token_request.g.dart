// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_save_token_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$NotificationSaveTokenRequestCWProxy {
  NotificationSaveTokenRequest token(String token);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `NotificationSaveTokenRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// NotificationSaveTokenRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  NotificationSaveTokenRequest call({String token});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfNotificationSaveTokenRequest.copyWith(...)` or call `instanceOfNotificationSaveTokenRequest.copyWith.fieldName(value)` for a single field.
class _$NotificationSaveTokenRequestCWProxyImpl
    implements _$NotificationSaveTokenRequestCWProxy {
  const _$NotificationSaveTokenRequestCWProxyImpl(this._value);

  final NotificationSaveTokenRequest _value;

  @override
  NotificationSaveTokenRequest token(String token) => call(token: token);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `NotificationSaveTokenRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// NotificationSaveTokenRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  NotificationSaveTokenRequest call({
    Object? token = const $CopyWithPlaceholder(),
  }) {
    return NotificationSaveTokenRequest(
      token: token == const $CopyWithPlaceholder() || token == null
          ? _value.token
          // ignore: cast_nullable_to_non_nullable
          : token as String,
    );
  }
}

extension $NotificationSaveTokenRequestCopyWith
    on NotificationSaveTokenRequest {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfNotificationSaveTokenRequest.copyWith(...)` or `instanceOfNotificationSaveTokenRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$NotificationSaveTokenRequestCWProxy get copyWith =>
      _$NotificationSaveTokenRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationSaveTokenRequest _$NotificationSaveTokenRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('NotificationSaveTokenRequest', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['token']);
  final val = NotificationSaveTokenRequest(
    token: $checkedConvert('token', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$NotificationSaveTokenRequestToJson(
  NotificationSaveTokenRequest instance,
) => <String, dynamic>{'token': instance.token};
