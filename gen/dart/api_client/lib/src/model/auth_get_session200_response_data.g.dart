// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_get_session200_response_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AuthGetSession200ResponseDataCWProxy {
  AuthGetSession200ResponseData token(String? token);

  AuthGetSession200ResponseData user(User user);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AuthGetSession200ResponseData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AuthGetSession200ResponseData(...).copyWith(id: 12, name: "My name")
  /// ````
  AuthGetSession200ResponseData call({String? token, User user});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAuthGetSession200ResponseData.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAuthGetSession200ResponseData.copyWith.fieldName(...)`
class _$AuthGetSession200ResponseDataCWProxyImpl
    implements _$AuthGetSession200ResponseDataCWProxy {
  const _$AuthGetSession200ResponseDataCWProxyImpl(this._value);

  final AuthGetSession200ResponseData _value;

  @override
  AuthGetSession200ResponseData token(String? token) => this(token: token);

  @override
  AuthGetSession200ResponseData user(User user) => this(user: user);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AuthGetSession200ResponseData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AuthGetSession200ResponseData(...).copyWith(id: 12, name: "My name")
  /// ````
  AuthGetSession200ResponseData call({
    Object? token = const $CopyWithPlaceholder(),
    Object? user = const $CopyWithPlaceholder(),
  }) {
    return AuthGetSession200ResponseData(
      token: token == const $CopyWithPlaceholder()
          ? _value.token
          // ignore: cast_nullable_to_non_nullable
          : token as String?,
      user: user == const $CopyWithPlaceholder()
          ? _value.user
          // ignore: cast_nullable_to_non_nullable
          : user as User,
    );
  }
}

extension $AuthGetSession200ResponseDataCopyWith
    on AuthGetSession200ResponseData {
  /// Returns a callable class that can be used as follows: `instanceOfAuthGetSession200ResponseData.copyWith(...)` or like so:`instanceOfAuthGetSession200ResponseData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AuthGetSession200ResponseDataCWProxy get copyWith =>
      _$AuthGetSession200ResponseDataCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthGetSession200ResponseData _$AuthGetSession200ResponseDataFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('AuthGetSession200ResponseData', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['user']);
  final val = AuthGetSession200ResponseData(
    token: $checkedConvert('token', (v) => v as String?),
    user: $checkedConvert(
      'user',
      (v) => User.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$AuthGetSession200ResponseDataToJson(
  AuthGetSession200ResponseData instance,
) => <String, dynamic>{
  'token': ?instance.token,
  'user': instance.user.toJson(),
};
