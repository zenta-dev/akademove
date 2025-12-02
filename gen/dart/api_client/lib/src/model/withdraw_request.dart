//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/bank_provider.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'withdraw_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class WithdrawRequest {
  /// Returns a new [WithdrawRequest] instance.
  const WithdrawRequest({
    required this.amount,
    required this.bankProvider,
    required this.accountNumber,
     this.accountName,
  });

  @JsonKey(name: r'amount', required: true, includeIfNull: false)
  final num amount;
  
  @JsonKey(name: r'bankProvider', required: true, includeIfNull: false)
  final BankProvider bankProvider;
  
  @JsonKey(name: r'accountNumber', required: true, includeIfNull: false)
  final String accountNumber;
  
  @JsonKey(name: r'accountName', required: false, includeIfNull: false)
  final String? accountName;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is WithdrawRequest &&
    other.amount == amount &&
    other.bankProvider == bankProvider &&
    other.accountNumber == accountNumber &&
    other.accountName == accountName;

  @override
  int get hashCode =>
      amount.hashCode +
      bankProvider.hashCode +
      accountNumber.hashCode +
      accountName.hashCode;

  factory WithdrawRequest.fromJson(Map<String, dynamic> json) => _$WithdrawRequestFromJson(json);

  Map<String, dynamic> toJson() => _$WithdrawRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

