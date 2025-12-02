// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'va_number.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$VANumberCWProxy {
  VANumber bank(String bank);

  VANumber vaNumber(String vaNumber);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `VANumber(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// VANumber(...).copyWith(id: 12, name: "My name")
  /// ```
  VANumber call({String bank, String vaNumber});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfVANumber.copyWith(...)` or call `instanceOfVANumber.copyWith.fieldName(value)` for a single field.
class _$VANumberCWProxyImpl implements _$VANumberCWProxy {
  const _$VANumberCWProxyImpl(this._value);

  final VANumber _value;

  @override
  VANumber bank(String bank) => call(bank: bank);

  @override
  VANumber vaNumber(String vaNumber) => call(vaNumber: vaNumber);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `VANumber(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// VANumber(...).copyWith(id: 12, name: "My name")
  /// ```
  VANumber call({
    Object? bank = const $CopyWithPlaceholder(),
    Object? vaNumber = const $CopyWithPlaceholder(),
  }) {
    return VANumber(
      bank: bank == const $CopyWithPlaceholder() || bank == null
          ? _value.bank
          // ignore: cast_nullable_to_non_nullable
          : bank as String,
      vaNumber: vaNumber == const $CopyWithPlaceholder() || vaNumber == null
          ? _value.vaNumber
          // ignore: cast_nullable_to_non_nullable
          : vaNumber as String,
    );
  }
}

extension $VANumberCopyWith on VANumber {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfVANumber.copyWith(...)` or `instanceOfVANumber.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$VANumberCWProxy get copyWith => _$VANumberCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VANumber _$VANumberFromJson(Map<String, dynamic> json) =>
    $checkedCreate('VANumber', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['bank', 'va_number']);
      final val = VANumber(
        bank: $checkedConvert('bank', (v) => v as String),
        vaNumber: $checkedConvert('va_number', (v) => v as String),
      );
      return val;
    }, fieldKeyMap: const {'vaNumber': 'va_number'});

Map<String, dynamic> _$VANumberToJson(VANumber instance) => <String, dynamic>{
  'bank': instance.bank,
  'va_number': instance.vaNumber,
};
