// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insert_user.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$InsertUserCWProxy {
  InsertUser name(String name);

  InsertUser email(String email);

  InsertUser role(UserRole role);

  InsertUser gender(UserGender? gender);

  InsertUser phone(Phone phone);

  InsertUser badges(List<Badge> badges);

  InsertUser password(String password);

  InsertUser confirmPassword(String confirmPassword);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `InsertUser(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// InsertUser(...).copyWith(id: 12, name: "My name")
  /// ````
  InsertUser call({
    String name,
    String email,
    UserRole role,
    UserGender? gender,
    Phone phone,
    List<Badge> badges,
    String password,
    String confirmPassword,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfInsertUser.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfInsertUser.copyWith.fieldName(...)`
class _$InsertUserCWProxyImpl implements _$InsertUserCWProxy {
  const _$InsertUserCWProxyImpl(this._value);

  final InsertUser _value;

  @override
  InsertUser name(String name) => this(name: name);

  @override
  InsertUser email(String email) => this(email: email);

  @override
  InsertUser role(UserRole role) => this(role: role);

  @override
  InsertUser gender(UserGender? gender) => this(gender: gender);

  @override
  InsertUser phone(Phone phone) => this(phone: phone);

  @override
  InsertUser badges(List<Badge> badges) => this(badges: badges);

  @override
  InsertUser password(String password) => this(password: password);

  @override
  InsertUser confirmPassword(String confirmPassword) =>
      this(confirmPassword: confirmPassword);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `InsertUser(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// InsertUser(...).copyWith(id: 12, name: "My name")
  /// ````
  InsertUser call({
    Object? name = const $CopyWithPlaceholder(),
    Object? email = const $CopyWithPlaceholder(),
    Object? role = const $CopyWithPlaceholder(),
    Object? gender = const $CopyWithPlaceholder(),
    Object? phone = const $CopyWithPlaceholder(),
    Object? badges = const $CopyWithPlaceholder(),
    Object? password = const $CopyWithPlaceholder(),
    Object? confirmPassword = const $CopyWithPlaceholder(),
  }) {
    return InsertUser(
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
          : role as UserRole,
      gender: gender == const $CopyWithPlaceholder()
          ? _value.gender
          // ignore: cast_nullable_to_non_nullable
          : gender as UserGender?,
      phone: phone == const $CopyWithPlaceholder()
          ? _value.phone
          // ignore: cast_nullable_to_non_nullable
          : phone as Phone,
      badges: badges == const $CopyWithPlaceholder()
          ? _value.badges
          // ignore: cast_nullable_to_non_nullable
          : badges as List<Badge>,
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

extension $InsertUserCopyWith on InsertUser {
  /// Returns a callable class that can be used as follows: `instanceOfInsertUser.copyWith(...)` or like so:`instanceOfInsertUser.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$InsertUserCWProxy get copyWith => _$InsertUserCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InsertUser _$InsertUserFromJson(Map<String, dynamic> json) =>
    $checkedCreate('InsertUser', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'name',
          'email',
          'role',
          'phone',
          'badges',
          'password',
          'confirmPassword',
        ],
      );
      final val = InsertUser(
        name: $checkedConvert('name', (v) => v as String),
        email: $checkedConvert('email', (v) => v as String),
        role: $checkedConvert('role', (v) => $enumDecode(_$UserRoleEnumMap, v)),
        gender: $checkedConvert(
          'gender',
          (v) => $enumDecodeNullable(_$UserGenderEnumMap, v),
        ),
        phone: $checkedConvert(
          'phone',
          (v) => Phone.fromJson(v as Map<String, dynamic>),
        ),
        badges: $checkedConvert(
          'badges',
          (v) => (v as List<dynamic>)
              .map((e) => Badge.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        password: $checkedConvert('password', (v) => v as String),
        confirmPassword: $checkedConvert('confirmPassword', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$InsertUserToJson(InsertUser instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'role': _$UserRoleEnumMap[instance.role]!,
      'gender': ?_$UserGenderEnumMap[instance.gender],
      'phone': instance.phone.toJson(),
      'badges': instance.badges.map((e) => e.toJson()).toList(),
      'password': instance.password,
      'confirmPassword': instance.confirmPassword,
    };

const _$UserRoleEnumMap = {
  UserRole.admin: 'admin',
  UserRole.operator_: 'operator',
  UserRole.merchant: 'merchant',
  UserRole.driver: 'driver',
  UserRole.user: 'user',
};

const _$UserGenderEnumMap = {
  UserGender.male: 'male',
  UserGender.female: 'female',
};
