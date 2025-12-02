// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'withdraw_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$WithdrawRequestCWProxy {
  WithdrawRequest amount(num amount);

  WithdrawRequest bankProvider(BankProvider bankProvider);

  WithdrawRequest accountNumber(String accountNumber);

  WithdrawRequest accountName(String? accountName);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `WithdrawRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// WithdrawRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  WithdrawRequest call({num amount, BankProvider bankProvider, String accountNumber, String? accountName});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfWithdrawRequest.copyWith(...)` or call `instanceOfWithdrawRequest.copyWith.fieldName(value)` for a single field.
class _$WithdrawRequestCWProxyImpl implements _$WithdrawRequestCWProxy {
  const _$WithdrawRequestCWProxyImpl(this._value);

  final WithdrawRequest _value;

  @override
  WithdrawRequest amount(num amount) => call(amount: amount);

  @override
  WithdrawRequest bankProvider(BankProvider bankProvider) => call(bankProvider: bankProvider);

  @override
  WithdrawRequest accountNumber(String accountNumber) => call(accountNumber: accountNumber);

  @override
  WithdrawRequest accountName(String? accountName) => call(accountName: accountName);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `WithdrawRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// WithdrawRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  WithdrawRequest call({
    Object? amount = const $CopyWithPlaceholder(),
    Object? bankProvider = const $CopyWithPlaceholder(),
    Object? accountNumber = const $CopyWithPlaceholder(),
    Object? accountName = const $CopyWithPlaceholder(),
  }) {
    return WithdrawRequest(
      amount: amount == const $CopyWithPlaceholder() || amount == null
          ? _value.amount
          // ignore: cast_nullable_to_non_nullable
          : amount as num,
      bankProvider: bankProvider == const $CopyWithPlaceholder() || bankProvider == null
          ? _value.bankProvider
          // ignore: cast_nullable_to_non_nullable
          : bankProvider as BankProvider,
      accountNumber: accountNumber == const $CopyWithPlaceholder() || accountNumber == null
          ? _value.accountNumber
          // ignore: cast_nullable_to_non_nullable
          : accountNumber as String,
      accountName: accountName == const $CopyWithPlaceholder()
          ? _value.accountName
          // ignore: cast_nullable_to_non_nullable
          : accountName as String?,
    );
  }
}

extension $WithdrawRequestCopyWith on WithdrawRequest {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfWithdrawRequest.copyWith(...)` or `instanceOfWithdrawRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$WithdrawRequestCWProxy get copyWith => _$WithdrawRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WithdrawRequest _$WithdrawRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate('WithdrawRequest', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['amount', 'bankProvider', 'accountNumber']);
      final val = WithdrawRequest(
        amount: $checkedConvert('amount', (v) => v as num),
        bankProvider: $checkedConvert('bankProvider', (v) => $enumDecode(_$BankProviderEnumMap, v)),
        accountNumber: $checkedConvert('accountNumber', (v) => v as String),
        accountName: $checkedConvert('accountName', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$WithdrawRequestToJson(WithdrawRequest instance) => <String, dynamic>{
  'amount': instance.amount,
  'bankProvider': _$BankProviderEnumMap[instance.bankProvider]!,
  'accountNumber': instance.accountNumber,
  'accountName': ?instance.accountName,
};

const _$BankProviderEnumMap = {
  BankProvider.BCA: 'BCA',
  BankProvider.BNI: 'BNI',
  BankProvider.BRI: 'BRI',
  BankProvider.MANDIRI: 'MANDIRI',
  BankProvider.PERMATA: 'PERMATA',
};
