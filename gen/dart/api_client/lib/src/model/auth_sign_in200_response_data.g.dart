// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_sign_in200_response_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AuthSignIn200ResponseDataCWProxy {
  AuthSignIn200ResponseData token(String token);

  AuthSignIn200ResponseData user(User user);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AuthSignIn200ResponseData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AuthSignIn200ResponseData(...).copyWith(id: 12, name: "My name")
  /// ````
  AuthSignIn200ResponseData call({String token, User user});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAuthSignIn200ResponseData.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAuthSignIn200ResponseData.copyWith.fieldName(...)`
class _$AuthSignIn200ResponseDataCWProxyImpl
    implements _$AuthSignIn200ResponseDataCWProxy {
  const _$AuthSignIn200ResponseDataCWProxyImpl(this._value);

  final AuthSignIn200ResponseData _value;

  @override
  AuthSignIn200ResponseData token(String token) => this(token: token);

  @override
  AuthSignIn200ResponseData user(User user) => this(user: user);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AuthSignIn200ResponseData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AuthSignIn200ResponseData(...).copyWith(id: 12, name: "My name")
  /// ````
  AuthSignIn200ResponseData call({
    Object? token = const $CopyWithPlaceholder(),
    Object? user = const $CopyWithPlaceholder(),
  }) {
    return AuthSignIn200ResponseData(
      token: token == const $CopyWithPlaceholder()
          ? _value.token
          // ignore: cast_nullable_to_non_nullable
          : token as String,
      user: user == const $CopyWithPlaceholder()
          ? _value.user
          // ignore: cast_nullable_to_non_nullable
          : user as User,
    );
  }
}

extension $AuthSignIn200ResponseDataCopyWith on AuthSignIn200ResponseData {
  /// Returns a callable class that can be used as follows: `instanceOfAuthSignIn200ResponseData.copyWith(...)` or like so:`instanceOfAuthSignIn200ResponseData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AuthSignIn200ResponseDataCWProxy get copyWith =>
      _$AuthSignIn200ResponseDataCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthSignIn200ResponseData _$AuthSignIn200ResponseDataFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('AuthSignIn200ResponseData', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['token', 'user']);
  final val = AuthSignIn200ResponseData(
    token: $checkedConvert('token', (v) => v as String),
    user: $checkedConvert(
      'user',
      (v) => User.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$AuthSignIn200ResponseDataToJson(
  AuthSignIn200ResponseData instance,
) => <String, dynamic>{'token': instance.token, 'user': instance.user.toJson()};
