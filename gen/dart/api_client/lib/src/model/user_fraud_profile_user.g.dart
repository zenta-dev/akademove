// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_fraud_profile_user.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UserFraudProfileUserCWProxy {
  UserFraudProfileUser id(String id);

  UserFraudProfileUser name(String name);

  UserFraudProfileUser email(String email);

  UserFraudProfileUser role(String role);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UserFraudProfileUser(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UserFraudProfileUser(...).copyWith(id: 12, name: "My name")
  /// ```
  UserFraudProfileUser call({
    String id,
    String name,
    String email,
    String role,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfUserFraudProfileUser.copyWith(...)` or call `instanceOfUserFraudProfileUser.copyWith.fieldName(value)` for a single field.
class _$UserFraudProfileUserCWProxyImpl
    implements _$UserFraudProfileUserCWProxy {
  const _$UserFraudProfileUserCWProxyImpl(this._value);

  final UserFraudProfileUser _value;

  @override
  UserFraudProfileUser id(String id) => call(id: id);

  @override
  UserFraudProfileUser name(String name) => call(name: name);

  @override
  UserFraudProfileUser email(String email) => call(email: email);

  @override
  UserFraudProfileUser role(String role) => call(role: role);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UserFraudProfileUser(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UserFraudProfileUser(...).copyWith(id: 12, name: "My name")
  /// ```
  UserFraudProfileUser call({
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? email = const $CopyWithPlaceholder(),
    Object? role = const $CopyWithPlaceholder(),
  }) {
    return UserFraudProfileUser(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
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
          : role as String,
    );
  }
}

extension $UserFraudProfileUserCopyWith on UserFraudProfileUser {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfUserFraudProfileUser.copyWith(...)` or `instanceOfUserFraudProfileUser.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UserFraudProfileUserCWProxy get copyWith =>
      _$UserFraudProfileUserCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserFraudProfileUser _$UserFraudProfileUserFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('UserFraudProfileUser', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['id', 'name', 'email', 'role']);
  final val = UserFraudProfileUser(
    id: $checkedConvert('id', (v) => v as String),
    name: $checkedConvert('name', (v) => v as String),
    email: $checkedConvert('email', (v) => v as String),
    role: $checkedConvert('role', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$UserFraudProfileUserToJson(
  UserFraudProfileUser instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'email': instance.email,
  'role': instance.role,
};
