// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_update_user.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AdminUpdateUserCWProxy {
  AdminUpdateUser role(UserRole role);

  AdminUpdateUser newPassword(String newPassword);

  AdminUpdateUser confirmNewPassword(String confirmNewPassword);

  AdminUpdateUser banReason(String banReason);

  AdminUpdateUser banExpiresIn(num? banExpiresIn);

  AdminUpdateUser id(String id);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `AdminUpdateUser(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AdminUpdateUser(...).copyWith(id: 12, name: "My name")
  /// ```
  AdminUpdateUser call({
    UserRole role,
    String newPassword,
    String confirmNewPassword,
    String banReason,
    num? banExpiresIn,
    String id,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfAdminUpdateUser.copyWith(...)` or call `instanceOfAdminUpdateUser.copyWith.fieldName(value)` for a single field.
class _$AdminUpdateUserCWProxyImpl implements _$AdminUpdateUserCWProxy {
  const _$AdminUpdateUserCWProxyImpl(this._value);

  final AdminUpdateUser _value;

  @override
  AdminUpdateUser role(UserRole role) => call(role: role);

  @override
  AdminUpdateUser newPassword(String newPassword) =>
      call(newPassword: newPassword);

  @override
  AdminUpdateUser confirmNewPassword(String confirmNewPassword) =>
      call(confirmNewPassword: confirmNewPassword);

  @override
  AdminUpdateUser banReason(String banReason) => call(banReason: banReason);

  @override
  AdminUpdateUser banExpiresIn(num? banExpiresIn) =>
      call(banExpiresIn: banExpiresIn);

  @override
  AdminUpdateUser id(String id) => call(id: id);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `AdminUpdateUser(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AdminUpdateUser(...).copyWith(id: 12, name: "My name")
  /// ```
  AdminUpdateUser call({
    Object? role = const $CopyWithPlaceholder(),
    Object? newPassword = const $CopyWithPlaceholder(),
    Object? confirmNewPassword = const $CopyWithPlaceholder(),
    Object? banReason = const $CopyWithPlaceholder(),
    Object? banExpiresIn = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
  }) {
    return AdminUpdateUser(
      role: role == const $CopyWithPlaceholder() || role == null
          ? _value.role
          // ignore: cast_nullable_to_non_nullable
          : role as UserRole,
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
      banReason: banReason == const $CopyWithPlaceholder() || banReason == null
          ? _value.banReason
          // ignore: cast_nullable_to_non_nullable
          : banReason as String,
      banExpiresIn: banExpiresIn == const $CopyWithPlaceholder()
          ? _value.banExpiresIn
          // ignore: cast_nullable_to_non_nullable
          : banExpiresIn as num?,
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
    );
  }
}

extension $AdminUpdateUserCopyWith on AdminUpdateUser {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfAdminUpdateUser.copyWith(...)` or `instanceOfAdminUpdateUser.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AdminUpdateUserCWProxy get copyWith => _$AdminUpdateUserCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminUpdateUser _$AdminUpdateUserFromJson(Map<String, dynamic> json) =>
    $checkedCreate('AdminUpdateUser', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'role',
          'newPassword',
          'confirmNewPassword',
          'banReason',
          'id',
        ],
      );
      final val = AdminUpdateUser(
        role: $checkedConvert('role', (v) => $enumDecode(_$UserRoleEnumMap, v)),
        newPassword: $checkedConvert('newPassword', (v) => v as String),
        confirmNewPassword: $checkedConvert(
          'confirmNewPassword',
          (v) => v as String,
        ),
        banReason: $checkedConvert('banReason', (v) => v as String),
        banExpiresIn: $checkedConvert('banExpiresIn', (v) => v as num?),
        id: $checkedConvert('id', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$AdminUpdateUserToJson(AdminUpdateUser instance) =>
    <String, dynamic>{
      'role': _$UserRoleEnumMap[instance.role]!,
      'newPassword': instance.newPassword,
      'confirmNewPassword': instance.confirmNewPassword,
      'banReason': instance.banReason,
      'banExpiresIn': ?instance.banExpiresIn,
      'id': instance.id,
    };

const _$UserRoleEnumMap = {
  UserRole.ADMIN: 'ADMIN',
  UserRole.OPERATOR: 'OPERATOR',
  UserRole.MERCHANT: 'MERCHANT',
  UserRole.DRIVER: 'DRIVER',
  UserRole.USER: 'USER',
};
