// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SignInRequestCWProxy {
  SignInRequest email(String email);

  SignInRequest password(String password);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SignInRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SignInRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  SignInRequest call({String email, String password});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfSignInRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfSignInRequest.copyWith.fieldName(...)`
class _$SignInRequestCWProxyImpl implements _$SignInRequestCWProxy {
  const _$SignInRequestCWProxyImpl(this._value);

  final SignInRequest _value;

  @override
  SignInRequest email(String email) => this(email: email);

  @override
  SignInRequest password(String password) => this(password: password);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SignInRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SignInRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  SignInRequest call({
    Object? email = const $CopyWithPlaceholder(),
    Object? password = const $CopyWithPlaceholder(),
  }) {
    return SignInRequest(
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

extension $SignInRequestCopyWith on SignInRequest {
  /// Returns a callable class that can be used as follows: `instanceOfSignInRequest.copyWith(...)` or like so:`instanceOfSignInRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SignInRequestCWProxy get copyWith => _$SignInRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignInRequest _$SignInRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate('SignInRequest', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['email', 'password']);
      final val = SignInRequest(
        email: $checkedConvert('email', (v) => v as String),
        password: $checkedConvert('password', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$SignInRequestToJson(SignInRequest instance) =>
    <String, dynamic>{'email': instance.email, 'password': instance.password};
