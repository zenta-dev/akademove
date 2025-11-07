//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/currency.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'update_wallet.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UpdateWallet {
  /// Returns a new [UpdateWallet] instance.
  const UpdateWallet({this.userId, this.balance, this.currency, this.isActive});

  @JsonKey(name: r'userId', required: false, includeIfNull: false)
  final String? userId;

  @JsonKey(name: r'balance', required: false, includeIfNull: false)
  final num? balance;

  @JsonKey(name: r'currency', required: false, includeIfNull: false)
  final Currency? currency;

  @JsonKey(name: r'isActive', required: false, includeIfNull: false)
  final bool? isActive;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UpdateWallet &&
          other.userId == userId &&
          other.balance == balance &&
          other.currency == currency &&
          other.isActive == isActive;

  @override
  int get hashCode =>
      userId.hashCode +
      balance.hashCode +
      currency.hashCode +
      isActive.hashCode;

  factory UpdateWallet.fromJson(Map<String, dynamic> json) =>
      _$UpdateWalletFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateWalletToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
