// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_bank_account.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SavedBankAccountCWProxy {
  SavedBankAccount hasSavedBank(bool hasSavedBank);

  SavedBankAccount bankProvider(BankProvider? bankProvider);

  SavedBankAccount accountNumber(String? accountNumber);

  SavedBankAccount accountName(String? accountName);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `SavedBankAccount(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SavedBankAccount(...).copyWith(id: 12, name: "My name")
  /// ```
  SavedBankAccount call({
    bool hasSavedBank,
    BankProvider? bankProvider,
    String? accountNumber,
    String? accountName,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfSavedBankAccount.copyWith(...)` or call `instanceOfSavedBankAccount.copyWith.fieldName(value)` for a single field.
class _$SavedBankAccountCWProxyImpl implements _$SavedBankAccountCWProxy {
  const _$SavedBankAccountCWProxyImpl(this._value);

  final SavedBankAccount _value;

  @override
  SavedBankAccount hasSavedBank(bool hasSavedBank) =>
      call(hasSavedBank: hasSavedBank);

  @override
  SavedBankAccount bankProvider(BankProvider? bankProvider) =>
      call(bankProvider: bankProvider);

  @override
  SavedBankAccount accountNumber(String? accountNumber) =>
      call(accountNumber: accountNumber);

  @override
  SavedBankAccount accountName(String? accountName) =>
      call(accountName: accountName);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `SavedBankAccount(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SavedBankAccount(...).copyWith(id: 12, name: "My name")
  /// ```
  SavedBankAccount call({
    Object? hasSavedBank = const $CopyWithPlaceholder(),
    Object? bankProvider = const $CopyWithPlaceholder(),
    Object? accountNumber = const $CopyWithPlaceholder(),
    Object? accountName = const $CopyWithPlaceholder(),
  }) {
    return SavedBankAccount(
      hasSavedBank:
          hasSavedBank == const $CopyWithPlaceholder() || hasSavedBank == null
          ? _value.hasSavedBank
          // ignore: cast_nullable_to_non_nullable
          : hasSavedBank as bool,
      bankProvider: bankProvider == const $CopyWithPlaceholder()
          ? _value.bankProvider
          // ignore: cast_nullable_to_non_nullable
          : bankProvider as BankProvider?,
      accountNumber: accountNumber == const $CopyWithPlaceholder()
          ? _value.accountNumber
          // ignore: cast_nullable_to_non_nullable
          : accountNumber as String?,
      accountName: accountName == const $CopyWithPlaceholder()
          ? _value.accountName
          // ignore: cast_nullable_to_non_nullable
          : accountName as String?,
    );
  }
}

extension $SavedBankAccountCopyWith on SavedBankAccount {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfSavedBankAccount.copyWith(...)` or `instanceOfSavedBankAccount.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SavedBankAccountCWProxy get copyWith => _$SavedBankAccountCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SavedBankAccount _$SavedBankAccountFromJson(Map<String, dynamic> json) =>
    $checkedCreate('SavedBankAccount', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['hasSavedBank']);
      final val = SavedBankAccount(
        hasSavedBank: $checkedConvert('hasSavedBank', (v) => v as bool),
        bankProvider: $checkedConvert(
          'bankProvider',
          (v) => $enumDecodeNullable(_$BankProviderEnumMap, v),
        ),
        accountNumber: $checkedConvert('accountNumber', (v) => v as String?),
        accountName: $checkedConvert('accountName', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$SavedBankAccountToJson(SavedBankAccount instance) =>
    <String, dynamic>{
      'hasSavedBank': instance.hasSavedBank,
      'bankProvider': ?_$BankProviderEnumMap[instance.bankProvider],
      'accountNumber': ?instance.accountNumber,
      'accountName': ?instance.accountName,
    };

const _$BankProviderEnumMap = {
  BankProvider.BCA: 'BCA',
  BankProvider.BNI: 'BNI',
  BankProvider.BRI: 'BRI',
  BankProvider.MANDIRI: 'MANDIRI',
  BankProvider.PERMATA: 'PERMATA',
};
