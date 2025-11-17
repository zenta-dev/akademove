// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_forgot_password_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AuthForgotPasswordRequestCWProxy {
  AuthForgotPasswordRequest email(String email);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AuthForgotPasswordRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AuthForgotPasswordRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  AuthForgotPasswordRequest call({String email});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAuthForgotPasswordRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAuthForgotPasswordRequest.copyWith.fieldName(...)`
class _$AuthForgotPasswordRequestCWProxyImpl
    implements _$AuthForgotPasswordRequestCWProxy {
  const _$AuthForgotPasswordRequestCWProxyImpl(this._value);

  final AuthForgotPasswordRequest _value;

  @override
  AuthForgotPasswordRequest email(String email) => this(email: email);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AuthForgotPasswordRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AuthForgotPasswordRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  AuthForgotPasswordRequest call({
    Object? email = const $CopyWithPlaceholder(),
  }) {
    return AuthForgotPasswordRequest(
      email: email == const $CopyWithPlaceholder()
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String,
    );
  }
}

extension $AuthForgotPasswordRequestCopyWith on AuthForgotPasswordRequest {
  /// Returns a callable class that can be used as follows: `instanceOfAuthForgotPasswordRequest.copyWith(...)` or like so:`instanceOfAuthForgotPasswordRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AuthForgotPasswordRequestCWProxy get copyWith =>
      _$AuthForgotPasswordRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthForgotPasswordRequest _$AuthForgotPasswordRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('AuthForgotPasswordRequest', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['email']);
  final val = AuthForgotPasswordRequest(
    email: $checkedConvert('email', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$AuthForgotPasswordRequestToJson(
  AuthForgotPasswordRequest instance,
) => <String, dynamic>{'email': instance.email};
