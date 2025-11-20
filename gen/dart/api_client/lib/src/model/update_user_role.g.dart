// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_role.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UpdateUserRoleCWProxy {
  UpdateUserRole role(UserRole role);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UpdateUserRole(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UpdateUserRole(...).copyWith(id: 12, name: "My name")
  /// ```
  UpdateUserRole call({UserRole role});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfUpdateUserRole.copyWith(...)` or call `instanceOfUpdateUserRole.copyWith.fieldName(value)` for a single field.
class _$UpdateUserRoleCWProxyImpl implements _$UpdateUserRoleCWProxy {
  const _$UpdateUserRoleCWProxyImpl(this._value);

  final UpdateUserRole _value;

  @override
  UpdateUserRole role(UserRole role) => call(role: role);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UpdateUserRole(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UpdateUserRole(...).copyWith(id: 12, name: "My name")
  /// ```
  UpdateUserRole call({Object? role = const $CopyWithPlaceholder()}) {
    return UpdateUserRole(
      role: role == const $CopyWithPlaceholder() || role == null
          ? _value.role
          // ignore: cast_nullable_to_non_nullable
          : role as UserRole,
    );
  }
}

extension $UpdateUserRoleCopyWith on UpdateUserRole {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfUpdateUserRole.copyWith(...)` or `instanceOfUpdateUserRole.copyWith.fieldName(...)`.
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
