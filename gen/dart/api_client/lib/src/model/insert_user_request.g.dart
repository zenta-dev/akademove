// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insert_user_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$InsertUserRequestCWProxy {
  InsertUserRequest name(String name);

  InsertUserRequest email(String email);

  InsertUserRequest role(InsertUserRequestRoleEnum role);

  InsertUserRequest gender(InsertUserRequestGenderEnum? gender);

  InsertUserRequest phone(Phone phone);

  InsertUserRequest password(String password);

  InsertUserRequest confirmPassword(String confirmPassword);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `InsertUserRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// InsertUserRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  InsertUserRequest call({
    String name,
    String email,
    InsertUserRequestRoleEnum role,
    InsertUserRequestGenderEnum? gender,
    Phone phone,
    String password,
    String confirmPassword,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfInsertUserRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfInsertUserRequest.copyWith.fieldName(...)`
class _$InsertUserRequestCWProxyImpl implements _$InsertUserRequestCWProxy {
  const _$InsertUserRequestCWProxyImpl(this._value);

  final InsertUserRequest _value;

  @override
  InsertUserRequest name(String name) => this(name: name);

  @override
  InsertUserRequest email(String email) => this(email: email);

  @override
  InsertUserRequest role(InsertUserRequestRoleEnum role) => this(role: role);

  @override
  InsertUserRequest gender(InsertUserRequestGenderEnum? gender) =>
      this(gender: gender);

  @override
  InsertUserRequest phone(Phone phone) => this(phone: phone);

  @override
  InsertUserRequest password(String password) => this(password: password);

  @override
  InsertUserRequest confirmPassword(String confirmPassword) =>
      this(confirmPassword: confirmPassword);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `InsertUserRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// InsertUserRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  InsertUserRequest call({
    Object? name = const $CopyWithPlaceholder(),
    Object? email = const $CopyWithPlaceholder(),
    Object? role = const $CopyWithPlaceholder(),
    Object? gender = const $CopyWithPlaceholder(),
    Object? phone = const $CopyWithPlaceholder(),
    Object? password = const $CopyWithPlaceholder(),
    Object? confirmPassword = const $CopyWithPlaceholder(),
  }) {
    return InsertUserRequest(
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
          : role as InsertUserRequestRoleEnum,
      gender: gender == const $CopyWithPlaceholder()
          ? _value.gender
          // ignore: cast_nullable_to_non_nullable
          : gender as InsertUserRequestGenderEnum?,
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

extension $InsertUserRequestCopyWith on InsertUserRequest {
  /// Returns a callable class that can be used as follows: `instanceOfInsertUserRequest.copyWith(...)` or like so:`instanceOfInsertUserRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$InsertUserRequestCWProxy get copyWith =>
      _$InsertUserRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InsertUserRequest _$InsertUserRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate('InsertUserRequest', json, ($checkedConvert) {
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
      final val = InsertUserRequest(
        name: $checkedConvert('name', (v) => v as String),
        email: $checkedConvert('email', (v) => v as String),
        role: $checkedConvert(
          'role',
          (v) => $enumDecode(_$InsertUserRequestRoleEnumEnumMap, v),
        ),
        gender: $checkedConvert(
          'gender',
          (v) => $enumDecodeNullable(_$InsertUserRequestGenderEnumEnumMap, v),
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

Map<String, dynamic> _$InsertUserRequestToJson(InsertUserRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'role': _$InsertUserRequestRoleEnumEnumMap[instance.role]!,
      'gender': ?_$InsertUserRequestGenderEnumEnumMap[instance.gender],
      'phone': instance.phone.toJson(),
      'password': instance.password,
      'confirmPassword': instance.confirmPassword,
    };

const _$InsertUserRequestRoleEnumEnumMap = {
  InsertUserRequestRoleEnum.admin: 'admin',
  InsertUserRequestRoleEnum.operator_: 'operator',
  InsertUserRequestRoleEnum.merchant: 'merchant',
  InsertUserRequestRoleEnum.driver: 'driver',
  InsertUserRequestRoleEnum.user: 'user',
};

const _$InsertUserRequestGenderEnumEnumMap = {
  InsertUserRequestGenderEnum.male: 'male',
  InsertUserRequestGenderEnum.female: 'female',
};
