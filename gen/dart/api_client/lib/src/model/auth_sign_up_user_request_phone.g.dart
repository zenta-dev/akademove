// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_sign_up_user_request_phone.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AuthSignUpUserRequestPhoneCWProxy {
  AuthSignUpUserRequestPhone countryCode(
    AuthSignUpUserRequestPhoneCountryCodeEnum countryCode,
  );

  AuthSignUpUserRequestPhone number(num number);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AuthSignUpUserRequestPhone(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AuthSignUpUserRequestPhone(...).copyWith(id: 12, name: "My name")
  /// ````
  AuthSignUpUserRequestPhone call({
    AuthSignUpUserRequestPhoneCountryCodeEnum countryCode,
    num number,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAuthSignUpUserRequestPhone.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAuthSignUpUserRequestPhone.copyWith.fieldName(...)`
class _$AuthSignUpUserRequestPhoneCWProxyImpl
    implements _$AuthSignUpUserRequestPhoneCWProxy {
  const _$AuthSignUpUserRequestPhoneCWProxyImpl(this._value);

  final AuthSignUpUserRequestPhone _value;

  @override
  AuthSignUpUserRequestPhone countryCode(
    AuthSignUpUserRequestPhoneCountryCodeEnum countryCode,
  ) => this(countryCode: countryCode);

  @override
  AuthSignUpUserRequestPhone number(num number) => this(number: number);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AuthSignUpUserRequestPhone(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AuthSignUpUserRequestPhone(...).copyWith(id: 12, name: "My name")
  /// ````
  AuthSignUpUserRequestPhone call({
    Object? countryCode = const $CopyWithPlaceholder(),
    Object? number = const $CopyWithPlaceholder(),
  }) {
    return AuthSignUpUserRequestPhone(
      countryCode: countryCode == const $CopyWithPlaceholder()
          ? _value.countryCode
          // ignore: cast_nullable_to_non_nullable
          : countryCode as AuthSignUpUserRequestPhoneCountryCodeEnum,
      number: number == const $CopyWithPlaceholder()
          ? _value.number
          // ignore: cast_nullable_to_non_nullable
          : number as num,
    );
  }
}

extension $AuthSignUpUserRequestPhoneCopyWith on AuthSignUpUserRequestPhone {
  /// Returns a callable class that can be used as follows: `instanceOfAuthSignUpUserRequestPhone.copyWith(...)` or like so:`instanceOfAuthSignUpUserRequestPhone.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AuthSignUpUserRequestPhoneCWProxy get copyWith =>
      _$AuthSignUpUserRequestPhoneCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthSignUpUserRequestPhone _$AuthSignUpUserRequestPhoneFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('AuthSignUpUserRequestPhone', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['countryCode', 'number']);
  final val = AuthSignUpUserRequestPhone(
    countryCode: $checkedConvert(
      'countryCode',
      (v) => $enumDecode(_$AuthSignUpUserRequestPhoneCountryCodeEnumEnumMap, v),
    ),
    number: $checkedConvert('number', (v) => v as num),
  );
  return val;
});

Map<String, dynamic> _$AuthSignUpUserRequestPhoneToJson(
  AuthSignUpUserRequestPhone instance,
) => <String, dynamic>{
  'countryCode':
      _$AuthSignUpUserRequestPhoneCountryCodeEnumEnumMap[instance.countryCode]!,
  'number': instance.number,
};

const _$AuthSignUpUserRequestPhoneCountryCodeEnumEnumMap = {
  AuthSignUpUserRequestPhoneCountryCodeEnum.ID: 'ID',
};
