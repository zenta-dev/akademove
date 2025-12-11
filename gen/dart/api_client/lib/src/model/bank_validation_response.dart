//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'bank_validation_response.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BankValidationResponse {
  /// Returns a new [BankValidationResponse] instance.
  const BankValidationResponse({
    required this.isValid,
    required this.accountName,
    required this.bankCode,
    required this.accountNumber,
  });
  @JsonKey(name: r'isValid', required: true, includeIfNull: false)
  final bool isValid;
  
  @JsonKey(name: r'accountName', required: true, includeIfNull: true)
  final String? accountName;
  
  @JsonKey(name: r'bankCode', required: true, includeIfNull: false)
  final String bankCode;
  
  @JsonKey(name: r'accountNumber', required: true, includeIfNull: false)
  final String accountNumber;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is BankValidationResponse &&
    other.isValid == isValid &&
    other.accountName == accountName &&
    other.bankCode == bankCode &&
    other.accountNumber == accountNumber;

  @override
  int get hashCode =>
      isValid.hashCode +
      (accountName == null ? 0 : accountName.hashCode) +
      bankCode.hashCode +
      accountNumber.hashCode;

  factory BankValidationResponse.fromJson(Map<String, dynamic> json) => _$BankValidationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BankValidationResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

