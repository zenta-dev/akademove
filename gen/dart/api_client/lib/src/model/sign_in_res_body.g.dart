// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_res_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SignInResBodyCWProxy {
  SignInResBody token(String token);

  SignInResBody user(User user);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SignInResBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SignInResBody(...).copyWith(id: 12, name: "My name")
  /// ````
  SignInResBody call({String token, User user});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfSignInResBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfSignInResBody.copyWith.fieldName(...)`
class _$SignInResBodyCWProxyImpl implements _$SignInResBodyCWProxy {
  const _$SignInResBodyCWProxyImpl(this._value);

  final SignInResBody _value;

  @override
  SignInResBody token(String token) => this(token: token);

  @override
  SignInResBody user(User user) => this(user: user);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SignInResBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SignInResBody(...).copyWith(id: 12, name: "My name")
  /// ````
  SignInResBody call({
    Object? token = const $CopyWithPlaceholder(),
    Object? user = const $CopyWithPlaceholder(),
  }) {
    return SignInResBody(
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

extension $SignInResBodyCopyWith on SignInResBody {
  /// Returns a callable class that can be used as follows: `instanceOfSignInResBody.copyWith(...)` or like so:`instanceOfSignInResBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SignInResBodyCWProxy get copyWith => _$SignInResBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignInResBody _$SignInResBodyFromJson(Map<String, dynamic> json) =>
    $checkedCreate('SignInResBody', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['token', 'user']);
      final val = SignInResBody(
        token: $checkedConvert('token', (v) => v as String),
        user: $checkedConvert(
          'user',
          (v) => User.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$SignInResBodyToJson(SignInResBody instance) =>
    <String, dynamic>{'token': instance.token, 'user': instance.user.toJson()};
