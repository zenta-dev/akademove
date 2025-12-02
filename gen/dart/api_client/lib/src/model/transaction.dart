//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/transaction_status.dart';
import 'package:api_client/src/model/transaction_type.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'transaction.g.dart';

@CopyWith()
@JsonSerializable(checked: true, createToJson: true, disallowUnrecognizedKeys: false, explicitToJson: true)
class Transaction {
  /// Returns a new [Transaction] instance.
  const Transaction({
    required this.id,
    required this.walletId,
    required this.type,
    required this.amount,
    this.balanceBefore,
    this.balanceAfter,
    required this.status,
    this.description,
    this.referenceId,
    this.metadata,
    required this.createdAt,
    required this.updatedAt,
  });

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'walletId', required: true, includeIfNull: false)
  final String walletId;

  @JsonKey(name: r'type', required: true, includeIfNull: false)
  final TransactionType type;

  @JsonKey(name: r'amount', required: true, includeIfNull: false)
  final num amount;

  @JsonKey(name: r'balanceBefore', required: false, includeIfNull: false)
  final num? balanceBefore;

  @JsonKey(name: r'balanceAfter', required: false, includeIfNull: false)
  final num? balanceAfter;

  @JsonKey(name: r'status', required: true, includeIfNull: false)
  final TransactionStatus status;

  @JsonKey(name: r'description', required: false, includeIfNull: false)
  final String? description;

  @JsonKey(name: r'referenceId', required: false, includeIfNull: false)
  final String? referenceId;

  @JsonKey(name: r'metadata', required: false, includeIfNull: false)
  final Object? metadata;

  @JsonKey(name: r'createdAt', required: true, includeIfNull: false)
  final DateTime createdAt;

  @JsonKey(name: r'updatedAt', required: true, includeIfNull: false)
  final DateTime updatedAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Transaction &&
          other.id == id &&
          other.walletId == walletId &&
          other.type == type &&
          other.amount == amount &&
          other.balanceBefore == balanceBefore &&
          other.balanceAfter == balanceAfter &&
          other.status == status &&
          other.description == description &&
          other.referenceId == referenceId &&
          other.metadata == metadata &&
          other.createdAt == createdAt &&
          other.updatedAt == updatedAt;

  @override
  int get hashCode =>
      id.hashCode +
      walletId.hashCode +
      type.hashCode +
      amount.hashCode +
      balanceBefore.hashCode +
      balanceAfter.hashCode +
      status.hashCode +
      description.hashCode +
      referenceId.hashCode +
      (metadata == null ? 0 : metadata.hashCode) +
      createdAt.hashCode +
      updatedAt.hashCode;

  factory Transaction.fromJson(Map<String, dynamic> json) => _$TransactionFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
