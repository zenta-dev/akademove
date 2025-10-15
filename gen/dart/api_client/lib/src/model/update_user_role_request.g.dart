// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_role_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UpdateUserRoleRequestCWProxy {
  UpdateUserRoleRequest role(UpdateUserRoleRequestRoleEnum role);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpdateUserRoleRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpdateUserRoleRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  UpdateUserRoleRequest call({UpdateUserRoleRequestRoleEnum role});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUpdateUserRoleRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUpdateUserRoleRequest.copyWith.fieldName(...)`
class _$UpdateUserRoleRequestCWProxyImpl
    implements _$UpdateUserRoleRequestCWProxy {
  const _$UpdateUserRoleRequestCWProxyImpl(this._value);

  final UpdateUserRoleRequest _value;

  @override
  UpdateUserRoleRequest role(UpdateUserRoleRequestRoleEnum role) =>
      this(role: role);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpdateUserRoleRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpdateUserRoleRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  UpdateUserRoleRequest call({Object? role = const $CopyWithPlaceholder()}) {
    return UpdateUserRoleRequest(
      role: role == const $CopyWithPlaceholder()
          ? _value.role
          // ignore: cast_nullable_to_non_nullable
          : role as UpdateUserRoleRequestRoleEnum,
    );
  }
}

extension $UpdateUserRoleRequestCopyWith on UpdateUserRoleRequest {
  /// Returns a callable class that can be used as follows: `instanceOfUpdateUserRoleRequest.copyWith(...)` or like so:`instanceOfUpdateUserRoleRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UpdateUserRoleRequestCWProxy get copyWith =>
      _$UpdateUserRoleRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateUserRoleRequest _$UpdateUserRoleRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('UpdateUserRoleRequest', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['role']);
  final val = UpdateUserRoleRequest(
    role: $checkedConvert(
      'role',
      (v) => $enumDecode(_$UpdateUserRoleRequestRoleEnumEnumMap, v),
    ),
  );
  return val;
});

Map<String, dynamic> _$UpdateUserRoleRequestToJson(
  UpdateUserRoleRequest instance,
) => <String, dynamic>{
  'role': _$UpdateUserRoleRequestRoleEnumEnumMap[instance.role]!,
};

const _$UpdateUserRoleRequestRoleEnumEnumMap = {
  UpdateUserRoleRequestRoleEnum.admin: 'admin',
  UpdateUserRoleRequestRoleEnum.operator_: 'operator',
  UpdateUserRoleRequestRoleEnum.merchant: 'merchant',
  UpdateUserRoleRequestRoleEnum.driver: 'driver',
  UpdateUserRoleRequestRoleEnum.user: 'user',
};
