// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_sign_up_user200_response_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AuthSignUpUser200ResponseDataCWProxy {
  AuthSignUpUser200ResponseData user(User user);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AuthSignUpUser200ResponseData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AuthSignUpUser200ResponseData(...).copyWith(id: 12, name: "My name")
  /// ````
  AuthSignUpUser200ResponseData call({User user});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAuthSignUpUser200ResponseData.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAuthSignUpUser200ResponseData.copyWith.fieldName(...)`
class _$AuthSignUpUser200ResponseDataCWProxyImpl
    implements _$AuthSignUpUser200ResponseDataCWProxy {
  const _$AuthSignUpUser200ResponseDataCWProxyImpl(this._value);

  final AuthSignUpUser200ResponseData _value;

  @override
  AuthSignUpUser200ResponseData user(User user) => this(user: user);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AuthSignUpUser200ResponseData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AuthSignUpUser200ResponseData(...).copyWith(id: 12, name: "My name")
  /// ````
  AuthSignUpUser200ResponseData call({
    Object? user = const $CopyWithPlaceholder(),
  }) {
    return AuthSignUpUser200ResponseData(
      user: user == const $CopyWithPlaceholder()
          ? _value.user
          // ignore: cast_nullable_to_non_nullable
          : user as User,
    );
  }
}

extension $AuthSignUpUser200ResponseDataCopyWith
    on AuthSignUpUser200ResponseData {
  /// Returns a callable class that can be used as follows: `instanceOfAuthSignUpUser200ResponseData.copyWith(...)` or like so:`instanceOfAuthSignUpUser200ResponseData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AuthSignUpUser200ResponseDataCWProxy get copyWith =>
      _$AuthSignUpUser200ResponseDataCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthSignUpUser200ResponseData _$AuthSignUpUser200ResponseDataFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('AuthSignUpUser200ResponseData', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['user']);
  final val = AuthSignUpUser200ResponseData(
    user: $checkedConvert(
      'user',
      (v) => User.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$AuthSignUpUser200ResponseDataToJson(
  AuthSignUpUser200ResponseData instance,
) => <String, dynamic>{'user': instance.user.toJson()};
