// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SignUpResponseCWProxy {
  SignUpResponse user(User user);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SignUpResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SignUpResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  SignUpResponse call({User user});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfSignUpResponse.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfSignUpResponse.copyWith.fieldName(...)`
class _$SignUpResponseCWProxyImpl implements _$SignUpResponseCWProxy {
  const _$SignUpResponseCWProxyImpl(this._value);

  final SignUpResponse _value;

  @override
  SignUpResponse user(User user) => this(user: user);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SignUpResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SignUpResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  SignUpResponse call({Object? user = const $CopyWithPlaceholder()}) {
    return SignUpResponse(
      user: user == const $CopyWithPlaceholder()
          ? _value.user
          // ignore: cast_nullable_to_non_nullable
          : user as User,
    );
  }
}

extension $SignUpResponseCopyWith on SignUpResponse {
  /// Returns a callable class that can be used as follows: `instanceOfSignUpResponse.copyWith(...)` or like so:`instanceOfSignUpResponse.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SignUpResponseCWProxy get copyWith => _$SignUpResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpResponse _$SignUpResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('SignUpResponse', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['user']);
      final val = SignUpResponse(
        user: $checkedConvert(
          'user',
          (v) => User.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$SignUpResponseToJson(SignUpResponse instance) =>
    <String, dynamic>{'user': instance.user.toJson()};
