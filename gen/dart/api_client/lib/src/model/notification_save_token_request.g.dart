// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_save_token_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$NotificationSaveTokenRequestCWProxy {
  NotificationSaveTokenRequest token(String token);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `NotificationSaveTokenRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// NotificationSaveTokenRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  NotificationSaveTokenRequest call({String token});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfNotificationSaveTokenRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfNotificationSaveTokenRequest.copyWith.fieldName(...)`
class _$NotificationSaveTokenRequestCWProxyImpl
    implements _$NotificationSaveTokenRequestCWProxy {
  const _$NotificationSaveTokenRequestCWProxyImpl(this._value);

  final NotificationSaveTokenRequest _value;

  @override
  NotificationSaveTokenRequest token(String token) => this(token: token);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `NotificationSaveTokenRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// NotificationSaveTokenRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  NotificationSaveTokenRequest call({
    Object? token = const $CopyWithPlaceholder(),
  }) {
    return NotificationSaveTokenRequest(
      token: token == const $CopyWithPlaceholder()
          ? _value.token
          // ignore: cast_nullable_to_non_nullable
          : token as String,
    );
  }
}

extension $NotificationSaveTokenRequestCopyWith
    on NotificationSaveTokenRequest {
  /// Returns a callable class that can be used as follows: `instanceOfNotificationSaveTokenRequest.copyWith(...)` or like so:`instanceOfNotificationSaveTokenRequest.copyWith.fieldName(...)`.
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
