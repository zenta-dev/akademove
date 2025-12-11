//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/transaction_status.dart';
import 'package:api_client/src/model/payout_status.dart';
import 'package:api_client/src/model/bank_provider.dart';
import 'package:api_client/src/model/payment_provider.dart';
import 'package:api_client/src/model/payment_method.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'withdraw_response.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class WithdrawResponse {
  /// Returns a new [WithdrawResponse] instance.
  const WithdrawResponse({
    required this.id,
    required this.transactionId,
    required this.provider,
    required this.method,
    required this.amount,
    required this.status,
    required this.bankProvider,
     this.payoutReferenceNo,
     this.payoutStatus,
     this.metadata,
    required this.createdAt,
    required this.updatedAt,
  });
  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;
  
  @JsonKey(name: r'transactionId', required: true, includeIfNull: false)
  final String transactionId;
  
  @JsonKey(name: r'provider', required: true, includeIfNull: false)
  final PaymentProvider provider;
  
  @JsonKey(name: r'method', required: true, includeIfNull: false)
  final PaymentMethod method;
  
  @JsonKey(name: r'amount', required: true, includeIfNull: false)
  final num amount;
  
  @JsonKey(name: r'status', required: true, includeIfNull: false)
  final TransactionStatus status;
  
  @JsonKey(name: r'bankProvider', required: true, includeIfNull: false)
  final BankProvider bankProvider;
  
  @JsonKey(name: r'payoutReferenceNo', required: false, includeIfNull: false)
  final String? payoutReferenceNo;
  
  @JsonKey(name: r'payoutStatus', required: false, includeIfNull: false)
  final PayoutStatus? payoutStatus;
  
  @JsonKey(name: r'metadata', required: false, includeIfNull: false)
  final Map<String, Object>? metadata;
  
  @JsonKey(name: r'createdAt', required: true, includeIfNull: true)
  final DateTime? createdAt;
  
  @JsonKey(name: r'updatedAt', required: true, includeIfNull: true)
  final DateTime? updatedAt;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is WithdrawResponse &&
    other.id == id &&
    other.transactionId == transactionId &&
    other.provider == provider &&
    other.method == method &&
    other.amount == amount &&
    other.status == status &&
    other.bankProvider == bankProvider &&
    other.payoutReferenceNo == payoutReferenceNo &&
    other.payoutStatus == payoutStatus &&
    other.metadata == metadata &&
    other.createdAt == createdAt &&
    other.updatedAt == updatedAt;

  @override
  int get hashCode =>
      id.hashCode +
      transactionId.hashCode +
      provider.hashCode +
      method.hashCode +
      amount.hashCode +
      status.hashCode +
      bankProvider.hashCode +
      payoutReferenceNo.hashCode +
      payoutStatus.hashCode +
      metadata.hashCode +
      (createdAt == null ? 0 : createdAt.hashCode) +
      (updatedAt == null ? 0 : updatedAt.hashCode);

  factory WithdrawResponse.fromJson(Map<String, dynamic> json) => _$WithdrawResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WithdrawResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

