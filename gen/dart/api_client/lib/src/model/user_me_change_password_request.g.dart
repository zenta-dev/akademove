// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_me_change_password_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UserMeChangePasswordRequestCWProxy {
  UserMeChangePasswordRequest oldPassword(String oldPassword);

  UserMeChangePasswordRequest newPassword(String newPassword);

  UserMeChangePasswordRequest confirmNewPassword(String confirmNewPassword);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UserMeChangePasswordRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UserMeChangePasswordRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  UserMeChangePasswordRequest call({
    String oldPassword,
    String newPassword,
    String confirmNewPassword,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfUserMeChangePasswordRequest.copyWith(...)` or call `instanceOfUserMeChangePasswordRequest.copyWith.fieldName(value)` for a single field.
class _$UserMeChangePasswordRequestCWProxyImpl
    implements _$UserMeChangePasswordRequestCWProxy {
  const _$UserMeChangePasswordRequestCWProxyImpl(this._value);

  final UserMeChangePasswordRequest _value;

  @override
  UserMeChangePasswordRequest oldPassword(String oldPassword) =>
      call(oldPassword: oldPassword);

  @override
  UserMeChangePasswordRequest newPassword(String newPassword) =>
      call(newPassword: newPassword);

  @override
  UserMeChangePasswordRequest confirmNewPassword(String confirmNewPassword) =>
      call(confirmNewPassword: confirmNewPassword);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UserMeChangePasswordRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UserMeChangePasswordRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  UserMeChangePasswordRequest call({
    Object? oldPassword = const $CopyWithPlaceholder(),
    Object? newPassword = const $CopyWithPlaceholder(),
    Object? confirmNewPassword = const $CopyWithPlaceholder(),
  }) {
    return UserMeChangePasswordRequest(
      oldPassword:
          oldPassword == const $CopyWithPlaceholder() || oldPassword == null
          ? _value.oldPassword
          // ignore: cast_nullable_to_non_nullable
          : oldPassword as String,
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

extension $UserMeChangePasswordRequestCopyWith on UserMeChangePasswordRequest {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfUserMeChangePasswordRequest.copyWith(...)` or `instanceOfUserMeChangePasswordRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UserMeChangePasswordRequestCWProxy get copyWith =>
      _$UserMeChangePasswordRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserMeChangePasswordRequest _$UserMeChangePasswordRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('UserMeChangePasswordRequest', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const ['oldPassword', 'newPassword', 'confirmNewPassword'],
  );
  final val = UserMeChangePasswordRequest(
    oldPassword: $checkedConvert('oldPassword', (v) => v as String),
    newPassword: $checkedConvert('newPassword', (v) => v as String),
    confirmNewPassword: $checkedConvert(
      'confirmNewPassword',
      (v) => v as String,
    ),
  );
  return val;
});

Map<String, dynamic> _$UserMeChangePasswordRequestToJson(
  UserMeChangePasswordRequest instance,
) => <String, dynamic>{
  'oldPassword': instance.oldPassword,
  'newPassword': instance.newPassword,
  'confirmNewPassword': instance.confirmNewPassword,
};
