//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'wallet_monthly_summary_response.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class WalletMonthlySummaryResponse {
  /// Returns a new [WalletMonthlySummaryResponse] instance.
  const WalletMonthlySummaryResponse({
    required this.month,
    required this.totalIncome,
    required this.totalExpense,
    required this.net,
  });

      /// YYYY-MM
  @JsonKey(name: r'month', required: true, includeIfNull: false)
  final String month;
  
  @JsonKey(name: r'totalIncome', required: true, includeIfNull: false)
  final num totalIncome;
  
  @JsonKey(name: r'totalExpense', required: true, includeIfNull: false)
  final num totalExpense;
  
  @JsonKey(name: r'net', required: true, includeIfNull: false)
  final num net;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is WalletMonthlySummaryResponse &&
    other.month == month &&
    other.totalIncome == totalIncome &&
    other.totalExpense == totalExpense &&
    other.net == net;

  @override
  int get hashCode =>
      month.hashCode +
      totalIncome.hashCode +
      totalExpense.hashCode +
      net.hashCode;

  factory WalletMonthlySummaryResponse.fromJson(Map<String, dynamic> json) => _$WalletMonthlySummaryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WalletMonthlySummaryResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

