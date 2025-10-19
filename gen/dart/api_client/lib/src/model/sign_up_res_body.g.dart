// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_res_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SignUpResBodyCWProxy {
  SignUpResBody user(User user);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SignUpResBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SignUpResBody(...).copyWith(id: 12, name: "My name")
  /// ````
  SignUpResBody call({User user});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfSignUpResBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfSignUpResBody.copyWith.fieldName(...)`
class _$SignUpResBodyCWProxyImpl implements _$SignUpResBodyCWProxy {
  const _$SignUpResBodyCWProxyImpl(this._value);

  final SignUpResBody _value;

  @override
  SignUpResBody user(User user) => this(user: user);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SignUpResBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SignUpResBody(...).copyWith(id: 12, name: "My name")
  /// ````
  SignUpResBody call({Object? user = const $CopyWithPlaceholder()}) {
    return SignUpResBody(
      user: user == const $CopyWithPlaceholder()
          ? _value.user
          // ignore: cast_nullable_to_non_nullable
          : user as User,
    );
  }
}

extension $SignUpResBodyCopyWith on SignUpResBody {
  /// Returns a callable class that can be used as follows: `instanceOfSignUpResBody.copyWith(...)` or like so:`instanceOfSignUpResBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SignUpResBodyCWProxy get copyWith => _$SignUpResBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpResBody _$SignUpResBodyFromJson(Map<String, dynamic> json) =>
    $checkedCreate('SignUpResBody', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['user']);
      final val = SignUpResBody(
        user: $checkedConvert(
          'user',
          (v) => User.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$SignUpResBodyToJson(SignUpResBody instance) =>
    <String, dynamic>{'user': instance.user.toJson()};
