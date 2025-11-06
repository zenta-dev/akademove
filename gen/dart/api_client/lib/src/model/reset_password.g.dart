// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ResetPasswordCWProxy {
  ResetPassword token(String token);

  ResetPassword newPassword(String newPassword);

  ResetPassword confirmPassword(String confirmPassword);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ResetPassword(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ResetPassword(...).copyWith(id: 12, name: "My name")
  /// ````
  ResetPassword call({
    String token,
    String newPassword,
    String confirmPassword,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfResetPassword.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfResetPassword.copyWith.fieldName(...)`
class _$ResetPasswordCWProxyImpl implements _$ResetPasswordCWProxy {
  const _$ResetPasswordCWProxyImpl(this._value);

  final ResetPassword _value;

  @override
  ResetPassword token(String token) => this(token: token);

  @override
  ResetPassword newPassword(String newPassword) =>
      this(newPassword: newPassword);

  @override
  ResetPassword confirmPassword(String confirmPassword) =>
      this(confirmPassword: confirmPassword);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ResetPassword(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ResetPassword(...).copyWith(id: 12, name: "My name")
  /// ````
  ResetPassword call({
    Object? token = const $CopyWithPlaceholder(),
    Object? newPassword = const $CopyWithPlaceholder(),
    Object? confirmPassword = const $CopyWithPlaceholder(),
  }) {
    return ResetPassword(
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

extension $ResetPasswordCopyWith on ResetPassword {
  /// Returns a callable class that can be used as follows: `instanceOfResetPassword.copyWith(...)` or like so:`instanceOfResetPassword.copyWith.fieldName(...)`.
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
