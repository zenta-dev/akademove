//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'wallet_monthly_summary_query.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class WalletMonthlySummaryQuery {
  /// Returns a new [WalletMonthlySummaryQuery] instance.
  const WalletMonthlySummaryQuery({
    required this.year,
    required this.month,
  });

  @JsonKey(name: r'year', required: true, includeIfNull: false)
  final num year;
  
  @JsonKey(name: r'month', required: true, includeIfNull: false)
  final num month;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is WalletMonthlySummaryQuery &&
    other.year == year &&
    other.month == month;

  @override
  int get hashCode =>
      year.hashCode +
      month.hashCode;

  factory WalletMonthlySummaryQuery.fromJson(Map<String, dynamic> json) => _$WalletMonthlySummaryQueryFromJson(json);

  Map<String, dynamic> toJson() => _$WalletMonthlySummaryQueryToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

