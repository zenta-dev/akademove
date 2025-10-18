// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_create_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UserCreateRequestCWProxy {
  UserCreateRequest name(String name);

  UserCreateRequest email(String email);

  UserCreateRequest role(UserCreateRequestRoleEnum role);

  UserCreateRequest gender(UserCreateRequestGenderEnum? gender);

  UserCreateRequest phone(Phone phone);

  UserCreateRequest password(String password);

  UserCreateRequest confirmPassword(String confirmPassword);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UserCreateRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserCreateRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  UserCreateRequest call({
    String name,
    String email,
    UserCreateRequestRoleEnum role,
    UserCreateRequestGenderEnum? gender,
    Phone phone,
    String password,
    String confirmPassword,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUserCreateRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUserCreateRequest.copyWith.fieldName(...)`
class _$UserCreateRequestCWProxyImpl implements _$UserCreateRequestCWProxy {
  const _$UserCreateRequestCWProxyImpl(this._value);

  final UserCreateRequest _value;

  @override
  UserCreateRequest name(String name) => this(name: name);

  @override
  UserCreateRequest email(String email) => this(email: email);

  @override
  UserCreateRequest role(UserCreateRequestRoleEnum role) => this(role: role);

  @override
  UserCreateRequest gender(UserCreateRequestGenderEnum? gender) =>
      this(gender: gender);

  @override
  UserCreateRequest phone(Phone phone) => this(phone: phone);

  @override
  UserCreateRequest password(String password) => this(password: password);

  @override
  UserCreateRequest confirmPassword(String confirmPassword) =>
      this(confirmPassword: confirmPassword);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UserCreateRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserCreateRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  UserCreateRequest call({
    Object? name = const $CopyWithPlaceholder(),
    Object? email = const $CopyWithPlaceholder(),
    Object? role = const $CopyWithPlaceholder(),
    Object? gender = const $CopyWithPlaceholder(),
    Object? phone = const $CopyWithPlaceholder(),
    Object? password = const $CopyWithPlaceholder(),
    Object? confirmPassword = const $CopyWithPlaceholder(),
  }) {
    return UserCreateRequest(
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      email: email == const $CopyWithPlaceholder()
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String,
      role: role == const $CopyWithPlaceholder()
          ? _value.role
          // ignore: cast_nullable_to_non_nullable
          : role as UserCreateRequestRoleEnum,
      gender: gender == const $CopyWithPlaceholder()
          ? _value.gender
          // ignore: cast_nullable_to_non_nullable
          : gender as UserCreateRequestGenderEnum?,
      phone: phone == const $CopyWithPlaceholder()
          ? _value.phone
          // ignore: cast_nullable_to_non_nullable
          : phone as Phone,
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

extension $UserCreateRequestCopyWith on UserCreateRequest {
  /// Returns a callable class that can be used as follows: `instanceOfUserCreateRequest.copyWith(...)` or like so:`instanceOfUserCreateRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UserCreateRequestCWProxy get copyWith =>
      _$UserCreateRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserCreateRequest _$UserCreateRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate('UserCreateRequest', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'name',
          'email',
          'role',
          'phone',
          'password',
          'confirmPassword',
        ],
      );
      final val = UserCreateRequest(
        name: $checkedConvert('name', (v) => v as String),
        email: $checkedConvert('email', (v) => v as String),
        role: $checkedConvert(
          'role',
          (v) => $enumDecode(_$UserCreateRequestRoleEnumEnumMap, v),
        ),
        gender: $checkedConvert(
          'gender',
          (v) => $enumDecodeNullable(_$UserCreateRequestGenderEnumEnumMap, v),
        ),
        phone: $checkedConvert(
          'phone',
          (v) => Phone.fromJson(v as Map<String, dynamic>),
        ),
        password: $checkedConvert('password', (v) => v as String),
        confirmPassword: $checkedConvert('confirmPassword', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$UserCreateRequestToJson(UserCreateRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'role': _$UserCreateRequestRoleEnumEnumMap[instance.role]!,
      'gender': ?_$UserCreateRequestGenderEnumEnumMap[instance.gender],
      'phone': instance.phone.toJson(),
      'password': instance.password,
      'confirmPassword': instance.confirmPassword,
    };

const _$UserCreateRequestRoleEnumEnumMap = {
  UserCreateRequestRoleEnum.admin: 'admin',
  UserCreateRequestRoleEnum.operator_: 'operator',
  UserCreateRequestRoleEnum.merchant: 'merchant',
  UserCreateRequestRoleEnum.driver: 'driver',
  UserCreateRequestRoleEnum.user: 'user',
};

const _$UserCreateRequestGenderEnumEnumMap = {
  UserCreateRequestGenderEnum.male: 'male',
  UserCreateRequestGenderEnum.female: 'female',
};
