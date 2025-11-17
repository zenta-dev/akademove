// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phone.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PhoneCWProxy {
  Phone countryCode(CountryCode countryCode);

  Phone number(int number);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Phone(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Phone(...).copyWith(id: 12, name: "My name")
  /// ````
  Phone call({CountryCode countryCode, int number});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPhone.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPhone.copyWith.fieldName(...)`
class _$PhoneCWProxyImpl implements _$PhoneCWProxy {
  const _$PhoneCWProxyImpl(this._value);

  final Phone _value;

  @override
  Phone countryCode(CountryCode countryCode) => this(countryCode: countryCode);

  @override
  Phone number(int number) => this(number: number);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Phone(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Phone(...).copyWith(id: 12, name: "My name")
  /// ````
  Phone call({
    Object? countryCode = const $CopyWithPlaceholder(),
    Object? number = const $CopyWithPlaceholder(),
  }) {
    return Phone(
      countryCode: countryCode == const $CopyWithPlaceholder()
          ? _value.countryCode
          // ignore: cast_nullable_to_non_nullable
          : countryCode as CountryCode,
      number: number == const $CopyWithPlaceholder()
          ? _value.number
          // ignore: cast_nullable_to_non_nullable
          : number as int,
    );
  }
}

extension $PhoneCopyWith on Phone {
  /// Returns a callable class that can be used as follows: `instanceOfPhone.copyWith(...)` or like so:`instanceOfPhone.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PhoneCWProxy get copyWith => _$PhoneCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Phone _$PhoneFromJson(Map<String, dynamic> json) =>
    $checkedCreate('Phone', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['countryCode', 'number']);
      final val = Phone(
        countryCode: $checkedConvert(
          'countryCode',
          (v) => $enumDecode(_$CountryCodeEnumMap, v),
        ),
        number: $checkedConvert('number', (v) => (v as num).toInt()),
      );
      return val;
    });

Map<String, dynamic> _$PhoneToJson(Phone instance) => <String, dynamic>{
  'countryCode': _$CountryCodeEnumMap[instance.countryCode]!,
  'number': instance.number,
};

const _$CountryCodeEnumMap = {CountryCode.ID: 'ID'};
