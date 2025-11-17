// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_sign_in_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AuthSignInRequestCWProxy {
  AuthSignInRequest email(String email);

  AuthSignInRequest password(String password);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AuthSignInRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AuthSignInRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  AuthSignInRequest call({String email, String password});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAuthSignInRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAuthSignInRequest.copyWith.fieldName(...)`
class _$AuthSignInRequestCWProxyImpl implements _$AuthSignInRequestCWProxy {
  const _$AuthSignInRequestCWProxyImpl(this._value);

  final AuthSignInRequest _value;

  @override
  AuthSignInRequest email(String email) => this(email: email);

  @override
  AuthSignInRequest password(String password) => this(password: password);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AuthSignInRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AuthSignInRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  AuthSignInRequest call({
    Object? email = const $CopyWithPlaceholder(),
    Object? password = const $CopyWithPlaceholder(),
  }) {
    return AuthSignInRequest(
      email: email == const $CopyWithPlaceholder()
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String,
      password: password == const $CopyWithPlaceholder()
          ? _value.password
          // ignore: cast_nullable_to_non_nullable
          : password as String,
    );
  }
}

extension $AuthSignInRequestCopyWith on AuthSignInRequest {
  /// Returns a callable class that can be used as follows: `instanceOfAuthSignInRequest.copyWith(...)` or like so:`instanceOfAuthSignInRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AuthSignInRequestCWProxy get copyWith =>
      _$AuthSignInRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthSignInRequest _$AuthSignInRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate('AuthSignInRequest', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['email', 'password']);
      final val = AuthSignInRequest(
        email: $checkedConvert('email', (v) => v as String),
        password: $checkedConvert('password', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$AuthSignInRequestToJson(AuthSignInRequest instance) =>
    <String, dynamic>{'email': instance.email, 'password': instance.password};
