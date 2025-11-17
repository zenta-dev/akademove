// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_password.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UpdateUserPasswordCWProxy {
  UpdateUserPassword oldPassword(String oldPassword);

  UpdateUserPassword newPassword(String newPassword);

  UpdateUserPassword confirmNewPassword(String confirmNewPassword);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpdateUserPassword(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpdateUserPassword(...).copyWith(id: 12, name: "My name")
  /// ````
  UpdateUserPassword call({
    String oldPassword,
    String newPassword,
    String confirmNewPassword,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUpdateUserPassword.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUpdateUserPassword.copyWith.fieldName(...)`
class _$UpdateUserPasswordCWProxyImpl implements _$UpdateUserPasswordCWProxy {
  const _$UpdateUserPasswordCWProxyImpl(this._value);

  final UpdateUserPassword _value;

  @override
  UpdateUserPassword oldPassword(String oldPassword) =>
      this(oldPassword: oldPassword);

  @override
  UpdateUserPassword newPassword(String newPassword) =>
      this(newPassword: newPassword);

  @override
  UpdateUserPassword confirmNewPassword(String confirmNewPassword) =>
      this(confirmNewPassword: confirmNewPassword);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpdateUserPassword(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpdateUserPassword(...).copyWith(id: 12, name: "My name")
  /// ````
  UpdateUserPassword call({
    Object? oldPassword = const $CopyWithPlaceholder(),
    Object? newPassword = const $CopyWithPlaceholder(),
    Object? confirmNewPassword = const $CopyWithPlaceholder(),
  }) {
    return UpdateUserPassword(
      oldPassword: oldPassword == const $CopyWithPlaceholder()
          ? _value.oldPassword
          // ignore: cast_nullable_to_non_nullable
          : oldPassword as String,
      newPassword: newPassword == const $CopyWithPlaceholder()
          ? _value.newPassword
          // ignore: cast_nullable_to_non_nullable
          : newPassword as String,
      confirmNewPassword: confirmNewPassword == const $CopyWithPlaceholder()
          ? _value.confirmNewPassword
          // ignore: cast_nullable_to_non_nullable
          : confirmNewPassword as String,
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
      $checkKeys(
        json,
        requiredKeys: const [
          'oldPassword',
          'newPassword',
          'confirmNewPassword',
        ],
      );
      final val = UpdateUserPassword(
        oldPassword: $checkedConvert('oldPassword', (v) => v as String),
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
      'oldPassword': instance.oldPassword,
      'newPassword': instance.newPassword,
      'confirmNewPassword': instance.confirmNewPassword,
    };
