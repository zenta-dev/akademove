// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_validation_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BankValidationResponseCWProxy {
  BankValidationResponse isValid(bool isValid);

  BankValidationResponse accountName(String? accountName);

  BankValidationResponse bankCode(String bankCode);

  BankValidationResponse accountNumber(String accountNumber);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `BankValidationResponse(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BankValidationResponse(...).copyWith(id: 12, name: "My name")
  /// ```
  BankValidationResponse call({
    bool isValid,
    String? accountName,
    String bankCode,
    String accountNumber,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfBankValidationResponse.copyWith(...)` or call `instanceOfBankValidationResponse.copyWith.fieldName(value)` for a single field.
class _$BankValidationResponseCWProxyImpl
    implements _$BankValidationResponseCWProxy {
  const _$BankValidationResponseCWProxyImpl(this._value);

  final BankValidationResponse _value;

  @override
  BankValidationResponse isValid(bool isValid) => call(isValid: isValid);

  @override
  BankValidationResponse accountName(String? accountName) =>
      call(accountName: accountName);

  @override
  BankValidationResponse bankCode(String bankCode) => call(bankCode: bankCode);

  @override
  BankValidationResponse accountNumber(String accountNumber) =>
      call(accountNumber: accountNumber);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `BankValidationResponse(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BankValidationResponse(...).copyWith(id: 12, name: "My name")
  /// ```
  BankValidationResponse call({
    Object? isValid = const $CopyWithPlaceholder(),
    Object? accountName = const $CopyWithPlaceholder(),
    Object? bankCode = const $CopyWithPlaceholder(),
    Object? accountNumber = const $CopyWithPlaceholder(),
  }) {
    return BankValidationResponse(
      isValid: isValid == const $CopyWithPlaceholder() || isValid == null
          ? _value.isValid
          // ignore: cast_nullable_to_non_nullable
          : isValid as bool,
      accountName: accountName == const $CopyWithPlaceholder()
          ? _value.accountName
          // ignore: cast_nullable_to_non_nullable
          : accountName as String?,
      bankCode: bankCode == const $CopyWithPlaceholder() || bankCode == null
          ? _value.bankCode
          // ignore: cast_nullable_to_non_nullable
          : bankCode as String,
      accountNumber:
          accountNumber == const $CopyWithPlaceholder() || accountNumber == null
          ? _value.accountNumber
          // ignore: cast_nullable_to_non_nullable
          : accountNumber as String,
    );
  }
}

extension $BankValidationResponseCopyWith on BankValidationResponse {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfBankValidationResponse.copyWith(...)` or `instanceOfBankValidationResponse.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BankValidationResponseCWProxy get copyWith =>
      _$BankValidationResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BankValidationResponse _$BankValidationResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('BankValidationResponse', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const ['isValid', 'accountName', 'bankCode', 'accountNumber'],
  );
  final val = BankValidationResponse(
    isValid: $checkedConvert('isValid', (v) => v as bool),
    accountName: $checkedConvert('accountName', (v) => v as String?),
    bankCode: $checkedConvert('bankCode', (v) => v as String),
    accountNumber: $checkedConvert('accountNumber', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$BankValidationResponseToJson(
  BankValidationResponse instance,
) => <String, dynamic>{
  'isValid': instance.isValid,
  'accountName': instance.accountName,
  'bankCode': instance.bankCode,
  'accountNumber': instance.accountNumber,
};
