// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_monthly_summary_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$WalletMonthlySummaryResponseCWProxy {
  WalletMonthlySummaryResponse month(String month);

  WalletMonthlySummaryResponse totalIncome(num totalIncome);

  WalletMonthlySummaryResponse totalExpense(num totalExpense);

  WalletMonthlySummaryResponse net(num net);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `WalletMonthlySummaryResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// WalletMonthlySummaryResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  WalletMonthlySummaryResponse call({
    String month,
    num totalIncome,
    num totalExpense,
    num net,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfWalletMonthlySummaryResponse.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfWalletMonthlySummaryResponse.copyWith.fieldName(...)`
class _$WalletMonthlySummaryResponseCWProxyImpl
    implements _$WalletMonthlySummaryResponseCWProxy {
  const _$WalletMonthlySummaryResponseCWProxyImpl(this._value);

  final WalletMonthlySummaryResponse _value;

  @override
  WalletMonthlySummaryResponse month(String month) => this(month: month);

  @override
  WalletMonthlySummaryResponse totalIncome(num totalIncome) =>
      this(totalIncome: totalIncome);

  @override
  WalletMonthlySummaryResponse totalExpense(num totalExpense) =>
      this(totalExpense: totalExpense);

  @override
  WalletMonthlySummaryResponse net(num net) => this(net: net);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `WalletMonthlySummaryResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// WalletMonthlySummaryResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  WalletMonthlySummaryResponse call({
    Object? month = const $CopyWithPlaceholder(),
    Object? totalIncome = const $CopyWithPlaceholder(),
    Object? totalExpense = const $CopyWithPlaceholder(),
    Object? net = const $CopyWithPlaceholder(),
  }) {
    return WalletMonthlySummaryResponse(
      month: month == const $CopyWithPlaceholder()
          ? _value.month
          // ignore: cast_nullable_to_non_nullable
          : month as String,
      totalIncome: totalIncome == const $CopyWithPlaceholder()
          ? _value.totalIncome
          // ignore: cast_nullable_to_non_nullable
          : totalIncome as num,
      totalExpense: totalExpense == const $CopyWithPlaceholder()
          ? _value.totalExpense
          // ignore: cast_nullable_to_non_nullable
          : totalExpense as num,
      net: net == const $CopyWithPlaceholder()
          ? _value.net
          // ignore: cast_nullable_to_non_nullable
          : net as num,
    );
  }
}

extension $WalletMonthlySummaryResponseCopyWith
    on WalletMonthlySummaryResponse {
  /// Returns a callable class that can be used as follows: `instanceOfWalletMonthlySummaryResponse.copyWith(...)` or like so:`instanceOfWalletMonthlySummaryResponse.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$WalletMonthlySummaryResponseCWProxy get copyWith =>
      _$WalletMonthlySummaryResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletMonthlySummaryResponse _$WalletMonthlySummaryResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('WalletMonthlySummaryResponse', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const ['month', 'totalIncome', 'totalExpense', 'net'],
  );
  final val = WalletMonthlySummaryResponse(
    month: $checkedConvert('month', (v) => v as String),
    totalIncome: $checkedConvert('totalIncome', (v) => v as num),
    totalExpense: $checkedConvert('totalExpense', (v) => v as num),
    net: $checkedConvert('net', (v) => v as num),
  );
  return val;
});

Map<String, dynamic> _$WalletMonthlySummaryResponseToJson(
  WalletMonthlySummaryResponse instance,
) => <String, dynamic>{
  'month': instance.month,
  'totalIncome': instance.totalIncome,
  'totalExpense': instance.totalExpense,
  'net': instance.net,
};
