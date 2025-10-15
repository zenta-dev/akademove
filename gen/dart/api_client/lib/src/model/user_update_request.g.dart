// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_update_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UserUpdateRequestCWProxy {
  UserUpdateRequest role(UserUpdateRequestRoleEnum role);

  UserUpdateRequest password(String password);

  UserUpdateRequest confirmPassword(String confirmPassword);

  UserUpdateRequest banReason(String banReason);

  UserUpdateRequest banExpiresIn(num? banExpiresIn);

  UserUpdateRequest id(String id);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UserUpdateRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserUpdateRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  UserUpdateRequest call({
    UserUpdateRequestRoleEnum role,
    String password,
    String confirmPassword,
    String banReason,
    num? banExpiresIn,
    String id,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUserUpdateRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUserUpdateRequest.copyWith.fieldName(...)`
class _$UserUpdateRequestCWProxyImpl implements _$UserUpdateRequestCWProxy {
  const _$UserUpdateRequestCWProxyImpl(this._value);

  final UserUpdateRequest _value;

  @override
  UserUpdateRequest role(UserUpdateRequestRoleEnum role) => this(role: role);

  @override
  UserUpdateRequest password(String password) => this(password: password);

  @override
  UserUpdateRequest confirmPassword(String confirmPassword) =>
      this(confirmPassword: confirmPassword);

  @override
  UserUpdateRequest banReason(String banReason) => this(banReason: banReason);

  @override
  UserUpdateRequest banExpiresIn(num? banExpiresIn) =>
      this(banExpiresIn: banExpiresIn);

  @override
  UserUpdateRequest id(String id) => this(id: id);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UserUpdateRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserUpdateRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  UserUpdateRequest call({
    Object? role = const $CopyWithPlaceholder(),
    Object? password = const $CopyWithPlaceholder(),
    Object? confirmPassword = const $CopyWithPlaceholder(),
    Object? banReason = const $CopyWithPlaceholder(),
    Object? banExpiresIn = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
  }) {
    return UserUpdateRequest(
      role: role == const $CopyWithPlaceholder()
          ? _value.role
          // ignore: cast_nullable_to_non_nullable
          : role as UserUpdateRequestRoleEnum,
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

extension $UserUpdateRequestCopyWith on UserUpdateRequest {
  /// Returns a callable class that can be used as follows: `instanceOfUserUpdateRequest.copyWith(...)` or like so:`instanceOfUserUpdateRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UserUpdateRequestCWProxy get copyWith =>
      _$UserUpdateRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserUpdateRequest _$UserUpdateRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate('UserUpdateRequest', json, ($checkedConvert) {
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
      final val = UserUpdateRequest(
        role: $checkedConvert(
          'role',
          (v) => $enumDecode(_$UserUpdateRequestRoleEnumEnumMap, v),
        ),
        password: $checkedConvert('password', (v) => v as String),
        confirmPassword: $checkedConvert('confirmPassword', (v) => v as String),
        banReason: $checkedConvert('banReason', (v) => v as String),
        banExpiresIn: $checkedConvert('banExpiresIn', (v) => v as num?),
        id: $checkedConvert('id', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$UserUpdateRequestToJson(UserUpdateRequest instance) =>
    <String, dynamic>{
      'role': _$UserUpdateRequestRoleEnumEnumMap[instance.role]!,
      'password': instance.password,
      'confirmPassword': instance.confirmPassword,
      'banReason': instance.banReason,
      'banExpiresIn': ?instance.banExpiresIn,
      'id': instance.id,
    };

const _$UserUpdateRequestRoleEnumEnumMap = {
  UserUpdateRequestRoleEnum.admin: 'admin',
  UserUpdateRequestRoleEnum.operator_: 'operator',
  UserUpdateRequestRoleEnum.merchant: 'merchant',
  UserUpdateRequestRoleEnum.driver: 'driver',
  UserUpdateRequestRoleEnum.user: 'user',
};
