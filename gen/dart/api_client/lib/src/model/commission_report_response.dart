//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/chart_data_point.dart';
import 'package:api_client/src/model/commission_report_period.dart';
import 'package:api_client/src/model/commission_transaction.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'commission_report_response.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CommissionReportResponse {
  /// Returns a new [CommissionReportResponse] instance.
  const CommissionReportResponse({
    required this.currentBalance,
    required this.incomingBalance,
    required this.outgoingBalance,
    required this.totalEarnings,
    required this.totalCommission,
    required this.netIncome,
    required this.commissionRate,
    required this.chartData,
    required this.transactions,
    required this.period,
  });
  @JsonKey(name: r'currentBalance', required: true, includeIfNull: false)
  final num currentBalance;

  @JsonKey(name: r'incomingBalance', required: true, includeIfNull: false)
  final num incomingBalance;

  @JsonKey(name: r'outgoingBalance', required: true, includeIfNull: false)
  final num outgoingBalance;

  @JsonKey(name: r'totalEarnings', required: true, includeIfNull: false)
  final num totalEarnings;

  @JsonKey(name: r'totalCommission', required: true, includeIfNull: false)
  final num totalCommission;

  @JsonKey(name: r'netIncome', required: true, includeIfNull: false)
  final num netIncome;

  @JsonKey(name: r'commissionRate', required: true, includeIfNull: false)
  final num commissionRate;

  @JsonKey(name: r'chartData', required: true, includeIfNull: false)
  final List<ChartDataPoint> chartData;

  @JsonKey(name: r'transactions', required: true, includeIfNull: false)
  final List<CommissionTransaction> transactions;

  @JsonKey(name: r'period', required: true, includeIfNull: false)
  final CommissionReportPeriod period;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CommissionReportResponse &&
          other.currentBalance == currentBalance &&
          other.incomingBalance == incomingBalance &&
          other.outgoingBalance == outgoingBalance &&
          other.totalEarnings == totalEarnings &&
          other.totalCommission == totalCommission &&
          other.netIncome == netIncome &&
          other.commissionRate == commissionRate &&
          other.chartData == chartData &&
          other.transactions == transactions &&
          other.period == period;

  @override
  int get hashCode =>
      currentBalance.hashCode +
      incomingBalance.hashCode +
      outgoingBalance.hashCode +
      totalEarnings.hashCode +
      totalCommission.hashCode +
      netIncome.hashCode +
      commissionRate.hashCode +
      chartData.hashCode +
      transactions.hashCode +
      period.hashCode;

  factory CommissionReportResponse.fromJson(Map<String, dynamic> json) =>
      _$CommissionReportResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CommissionReportResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
