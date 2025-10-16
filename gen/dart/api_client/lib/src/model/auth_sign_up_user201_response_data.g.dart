// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_sign_up_user201_response_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AuthSignUpUser201ResponseDataCWProxy {
  AuthSignUpUser201ResponseData user(User user);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AuthSignUpUser201ResponseData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AuthSignUpUser201ResponseData(...).copyWith(id: 12, name: "My name")
  /// ````
  AuthSignUpUser201ResponseData call({User user});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAuthSignUpUser201ResponseData.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAuthSignUpUser201ResponseData.copyWith.fieldName(...)`
class _$AuthSignUpUser201ResponseDataCWProxyImpl
    implements _$AuthSignUpUser201ResponseDataCWProxy {
  const _$AuthSignUpUser201ResponseDataCWProxyImpl(this._value);

  final AuthSignUpUser201ResponseData _value;

  @override
  AuthSignUpUser201ResponseData user(User user) => this(user: user);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AuthSignUpUser201ResponseData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AuthSignUpUser201ResponseData(...).copyWith(id: 12, name: "My name")
  /// ````
  AuthSignUpUser201ResponseData call({
    Object? user = const $CopyWithPlaceholder(),
  }) {
    return AuthSignUpUser201ResponseData(
      user: user == const $CopyWithPlaceholder()
          ? _value.user
          // ignore: cast_nullable_to_non_nullable
          : user as User,
    );
  }
}

extension $AuthSignUpUser201ResponseDataCopyWith
    on AuthSignUpUser201ResponseData {
  /// Returns a callable class that can be used as follows: `instanceOfAuthSignUpUser201ResponseData.copyWith(...)` or like so:`instanceOfAuthSignUpUser201ResponseData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AuthSignUpUser201ResponseDataCWProxy get copyWith =>
      _$AuthSignUpUser201ResponseDataCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthSignUpUser201ResponseData _$AuthSignUpUser201ResponseDataFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('AuthSignUpUser201ResponseData', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['user']);
  final val = AuthSignUpUser201ResponseData(
    user: $checkedConvert(
      'user',
      (v) => User.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$AuthSignUpUser201ResponseDataToJson(
  AuthSignUpUser201ResponseData instance,
) => <String, dynamic>{'user': instance.user.toJson()};
