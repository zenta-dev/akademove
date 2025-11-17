// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_update_user.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AdminUpdateUserCWProxy {
  AdminUpdateUser role(UserRole role);

  AdminUpdateUser password(String password);

  AdminUpdateUser confirmPassword(String confirmPassword);

  AdminUpdateUser banReason(String banReason);

  AdminUpdateUser banExpiresIn(num? banExpiresIn);

  AdminUpdateUser id(String id);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AdminUpdateUser(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AdminUpdateUser(...).copyWith(id: 12, name: "My name")
  /// ````
  AdminUpdateUser call({
    UserRole role,
    String password,
    String confirmPassword,
    String banReason,
    num? banExpiresIn,
    String id,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAdminUpdateUser.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAdminUpdateUser.copyWith.fieldName(...)`
class _$AdminUpdateUserCWProxyImpl implements _$AdminUpdateUserCWProxy {
  const _$AdminUpdateUserCWProxyImpl(this._value);

  final AdminUpdateUser _value;

  @override
  AdminUpdateUser role(UserRole role) => this(role: role);

  @override
  AdminUpdateUser password(String password) => this(password: password);

  @override
  AdminUpdateUser confirmPassword(String confirmPassword) =>
      this(confirmPassword: confirmPassword);

  @override
  AdminUpdateUser banReason(String banReason) => this(banReason: banReason);

  @override
  AdminUpdateUser banExpiresIn(num? banExpiresIn) =>
      this(banExpiresIn: banExpiresIn);

  @override
  AdminUpdateUser id(String id) => this(id: id);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AdminUpdateUser(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AdminUpdateUser(...).copyWith(id: 12, name: "My name")
  /// ````
  AdminUpdateUser call({
    Object? role = const $CopyWithPlaceholder(),
    Object? password = const $CopyWithPlaceholder(),
    Object? confirmPassword = const $CopyWithPlaceholder(),
    Object? banReason = const $CopyWithPlaceholder(),
    Object? banExpiresIn = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
  }) {
    return AdminUpdateUser(
      role: role == const $CopyWithPlaceholder()
          ? _value.role
          // ignore: cast_nullable_to_non_nullable
          : role as UserRole,
      password: password == const $CopyWithPlaceholder()
          ? _value.password
          // ignore: cast_nullable_to_non_nullable
          : password as String,
      confirmPassword: confirmPassword == const $CopyWithPlaceholder()
          ? _value.confirmPassword
          // ignore: cast_nullable_to_non_nullable
          : confirmPassword as String,
      banReason: banReason == const $CopyWithPlaceholder()
          ? _value.banReason
          // ignore: cast_nullable_to_non_nullable
          : banReason as String,
      banExpiresIn: banExpiresIn == const $CopyWithPlaceholder()
          ? _value.banExpiresIn
          // ignore: cast_nullable_to_non_nullable
          : banExpiresIn as num?,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
    );
  }
}

extension $AdminUpdateUserCopyWith on AdminUpdateUser {
  /// Returns a callable class that can be used as follows: `instanceOfAdminUpdateUser.copyWith(...)` or like so:`instanceOfAdminUpdateUser.copyWith.fieldName(...)`.
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
          'password',
          'confirmPassword',
          'banReason',
          'id',
        ],
      );
      final val = AdminUpdateUser(
        role: $checkedConvert('role', (v) => $enumDecode(_$UserRoleEnumMap, v)),
        password: $checkedConvert('password', (v) => v as String),
        confirmPassword: $checkedConvert('confirmPassword', (v) => v as String),
        banReason: $checkedConvert('banReason', (v) => v as String),
        banExpiresIn: $checkedConvert('banExpiresIn', (v) => v as num?),
        id: $checkedConvert('id', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$AdminUpdateUserToJson(AdminUpdateUser instance) =>
    <String, dynamic>{
      'role': _$UserRoleEnumMap[instance.role]!,
      'password': instance.password,
      'confirmPassword': instance.confirmPassword,
      'banReason': instance.banReason,
      'banExpiresIn': ?instance.banExpiresIn,
      'id': instance.id,
    };

const _$UserRoleEnumMap = {
  UserRole.admin: 'admin',
  UserRole.operator_: 'operator',
  UserRole.merchant: 'merchant',
  UserRole.driver: 'driver',
  UserRole.user: 'user',
};
