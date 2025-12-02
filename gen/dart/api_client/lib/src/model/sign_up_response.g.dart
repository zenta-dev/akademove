// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SignUpResponseCWProxy {
  SignUpResponse user(User user);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `SignUpResponse(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SignUpResponse(...).copyWith(id: 12, name: "My name")
  /// ```
  SignUpResponse call({User user});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfSignUpResponse.copyWith(...)` or call `instanceOfSignUpResponse.copyWith.fieldName(value)` for a single field.
class _$SignUpResponseCWProxyImpl implements _$SignUpResponseCWProxy {
  const _$SignUpResponseCWProxyImpl(this._value);

  final SignUpResponse _value;

  @override
  SignUpResponse user(User user) => call(user: user);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `SignUpResponse(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SignUpResponse(...).copyWith(id: 12, name: "My name")
  /// ```
  SignUpResponse call({Object? user = const $CopyWithPlaceholder()}) {
    return SignUpResponse(
      user: user == const $CopyWithPlaceholder() || user == null
          ? _value.user
          // ignore: cast_nullable_to_non_nullable
          : user as User,
    );
  }
}

extension $SignUpResponseCopyWith on SignUpResponse {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfSignUpResponse.copyWith(...)` or `instanceOfSignUpResponse.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SignUpResponseCWProxy get copyWith => _$SignUpResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpResponse _$SignUpResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('SignUpResponse', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['user']);
      final val = SignUpResponse(user: $checkedConvert('user', (v) => User.fromJson(v as Map<String, dynamic>)));
      return val;
    });

Map<String, dynamic> _$SignUpResponseToJson(SignUpResponse instance) => <String, dynamic>{
  'user': instance.user.toJson(),
};
