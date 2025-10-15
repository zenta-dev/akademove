// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_reset_password_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AuthResetPasswordRequestCWProxy {
  AuthResetPasswordRequest token(String token);

  AuthResetPasswordRequest newPassword(String newPassword);

  AuthResetPasswordRequest confirmPassword(String confirmPassword);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AuthResetPasswordRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AuthResetPasswordRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  AuthResetPasswordRequest call({
    String token,
    String newPassword,
    String confirmPassword,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAuthResetPasswordRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAuthResetPasswordRequest.copyWith.fieldName(...)`
class _$AuthResetPasswordRequestCWProxyImpl
    implements _$AuthResetPasswordRequestCWProxy {
  const _$AuthResetPasswordRequestCWProxyImpl(this._value);

  final AuthResetPasswordRequest _value;

  @override
  AuthResetPasswordRequest token(String token) => this(token: token);

  @override
  AuthResetPasswordRequest newPassword(String newPassword) =>
      this(newPassword: newPassword);

  @override
  AuthResetPasswordRequest confirmPassword(String confirmPassword) =>
      this(confirmPassword: confirmPassword);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AuthResetPasswordRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AuthResetPasswordRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  AuthResetPasswordRequest call({
    Object? token = const $CopyWithPlaceholder(),
    Object? newPassword = const $CopyWithPlaceholder(),
    Object? confirmPassword = const $CopyWithPlaceholder(),
  }) {
    return AuthResetPasswordRequest(
      token: token == const $CopyWithPlaceholder()
          ? _value.token
          // ignore: cast_nullable_to_non_nullable
          : token as String,
      newPassword: newPassword == const $CopyWithPlaceholder()
          ? _value.newPassword
          // ignore: cast_nullable_to_non_nullable
          : newPassword as String,
      confirmPassword: confirmPassword == const $CopyWithPlaceholder()
          ? _value.confirmPassword
          // ignore: cast_nullable_to_non_nullable
          : confirmPassword as String,
    );
  }
}

extension $AuthResetPasswordRequestCopyWith on AuthResetPasswordRequest {
  /// Returns a callable class that can be used as follows: `instanceOfAuthResetPasswordRequest.copyWith(...)` or like so:`instanceOfAuthResetPasswordRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AuthResetPasswordRequestCWProxy get copyWith =>
      _$AuthResetPasswordRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthResetPasswordRequest _$AuthResetPasswordRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('AuthResetPasswordRequest', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const ['token', 'newPassword', 'confirmPassword'],
  );
  final val = AuthResetPasswordRequest(
    token: $checkedConvert('token', (v) => v as String),
    newPassword: $checkedConvert('newPassword', (v) => v as String),
    confirmPassword: $checkedConvert('confirmPassword', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$AuthResetPasswordRequestToJson(
  AuthResetPasswordRequest instance,
) => <String, dynamic>{
  'token': instance.token,
  'newPassword': instance.newPassword,
  'confirmPassword': instance.confirmPassword,
};
