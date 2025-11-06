// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SignInResponseCWProxy {
  SignInResponse token(String token);

  SignInResponse user(User user);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SignInResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SignInResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  SignInResponse call({String token, User user});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfSignInResponse.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfSignInResponse.copyWith.fieldName(...)`
class _$SignInResponseCWProxyImpl implements _$SignInResponseCWProxy {
  const _$SignInResponseCWProxyImpl(this._value);

  final SignInResponse _value;

  @override
  SignInResponse token(String token) => this(token: token);

  @override
  SignInResponse user(User user) => this(user: user);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SignInResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SignInResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  SignInResponse call({
    Object? token = const $CopyWithPlaceholder(),
    Object? user = const $CopyWithPlaceholder(),
  }) {
    return SignInResponse(
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

extension $SignInResponseCopyWith on SignInResponse {
  /// Returns a callable class that can be used as follows: `instanceOfSignInResponse.copyWith(...)` or like so:`instanceOfSignInResponse.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SignInResponseCWProxy get copyWith => _$SignInResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignInResponse _$SignInResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('SignInResponse', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['token', 'user']);
      final val = SignInResponse(
        token: $checkedConvert('token', (v) => v as String),
        user: $checkedConvert(
          'user',
          (v) => User.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$SignInResponseToJson(SignInResponse instance) =>
    <String, dynamic>{'token': instance.token, 'user': instance.user.toJson()};
