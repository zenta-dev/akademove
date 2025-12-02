// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ResetPasswordCWProxy {
  ResetPassword token(String token);

  ResetPassword newPassword(String newPassword);

  ResetPassword confirmPassword(String confirmPassword);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `ResetPassword(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ResetPassword(...).copyWith(id: 12, name: "My name")
  /// ```
  ResetPassword call({
    String token,
    String newPassword,
    String confirmPassword,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfResetPassword.copyWith(...)` or call `instanceOfResetPassword.copyWith.fieldName(value)` for a single field.
class _$ResetPasswordCWProxyImpl implements _$ResetPasswordCWProxy {
  const _$ResetPasswordCWProxyImpl(this._value);

  final ResetPassword _value;

  @override
  ResetPassword token(String token) => call(token: token);

  @override
  ResetPassword newPassword(String newPassword) =>
      call(newPassword: newPassword);

  @override
  ResetPassword confirmPassword(String confirmPassword) =>
      call(confirmPassword: confirmPassword);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `ResetPassword(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ResetPassword(...).copyWith(id: 12, name: "My name")
  /// ```
  ResetPassword call({
    Object? token = const $CopyWithPlaceholder(),
    Object? newPassword = const $CopyWithPlaceholder(),
    Object? confirmPassword = const $CopyWithPlaceholder(),
  }) {
    return ResetPassword(
      token: token == const $CopyWithPlaceholder() || token == null
          ? _value.token
          // ignore: cast_nullable_to_non_nullable
          : token as String,
      newPassword:
          newPassword == const $CopyWithPlaceholder() || newPassword == null
          ? _value.newPassword
          // ignore: cast_nullable_to_non_nullable
          : newPassword as String,
      confirmPassword:
          confirmPassword == const $CopyWithPlaceholder() ||
              confirmPassword == null
          ? _value.confirmPassword
          // ignore: cast_nullable_to_non_nullable
          : confirmPassword as String,
    );
  }
}

extension $ResetPasswordCopyWith on ResetPassword {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfResetPassword.copyWith(...)` or `instanceOfResetPassword.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ResetPasswordCWProxy get copyWith => _$ResetPasswordCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResetPassword _$ResetPasswordFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ResetPassword', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const ['token', 'newPassword', 'confirmPassword'],
      );
      final val = ResetPassword(
        token: $checkedConvert('token', (v) => v as String),
        newPassword: $checkedConvert('newPassword', (v) => v as String),
        confirmPassword: $checkedConvert('confirmPassword', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$ResetPasswordToJson(ResetPassword instance) =>
    <String, dynamic>{
      'token': instance.token,
      'newPassword': instance.newPassword,
      'confirmPassword': instance.confirmPassword,
    };
