// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_password.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UpdateUserPasswordCWProxy {
  UpdateUserPassword newPassword(String newPassword);

  UpdateUserPassword confirmNewPassword(String confirmNewPassword);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UpdateUserPassword(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UpdateUserPassword(...).copyWith(id: 12, name: "My name")
  /// ```
  UpdateUserPassword call({String newPassword, String confirmNewPassword});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfUpdateUserPassword.copyWith(...)` or call `instanceOfUpdateUserPassword.copyWith.fieldName(value)` for a single field.
class _$UpdateUserPasswordCWProxyImpl implements _$UpdateUserPasswordCWProxy {
  const _$UpdateUserPasswordCWProxyImpl(this._value);

  final UpdateUserPassword _value;

  @override
  UpdateUserPassword newPassword(String newPassword) =>
      call(newPassword: newPassword);

  @override
  UpdateUserPassword confirmNewPassword(String confirmNewPassword) =>
      call(confirmNewPassword: confirmNewPassword);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UpdateUserPassword(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UpdateUserPassword(...).copyWith(id: 12, name: "My name")
  /// ```
  UpdateUserPassword call({
    Object? newPassword = const $CopyWithPlaceholder(),
    Object? confirmNewPassword = const $CopyWithPlaceholder(),
  }) {
    return UpdateUserPassword(
      newPassword:
          newPassword == const $CopyWithPlaceholder() || newPassword == null
          ? _value.newPassword
          // ignore: cast_nullable_to_non_nullable
          : newPassword as String,
      confirmNewPassword:
          confirmNewPassword == const $CopyWithPlaceholder() ||
              confirmNewPassword == null
          ? _value.confirmNewPassword
          // ignore: cast_nullable_to_non_nullable
          : confirmNewPassword as String,
    );
  }
}

extension $UpdateUserPasswordCopyWith on UpdateUserPassword {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfUpdateUserPassword.copyWith(...)` or `instanceOfUpdateUserPassword.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UpdateUserPasswordCWProxy get copyWith =>
      _$UpdateUserPasswordCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateUserPassword _$UpdateUserPasswordFromJson(Map<String, dynamic> json) =>
    $checkedCreate('UpdateUserPassword', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const ['newPassword', 'confirmNewPassword'],
      );
      final val = UpdateUserPassword(
        newPassword: $checkedConvert('newPassword', (v) => v as String),
        confirmNewPassword: $checkedConvert(
          'confirmNewPassword',
          (v) => v as String,
        ),
      );
      return val;
    });

Map<String, dynamic> _$UpdateUserPasswordToJson(UpdateUserPassword instance) =>
    <String, dynamic>{
      'newPassword': instance.newPassword,
      'confirmNewPassword': instance.confirmNewPassword,
    };
