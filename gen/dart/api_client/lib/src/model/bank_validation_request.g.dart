// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_validation_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BankValidationRequestCWProxy {
  BankValidationRequest bankProvider(BankProvider bankProvider);

  BankValidationRequest accountNumber(String accountNumber);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `BankValidationRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BankValidationRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  BankValidationRequest call({BankProvider bankProvider, String accountNumber});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfBankValidationRequest.copyWith(...)` or call `instanceOfBankValidationRequest.copyWith.fieldName(value)` for a single field.
class _$BankValidationRequestCWProxyImpl
    implements _$BankValidationRequestCWProxy {
  const _$BankValidationRequestCWProxyImpl(this._value);

  final BankValidationRequest _value;

  @override
  BankValidationRequest bankProvider(BankProvider bankProvider) =>
      call(bankProvider: bankProvider);

  @override
  BankValidationRequest accountNumber(String accountNumber) =>
      call(accountNumber: accountNumber);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `BankValidationRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BankValidationRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  BankValidationRequest call({
    Object? bankProvider = const $CopyWithPlaceholder(),
    Object? accountNumber = const $CopyWithPlaceholder(),
  }) {
    return BankValidationRequest(
      bankProvider:
          bankProvider == const $CopyWithPlaceholder() || bankProvider == null
          ? _value.bankProvider
          // ignore: cast_nullable_to_non_nullable
          : bankProvider as BankProvider,
      accountNumber:
          accountNumber == const $CopyWithPlaceholder() || accountNumber == null
          ? _value.accountNumber
          // ignore: cast_nullable_to_non_nullable
          : accountNumber as String,
    );
  }
}

extension $BankValidationRequestCopyWith on BankValidationRequest {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfBankValidationRequest.copyWith(...)` or `instanceOfBankValidationRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BankValidationRequestCWProxy get copyWith =>
      _$BankValidationRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BankValidationRequest _$BankValidationRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('BankValidationRequest', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['bankProvider', 'accountNumber']);
  final val = BankValidationRequest(
    bankProvider: $checkedConvert(
      'bankProvider',
      (v) => $enumDecode(_$BankProviderEnumMap, v),
    ),
    accountNumber: $checkedConvert('accountNumber', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$BankValidationRequestToJson(
  BankValidationRequest instance,
) => <String, dynamic>{
  'bankProvider': _$BankProviderEnumMap[instance.bankProvider]!,
  'accountNumber': instance.accountNumber,
};

const _$BankProviderEnumMap = {
  BankProvider.BCA: 'BCA',
  BankProvider.BNI: 'BNI',
  BankProvider.BRI: 'BRI',
  BankProvider.MANDIRI: 'MANDIRI',
  BankProvider.PERMATA: 'PERMATA',
};
