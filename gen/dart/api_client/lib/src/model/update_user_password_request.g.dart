// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_password_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UpdateUserPasswordRequestCWProxy {
  UpdateUserPasswordRequest password(String password);

  UpdateUserPasswordRequest confirmPassword(String confirmPassword);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpdateUserPasswordRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpdateUserPasswordRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  UpdateUserPasswordRequest call({String password, String confirmPassword});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUpdateUserPasswordRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUpdateUserPasswordRequest.copyWith.fieldName(...)`
class _$UpdateUserPasswordRequestCWProxyImpl
    implements _$UpdateUserPasswordRequestCWProxy {
  const _$UpdateUserPasswordRequestCWProxyImpl(this._value);

  final UpdateUserPasswordRequest _value;

  @override
  UpdateUserPasswordRequest password(String password) =>
      this(password: password);

  @override
  UpdateUserPasswordRequest confirmPassword(String confirmPassword) =>
      this(confirmPassword: confirmPassword);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpdateUserPasswordRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpdateUserPasswordRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  UpdateUserPasswordRequest call({
    Object? password = const $CopyWithPlaceholder(),
    Object? confirmPassword = const $CopyWithPlaceholder(),
  }) {
    return UpdateUserPasswordRequest(
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

extension $UpdateUserPasswordRequestCopyWith on UpdateUserPasswordRequest {
  /// Returns a callable class that can be used as follows: `instanceOfUpdateUserPasswordRequest.copyWith(...)` or like so:`instanceOfUpdateUserPasswordRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UpdateUserPasswordRequestCWProxy get copyWith =>
      _$UpdateUserPasswordRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateUserPasswordRequest _$UpdateUserPasswordRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('UpdateUserPasswordRequest', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['password', 'confirmPassword']);
  final val = UpdateUserPasswordRequest(
    password: $checkedConvert('password', (v) => v as String),
    confirmPassword: $checkedConvert('confirmPassword', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$UpdateUserPasswordRequestToJson(
  UpdateUserPasswordRequest instance,
) => <String, dynamic>{
  'password': instance.password,
  'confirmPassword': instance.confirmPassword,
};
