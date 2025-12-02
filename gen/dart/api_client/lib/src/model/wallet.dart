//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/currency.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'wallet.g.dart';

@CopyWith()
@JsonSerializable(checked: true, createToJson: true, disallowUnrecognizedKeys: false, explicitToJson: true)
class Wallet {
  /// Returns a new [Wallet] instance.
  const Wallet({
    required this.id,
    required this.userId,
    required this.balance,
    required this.currency,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'userId', required: true, includeIfNull: false)
  final String userId;

  @JsonKey(name: r'balance', required: true, includeIfNull: false)
  final num balance;

  @JsonKey(name: r'currency', required: true, includeIfNull: false)
  final Currency currency;

  @JsonKey(name: r'isActive', required: true, includeIfNull: false)
  final bool isActive;

  @JsonKey(name: r'createdAt', required: true, includeIfNull: false)
  final DateTime createdAt;

  @JsonKey(name: r'updatedAt', required: true, includeIfNull: false)
  final DateTime updatedAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Wallet &&
          other.id == id &&
          other.userId == userId &&
          other.balance == balance &&
          other.currency == currency &&
          other.isActive == isActive &&
          other.createdAt == createdAt &&
          other.updatedAt == updatedAt;

  @override
  int get hashCode =>
      id.hashCode +
      userId.hashCode +
      balance.hashCode +
      currency.hashCode +
      isActive.hashCode +
      createdAt.hashCode +
      updatedAt.hashCode;

  factory Wallet.fromJson(Map<String, dynamic> json) => _$WalletFromJson(json);

  Map<String, dynamic> toJson() => _$WalletToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
