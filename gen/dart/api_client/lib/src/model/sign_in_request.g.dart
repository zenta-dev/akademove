// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SignInRequestCWProxy {
  SignInRequest email(String email);

  SignInRequest password(String password);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `SignInRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SignInRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  SignInRequest call({String email, String password});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfSignInRequest.copyWith(...)` or call `instanceOfSignInRequest.copyWith.fieldName(value)` for a single field.
class _$SignInRequestCWProxyImpl implements _$SignInRequestCWProxy {
  const _$SignInRequestCWProxyImpl(this._value);

  final SignInRequest _value;

  @override
  SignInRequest email(String email) => call(email: email);

  @override
  SignInRequest password(String password) => call(password: password);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `SignInRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SignInRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  SignInRequest call({
    Object? email = const $CopyWithPlaceholder(),
    Object? password = const $CopyWithPlaceholder(),
  }) {
    return SignInRequest(
      email: email == const $CopyWithPlaceholder() || email == null
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String,
      password: password == const $CopyWithPlaceholder() || password == null
          ? _value.password
          // ignore: cast_nullable_to_non_nullable
          : password as String,
    );
  }
}

extension $SignInRequestCopyWith on SignInRequest {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfSignInRequest.copyWith(...)` or `instanceOfSignInRequest.copyWith.fieldName(...)`.
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
