// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_password.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UpdateUserPasswordCWProxy {
  UpdateUserPassword password(String password);

  UpdateUserPassword confirmPassword(String confirmPassword);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpdateUserPassword(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpdateUserPassword(...).copyWith(id: 12, name: "My name")
  /// ````
  UpdateUserPassword call({String password, String confirmPassword});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUpdateUserPassword.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUpdateUserPassword.copyWith.fieldName(...)`
class _$UpdateUserPasswordCWProxyImpl implements _$UpdateUserPasswordCWProxy {
  const _$UpdateUserPasswordCWProxyImpl(this._value);

  final UpdateUserPassword _value;

  @override
  UpdateUserPassword password(String password) => this(password: password);

  @override
  UpdateUserPassword confirmPassword(String confirmPassword) =>
      this(confirmPassword: confirmPassword);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpdateUserPassword(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpdateUserPassword(...).copyWith(id: 12, name: "My name")
  /// ````
  UpdateUserPassword call({
    Object? password = const $CopyWithPlaceholder(),
    Object? confirmPassword = const $CopyWithPlaceholder(),
  }) {
    return UpdateUserPassword(
      password: password == const $CopyWithPlaceholder()
          ? _value.password
          // ignore: cast_nullable_to_non_nullable
          : password as String,
      confirmPassword: confirmPassword == const $CopyWithPlaceholder()
          ? _value.confirmPassword
          // ignore: cast_nullable_to_non_nullable
          : confirmPassword as String,
    );
  }
}

extension $UpdateUserPasswordCopyWith on UpdateUserPassword {
  /// Returns a callable class that can be used as follows: `instanceOfUpdateUserPassword.copyWith(...)` or like so:`instanceOfUpdateUserPassword.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UpdateUserPasswordCWProxy get copyWith =>
      _$UpdateUserPasswordCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateUserPassword _$UpdateUserPasswordFromJson(Map<String, dynamic> json) =>
    $checkedCreate('UpdateUserPassword', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['password', 'confirmPassword']);
      final val = UpdateUserPassword(
        password: $checkedConvert('password', (v) => v as String),
        confirmPassword: $checkedConvert('confirmPassword', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$UpdateUserPasswordToJson(UpdateUserPassword instance) =>
    <String, dynamic>{
      'password': instance.password,
      'confirmPassword': instance.confirmPassword,
    };
