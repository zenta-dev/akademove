//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/bank_provider.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'saved_bank_account.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class SavedBankAccount {
  /// Returns a new [SavedBankAccount] instance.
  const SavedBankAccount({
    required this.hasSavedBank,
     this.bankProvider,
     this.accountNumber,
     this.accountName,
  });
  @JsonKey(name: r'hasSavedBank', required: true, includeIfNull: false)
  final bool hasSavedBank;
  
  @JsonKey(name: r'bankProvider', required: false, includeIfNull: false)
  final BankProvider? bankProvider;
  
  @JsonKey(name: r'accountNumber', required: false, includeIfNull: false)
  final String? accountNumber;
  
  @JsonKey(name: r'accountName', required: false, includeIfNull: false)
  final String? accountName;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is SavedBankAccount &&
    other.hasSavedBank == hasSavedBank &&
    other.bankProvider == bankProvider &&
    other.accountNumber == accountNumber &&
    other.accountName == accountName;

  @override
  int get hashCode =>
      hasSavedBank.hashCode +
      bankProvider.hashCode +
      accountNumber.hashCode +
      accountName.hashCode;

  factory SavedBankAccount.fromJson(Map<String, dynamic> json) => _$SavedBankAccountFromJson(json);

  Map<String, dynamic> toJson() => _$SavedBankAccountToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

