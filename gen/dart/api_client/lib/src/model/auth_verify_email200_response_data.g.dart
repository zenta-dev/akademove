// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_verify_email200_response_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AuthVerifyEmail200ResponseDataCWProxy {
  AuthVerifyEmail200ResponseData ok(bool ok);

  AuthVerifyEmail200ResponseData token(String? token);

  AuthVerifyEmail200ResponseData user(User? user);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `AuthVerifyEmail200ResponseData(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AuthVerifyEmail200ResponseData(...).copyWith(id: 12, name: "My name")
  /// ```
  AuthVerifyEmail200ResponseData call({bool ok, String? token, User? user});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfAuthVerifyEmail200ResponseData.copyWith(...)` or call `instanceOfAuthVerifyEmail200ResponseData.copyWith.fieldName(value)` for a single field.
class _$AuthVerifyEmail200ResponseDataCWProxyImpl
    implements _$AuthVerifyEmail200ResponseDataCWProxy {
  const _$AuthVerifyEmail200ResponseDataCWProxyImpl(this._value);

  final AuthVerifyEmail200ResponseData _value;

  @override
  AuthVerifyEmail200ResponseData ok(bool ok) => call(ok: ok);

  @override
  AuthVerifyEmail200ResponseData token(String? token) => call(token: token);

  @override
  AuthVerifyEmail200ResponseData user(User? user) => call(user: user);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `AuthVerifyEmail200ResponseData(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AuthVerifyEmail200ResponseData(...).copyWith(id: 12, name: "My name")
  /// ```
  AuthVerifyEmail200ResponseData call({
    Object? ok = const $CopyWithPlaceholder(),
    Object? token = const $CopyWithPlaceholder(),
    Object? user = const $CopyWithPlaceholder(),
  }) {
    return AuthVerifyEmail200ResponseData(
      ok: ok == const $CopyWithPlaceholder() || ok == null
          ? _value.ok
          // ignore: cast_nullable_to_non_nullable
          : ok as bool,
      token: token == const $CopyWithPlaceholder()
          ? _value.token
          // ignore: cast_nullable_to_non_nullable
          : token as String?,
      user: user == const $CopyWithPlaceholder()
          ? _value.user
          // ignore: cast_nullable_to_non_nullable
          : user as User?,
    );
  }
}

extension $AuthVerifyEmail200ResponseDataCopyWith
    on AuthVerifyEmail200ResponseData {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfAuthVerifyEmail200ResponseData.copyWith(...)` or `instanceOfAuthVerifyEmail200ResponseData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AuthVerifyEmail200ResponseDataCWProxy get copyWith =>
      _$AuthVerifyEmail200ResponseDataCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthVerifyEmail200ResponseData _$AuthVerifyEmail200ResponseDataFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('AuthVerifyEmail200ResponseData', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['ok']);
  final val = AuthVerifyEmail200ResponseData(
    ok: $checkedConvert('ok', (v) => v as bool),
    token: $checkedConvert('token', (v) => v as String?),
    user: $checkedConvert(
      'user',
      (v) => v == null ? null : User.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$AuthVerifyEmail200ResponseDataToJson(
  AuthVerifyEmail200ResponseData instance,
) => <String, dynamic>{
  'ok': instance.ok,
  'token': ?instance.token,
  'user': ?instance.user?.toJson(),
};
