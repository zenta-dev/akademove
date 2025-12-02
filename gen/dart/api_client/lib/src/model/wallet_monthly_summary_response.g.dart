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

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `WalletMonthlySummaryResponse(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// WalletMonthlySummaryResponse(...).copyWith(id: 12, name: "My name")
  /// ```
  WalletMonthlySummaryResponse call({
    String month,
    num totalIncome,
    num totalExpense,
    num net,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfWalletMonthlySummaryResponse.copyWith(...)` or call `instanceOfWalletMonthlySummaryResponse.copyWith.fieldName(value)` for a single field.
class _$WalletMonthlySummaryResponseCWProxyImpl
    implements _$WalletMonthlySummaryResponseCWProxy {
  const _$WalletMonthlySummaryResponseCWProxyImpl(this._value);

  final WalletMonthlySummaryResponse _value;

  @override
  WalletMonthlySummaryResponse month(String month) => call(month: month);

  @override
  WalletMonthlySummaryResponse totalIncome(num totalIncome) =>
      call(totalIncome: totalIncome);

  @override
  WalletMonthlySummaryResponse totalExpense(num totalExpense) =>
      call(totalExpense: totalExpense);

  @override
  WalletMonthlySummaryResponse net(num net) => call(net: net);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `WalletMonthlySummaryResponse(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// WalletMonthlySummaryResponse(...).copyWith(id: 12, name: "My name")
  /// ```
  WalletMonthlySummaryResponse call({
    Object? month = const $CopyWithPlaceholder(),
    Object? totalIncome = const $CopyWithPlaceholder(),
    Object? totalExpense = const $CopyWithPlaceholder(),
    Object? net = const $CopyWithPlaceholder(),
  }) {
    return WalletMonthlySummaryResponse(
      month: month == const $CopyWithPlaceholder() || month == null
          ? _value.month
          // ignore: cast_nullable_to_non_nullable
          : month as String,
      totalIncome:
          totalIncome == const $CopyWithPlaceholder() || totalIncome == null
          ? _value.totalIncome
          // ignore: cast_nullable_to_non_nullable
          : totalIncome as num,
      totalExpense:
          totalExpense == const $CopyWithPlaceholder() || totalExpense == null
          ? _value.totalExpense
          // ignore: cast_nullable_to_non_nullable
          : totalExpense as num,
      net: net == const $CopyWithPlaceholder() || net == null
          ? _value.net
          // ignore: cast_nullable_to_non_nullable
          : net as num,
    );
  }
}

extension $WalletMonthlySummaryResponseCopyWith
    on WalletMonthlySummaryResponse {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfWalletMonthlySummaryResponse.copyWith(...)` or `instanceOfWalletMonthlySummaryResponse.copyWith.fieldName(...)`.
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
