// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_forgot_password_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AuthForgotPasswordRequestCWProxy {
  AuthForgotPasswordRequest email(String email);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `AuthForgotPasswordRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AuthForgotPasswordRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  AuthForgotPasswordRequest call({String email});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfAuthForgotPasswordRequest.copyWith(...)` or call `instanceOfAuthForgotPasswordRequest.copyWith.fieldName(value)` for a single field.
class _$AuthForgotPasswordRequestCWProxyImpl
    implements _$AuthForgotPasswordRequestCWProxy {
  const _$AuthForgotPasswordRequestCWProxyImpl(this._value);

  final AuthForgotPasswordRequest _value;

  @override
  AuthForgotPasswordRequest email(String email) => call(email: email);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `AuthForgotPasswordRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AuthForgotPasswordRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  AuthForgotPasswordRequest call({
    Object? email = const $CopyWithPlaceholder(),
  }) {
    return AuthForgotPasswordRequest(
      email: email == const $CopyWithPlaceholder() || email == null
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String,
    );
  }
}

extension $AuthForgotPasswordRequestCopyWith on AuthForgotPasswordRequest {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfAuthForgotPasswordRequest.copyWith(...)` or `instanceOfAuthForgotPasswordRequest.copyWith.fieldName(...)`.
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
