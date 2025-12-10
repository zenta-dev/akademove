//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/transaction_status.dart';
import 'package:api_client/src/model/transaction_type.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'update_transaction.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UpdateTransaction {
  /// Returns a new [UpdateTransaction] instance.
  const UpdateTransaction({
     this.walletId,
     this.type,
     this.amount,
     this.balanceBefore,
     this.balanceAfter,
     this.status,
     this.description,
     this.referenceId,
     this.metadata,
  });
  @JsonKey(name: r'walletId', required: false, includeIfNull: false)
  final String? walletId;
  
  @JsonKey(name: r'type', required: false, includeIfNull: false)
  final TransactionType? type;
  
  @JsonKey(name: r'amount', required: false, includeIfNull: false)
  final num? amount;
  
  @JsonKey(name: r'balanceBefore', required: false, includeIfNull: false)
  final num? balanceBefore;
  
  @JsonKey(name: r'balanceAfter', required: false, includeIfNull: false)
  final num? balanceAfter;
  
  @JsonKey(name: r'status', required: false, includeIfNull: false)
  final TransactionStatus? status;
  
  @JsonKey(name: r'description', required: false, includeIfNull: false)
  final String? description;
  
  @JsonKey(name: r'referenceId', required: false, includeIfNull: false)
  final String? referenceId;
  
  @JsonKey(name: r'metadata', required: false, includeIfNull: false)
  final Object? metadata;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is UpdateTransaction &&
    other.walletId == walletId &&
    other.type == type &&
    other.amount == amount &&
    other.balanceBefore == balanceBefore &&
    other.balanceAfter == balanceAfter &&
    other.status == status &&
    other.description == description &&
    other.referenceId == referenceId &&
    other.metadata == metadata;

  @override
  int get hashCode =>
      walletId.hashCode +
      type.hashCode +
      amount.hashCode +
      balanceBefore.hashCode +
      balanceAfter.hashCode +
      status.hashCode +
      (description == null ? 0 : description.hashCode) +
      (referenceId == null ? 0 : referenceId.hashCode) +
      (metadata == null ? 0 : metadata.hashCode);

  factory UpdateTransaction.fromJson(Map<String, dynamic> json) => _$UpdateTransactionFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateTransactionToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

