// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_role.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UpdateUserRoleCWProxy {
  UpdateUserRole role(UserRole role);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpdateUserRole(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpdateUserRole(...).copyWith(id: 12, name: "My name")
  /// ````
  UpdateUserRole call({UserRole role});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUpdateUserRole.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUpdateUserRole.copyWith.fieldName(...)`
class _$UpdateUserRoleCWProxyImpl implements _$UpdateUserRoleCWProxy {
  const _$UpdateUserRoleCWProxyImpl(this._value);

  final UpdateUserRole _value;

  @override
  UpdateUserRole role(UserRole role) => this(role: role);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpdateUserRole(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpdateUserRole(...).copyWith(id: 12, name: "My name")
  /// ````
  UpdateUserRole call({Object? role = const $CopyWithPlaceholder()}) {
    return UpdateUserRole(
      role: role == const $CopyWithPlaceholder()
          ? _value.role
          // ignore: cast_nullable_to_non_nullable
          : role as UserRole,
    );
  }
}

extension $UpdateUserRoleCopyWith on UpdateUserRole {
  /// Returns a callable class that can be used as follows: `instanceOfUpdateUserRole.copyWith(...)` or like so:`instanceOfUpdateUserRole.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UpdateUserRoleCWProxy get copyWith => _$UpdateUserRoleCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateUserRole _$UpdateUserRoleFromJson(Map<String, dynamic> json) =>
    $checkedCreate('UpdateUserRole', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['role']);
      final val = UpdateUserRole(
        role: $checkedConvert('role', (v) => $enumDecode(_$UserRoleEnumMap, v)),
      );
      return val;
    });

Map<String, dynamic> _$UpdateUserRoleToJson(UpdateUserRole instance) =>
    <String, dynamic>{'role': _$UserRoleEnumMap[instance.role]!};

const _$UserRoleEnumMap = {
  UserRole.admin: 'admin',
  UserRole.operator_: 'operator',
  UserRole.merchant: 'merchant',
  UserRole.driver: 'driver',
  UserRole.user: 'user',
};
