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

  InsertUser userBadges(List<UserBadge> userBadges);

  InsertUser password(String password);

  InsertUser confirmPassword(String confirmPassword);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `InsertUser(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// InsertUser(...).copyWith(id: 12, name: "My name")
  /// ```
  InsertUser call({
    String name,
    String email,
    UserRole role,
    UserGender? gender,
    Phone phone,
    List<UserBadge> userBadges,
    String password,
    String confirmPassword,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfInsertUser.copyWith(...)` or call `instanceOfInsertUser.copyWith.fieldName(value)` for a single field.
class _$InsertUserCWProxyImpl implements _$InsertUserCWProxy {
  const _$InsertUserCWProxyImpl(this._value);

  final InsertUser _value;

  @override
  InsertUser name(String name) => call(name: name);

  @override
  InsertUser email(String email) => call(email: email);

  @override
  InsertUser role(UserRole role) => call(role: role);

  @override
  InsertUser gender(UserGender? gender) => call(gender: gender);

  @override
  InsertUser phone(Phone phone) => call(phone: phone);

  @override
  InsertUser userBadges(List<UserBadge> userBadges) =>
      call(userBadges: userBadges);

  @override
  InsertUser password(String password) => call(password: password);

  @override
  InsertUser confirmPassword(String confirmPassword) =>
      call(confirmPassword: confirmPassword);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `InsertUser(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// InsertUser(...).copyWith(id: 12, name: "My name")
  /// ```
  InsertUser call({
    Object? name = const $CopyWithPlaceholder(),
    Object? email = const $CopyWithPlaceholder(),
    Object? role = const $CopyWithPlaceholder(),
    Object? gender = const $CopyWithPlaceholder(),
    Object? phone = const $CopyWithPlaceholder(),
    Object? userBadges = const $CopyWithPlaceholder(),
    Object? password = const $CopyWithPlaceholder(),
    Object? confirmPassword = const $CopyWithPlaceholder(),
  }) {
    return InsertUser(
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      email: email == const $CopyWithPlaceholder() || email == null
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String,
      role: role == const $CopyWithPlaceholder() || role == null
          ? _value.role
          // ignore: cast_nullable_to_non_nullable
          : role as UserRole,
      gender: gender == const $CopyWithPlaceholder()
          ? _value.gender
          // ignore: cast_nullable_to_non_nullable
          : gender as UserGender?,
      phone: phone == const $CopyWithPlaceholder() || phone == null
          ? _value.phone
          // ignore: cast_nullable_to_non_nullable
          : phone as Phone,
      userBadges:
          userBadges == const $CopyWithPlaceholder() || userBadges == null
          ? _value.userBadges
          // ignore: cast_nullable_to_non_nullable
          : userBadges as List<UserBadge>,
      password: password == const $CopyWithPlaceholder() || password == null
          ? _value.password
          // ignore: cast_nullable_to_non_nullable
          : password as String,
      confirmPassword:
          confirmPassword == const $CopyWithPlaceholder() ||
              confirmPassword == null
          ? _value.confirmPassword
          // ignore: cast_nullable_to_non_nullable
          : confirmPassword as String,
    );
  }
}

extension $InsertUserCopyWith on InsertUser {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfInsertUser.copyWith(...)` or `instanceOfInsertUser.copyWith.fieldName(...)`.
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
          'userBadges',
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
        userBadges: $checkedConvert(
          'userBadges',
          (v) => (v as List<dynamic>)
              .map((e) => UserBadge.fromJson(e as Map<String, dynamic>))
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
      'userBadges': instance.userBadges.map((e) => e.toJson()).toList(),
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
