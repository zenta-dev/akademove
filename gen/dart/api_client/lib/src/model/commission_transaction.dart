//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'commission_transaction.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CommissionTransaction {
  /// Returns a new [CommissionTransaction] instance.
  const CommissionTransaction({
    required this.id,
    required this.type,
    required this.amount,
    this.description,
    this.orderType,
    required this.createdAt,
  });
  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'type', required: true, includeIfNull: false)
  final CommissionTransactionTypeEnum type;

  @JsonKey(name: r'amount', required: true, includeIfNull: false)
  final num amount;

  @JsonKey(name: r'description', required: false, includeIfNull: false)
  final String? description;

  @JsonKey(name: r'orderType', required: false, includeIfNull: false)
  final String? orderType;

  @JsonKey(name: r'createdAt', required: true, includeIfNull: false)
  final DateTime createdAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CommissionTransaction &&
          other.id == id &&
          other.type == type &&
          other.amount == amount &&
          other.description == description &&
          other.orderType == orderType &&
          other.createdAt == createdAt;

  @override
  int get hashCode =>
      id.hashCode +
      type.hashCode +
      amount.hashCode +
      description.hashCode +
      orderType.hashCode +
      createdAt.hashCode;

  factory CommissionTransaction.fromJson(Map<String, dynamic> json) =>
      _$CommissionTransactionFromJson(json);

  Map<String, dynamic> toJson() => _$CommissionTransactionToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum CommissionTransactionTypeEnum {
  @JsonValue(r'EARNING')
  EARNING(r'EARNING'),
  @JsonValue(r'COMMISSION')
  COMMISSION(r'COMMISSION');

  const CommissionTransactionTypeEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
