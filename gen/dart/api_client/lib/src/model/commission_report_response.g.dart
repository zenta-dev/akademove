// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commission_report_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CommissionReportResponseCWProxy {
  CommissionReportResponse currentBalance(num currentBalance);

  CommissionReportResponse incomingBalance(num incomingBalance);

  CommissionReportResponse outgoingBalance(num outgoingBalance);

  CommissionReportResponse totalEarnings(num totalEarnings);

  CommissionReportResponse totalCommission(num totalCommission);

  CommissionReportResponse netIncome(num netIncome);

  CommissionReportResponse commissionRate(num commissionRate);

  CommissionReportResponse chartData(List<ChartDataPoint> chartData);

  CommissionReportResponse transactions(
    List<CommissionTransaction> transactions,
  );

  CommissionReportResponse period(CommissionReportPeriod period);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `CommissionReportResponse(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CommissionReportResponse(...).copyWith(id: 12, name: "My name")
  /// ```
  CommissionReportResponse call({
    num currentBalance,
    num incomingBalance,
    num outgoingBalance,
    num totalEarnings,
    num totalCommission,
    num netIncome,
    num commissionRate,
    List<ChartDataPoint> chartData,
    List<CommissionTransaction> transactions,
    CommissionReportPeriod period,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfCommissionReportResponse.copyWith(...)` or call `instanceOfCommissionReportResponse.copyWith.fieldName(value)` for a single field.
class _$CommissionReportResponseCWProxyImpl
    implements _$CommissionReportResponseCWProxy {
  const _$CommissionReportResponseCWProxyImpl(this._value);

  final CommissionReportResponse _value;

  @override
  CommissionReportResponse currentBalance(num currentBalance) =>
      call(currentBalance: currentBalance);

  @override
  CommissionReportResponse incomingBalance(num incomingBalance) =>
      call(incomingBalance: incomingBalance);

  @override
  CommissionReportResponse outgoingBalance(num outgoingBalance) =>
      call(outgoingBalance: outgoingBalance);

  @override
  CommissionReportResponse totalEarnings(num totalEarnings) =>
      call(totalEarnings: totalEarnings);

  @override
  CommissionReportResponse totalCommission(num totalCommission) =>
      call(totalCommission: totalCommission);

  @override
  CommissionReportResponse netIncome(num netIncome) =>
      call(netIncome: netIncome);

  @override
  CommissionReportResponse commissionRate(num commissionRate) =>
      call(commissionRate: commissionRate);

  @override
  CommissionReportResponse chartData(List<ChartDataPoint> chartData) =>
      call(chartData: chartData);

  @override
  CommissionReportResponse transactions(
    List<CommissionTransaction> transactions,
  ) => call(transactions: transactions);

  @override
  CommissionReportResponse period(CommissionReportPeriod period) =>
      call(period: period);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `CommissionReportResponse(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CommissionReportResponse(...).copyWith(id: 12, name: "My name")
  /// ```
  CommissionReportResponse call({
    Object? currentBalance = const $CopyWithPlaceholder(),
    Object? incomingBalance = const $CopyWithPlaceholder(),
    Object? outgoingBalance = const $CopyWithPlaceholder(),
    Object? totalEarnings = const $CopyWithPlaceholder(),
    Object? totalCommission = const $CopyWithPlaceholder(),
    Object? netIncome = const $CopyWithPlaceholder(),
    Object? commissionRate = const $CopyWithPlaceholder(),
    Object? chartData = const $CopyWithPlaceholder(),
    Object? transactions = const $CopyWithPlaceholder(),
    Object? period = const $CopyWithPlaceholder(),
  }) {
    return CommissionReportResponse(
      currentBalance:
          currentBalance == const $CopyWithPlaceholder() ||
              currentBalance == null
          ? _value.currentBalance
          // ignore: cast_nullable_to_non_nullable
          : currentBalance as num,
      incomingBalance:
          incomingBalance == const $CopyWithPlaceholder() ||
              incomingBalance == null
          ? _value.incomingBalance
          // ignore: cast_nullable_to_non_nullable
          : incomingBalance as num,
      outgoingBalance:
          outgoingBalance == const $CopyWithPlaceholder() ||
              outgoingBalance == null
          ? _value.outgoingBalance
          // ignore: cast_nullable_to_non_nullable
          : outgoingBalance as num,
      totalEarnings:
          totalEarnings == const $CopyWithPlaceholder() || totalEarnings == null
          ? _value.totalEarnings
          // ignore: cast_nullable_to_non_nullable
          : totalEarnings as num,
      totalCommission:
          totalCommission == const $CopyWithPlaceholder() ||
              totalCommission == null
          ? _value.totalCommission
          // ignore: cast_nullable_to_non_nullable
          : totalCommission as num,
      netIncome: netIncome == const $CopyWithPlaceholder() || netIncome == null
          ? _value.netIncome
          // ignore: cast_nullable_to_non_nullable
          : netIncome as num,
      commissionRate:
          commissionRate == const $CopyWithPlaceholder() ||
              commissionRate == null
          ? _value.commissionRate
          // ignore: cast_nullable_to_non_nullable
          : commissionRate as num,
      chartData: chartData == const $CopyWithPlaceholder() || chartData == null
          ? _value.chartData
          // ignore: cast_nullable_to_non_nullable
          : chartData as List<ChartDataPoint>,
      transactions:
          transactions == const $CopyWithPlaceholder() || transactions == null
          ? _value.transactions
          // ignore: cast_nullable_to_non_nullable
          : transactions as List<CommissionTransaction>,
      period: period == const $CopyWithPlaceholder() || period == null
          ? _value.period
          // ignore: cast_nullable_to_non_nullable
          : period as CommissionReportPeriod,
    );
  }
}

extension $CommissionReportResponseCopyWith on CommissionReportResponse {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfCommissionReportResponse.copyWith(...)` or `instanceOfCommissionReportResponse.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CommissionReportResponseCWProxy get copyWith =>
      _$CommissionReportResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommissionReportResponse _$CommissionReportResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('CommissionReportResponse', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const [
      'currentBalance',
      'incomingBalance',
      'outgoingBalance',
      'totalEarnings',
      'totalCommission',
      'netIncome',
      'commissionRate',
      'chartData',
      'transactions',
      'period',
    ],
  );
  final val = CommissionReportResponse(
    currentBalance: $checkedConvert('currentBalance', (v) => v as num),
    incomingBalance: $checkedConvert('incomingBalance', (v) => v as num),
    outgoingBalance: $checkedConvert('outgoingBalance', (v) => v as num),
    totalEarnings: $checkedConvert('totalEarnings', (v) => v as num),
    totalCommission: $checkedConvert('totalCommission', (v) => v as num),
    netIncome: $checkedConvert('netIncome', (v) => v as num),
    commissionRate: $checkedConvert('commissionRate', (v) => v as num),
    chartData: $checkedConvert(
      'chartData',
      (v) => (v as List<dynamic>)
          .map((e) => ChartDataPoint.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
    transactions: $checkedConvert(
      'transactions',
      (v) => (v as List<dynamic>)
          .map((e) => CommissionTransaction.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
    period: $checkedConvert(
      'period',
      (v) => $enumDecode(_$CommissionReportPeriodEnumMap, v),
    ),
  );
  return val;
});

Map<String, dynamic> _$CommissionReportResponseToJson(
  CommissionReportResponse instance,
) => <String, dynamic>{
  'currentBalance': instance.currentBalance,
  'incomingBalance': instance.incomingBalance,
  'outgoingBalance': instance.outgoingBalance,
  'totalEarnings': instance.totalEarnings,
  'totalCommission': instance.totalCommission,
  'netIncome': instance.netIncome,
  'commissionRate': instance.commissionRate,
  'chartData': instance.chartData.map((e) => e.toJson()).toList(),
  'transactions': instance.transactions.map((e) => e.toJson()).toList(),
  'period': _$CommissionReportPeriodEnumMap[instance.period]!,
};

const _$CommissionReportPeriodEnumMap = {
  CommissionReportPeriod.daily: 'daily',
  CommissionReportPeriod.weekly: 'weekly',
  CommissionReportPeriod.monthly: 'monthly',
};
