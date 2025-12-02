// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phone.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PhoneCWProxy {
  Phone countryCode(CountryCode countryCode);

  Phone number(int number);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Phone(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Phone(...).copyWith(id: 12, name: "My name")
  /// ```
  Phone call({CountryCode countryCode, int number});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfPhone.copyWith(...)` or call `instanceOfPhone.copyWith.fieldName(value)` for a single field.
class _$PhoneCWProxyImpl implements _$PhoneCWProxy {
  const _$PhoneCWProxyImpl(this._value);

  final Phone _value;

  @override
  Phone countryCode(CountryCode countryCode) => call(countryCode: countryCode);

  @override
  Phone number(int number) => call(number: number);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Phone(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Phone(...).copyWith(id: 12, name: "My name")
  /// ```
  Phone call({Object? countryCode = const $CopyWithPlaceholder(), Object? number = const $CopyWithPlaceholder()}) {
    return Phone(
      countryCode: countryCode == const $CopyWithPlaceholder() || countryCode == null
          ? _value.countryCode
          // ignore: cast_nullable_to_non_nullable
          : countryCode as CountryCode,
      number: number == const $CopyWithPlaceholder() || number == null
          ? _value.number
          // ignore: cast_nullable_to_non_nullable
          : number as int,
    );
  }
}

extension $PhoneCopyWith on Phone {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfPhone.copyWith(...)` or `instanceOfPhone.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PhoneCWProxy get copyWith => _$PhoneCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Phone _$PhoneFromJson(Map<String, dynamic> json) => $checkedCreate('Phone', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['countryCode', 'number']);
  final val = Phone(
    countryCode: $checkedConvert('countryCode', (v) => $enumDecode(_$CountryCodeEnumMap, v)),
    number: $checkedConvert('number', (v) => (v as num).toInt()),
  );
  return val;
});

Map<String, dynamic> _$PhoneToJson(Phone instance) => <String, dynamic>{
  'countryCode': _$CountryCodeEnumMap[instance.countryCode]!,
  'number': instance.number,
};

const _$CountryCodeEnumMap = {CountryCode.ID: 'ID'};
