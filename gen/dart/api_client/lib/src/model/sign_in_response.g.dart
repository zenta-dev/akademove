// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SignInResponseCWProxy {
  SignInResponse token(String token);

  SignInResponse user(User user);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `SignInResponse(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SignInResponse(...).copyWith(id: 12, name: "My name")
  /// ```
  SignInResponse call({String token, User user});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfSignInResponse.copyWith(...)` or call `instanceOfSignInResponse.copyWith.fieldName(value)` for a single field.
class _$SignInResponseCWProxyImpl implements _$SignInResponseCWProxy {
  const _$SignInResponseCWProxyImpl(this._value);

  final SignInResponse _value;

  @override
  SignInResponse token(String token) => call(token: token);

  @override
  SignInResponse user(User user) => call(user: user);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `SignInResponse(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SignInResponse(...).copyWith(id: 12, name: "My name")
  /// ```
  SignInResponse call({Object? token = const $CopyWithPlaceholder(), Object? user = const $CopyWithPlaceholder()}) {
    return SignInResponse(
      token: token == const $CopyWithPlaceholder() || token == null
          ? _value.token
          // ignore: cast_nullable_to_non_nullable
          : token as String,
      user: user == const $CopyWithPlaceholder() || user == null
          ? _value.user
          // ignore: cast_nullable_to_non_nullable
          : user as User,
    );
  }
}

extension $SignInResponseCopyWith on SignInResponse {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfSignInResponse.copyWith(...)` or `instanceOfSignInResponse.copyWith.fieldName(...)`.
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
        user: $checkedConvert('user', (v) => User.fromJson(v as Map<String, dynamic>)),
      );
      return val;
    });

Map<String, dynamic> _$SignInResponseToJson(SignInResponse instance) => <String, dynamic>{
  'token': instance.token,
  'user': instance.user.toJson(),
};
