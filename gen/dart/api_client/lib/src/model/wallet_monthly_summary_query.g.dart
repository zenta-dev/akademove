// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_monthly_summary_query.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$WalletMonthlySummaryQueryCWProxy {
  WalletMonthlySummaryQuery year(num year);

  WalletMonthlySummaryQuery month(num month);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `WalletMonthlySummaryQuery(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// WalletMonthlySummaryQuery(...).copyWith(id: 12, name: "My name")
  /// ````
  WalletMonthlySummaryQuery call({num year, num month});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfWalletMonthlySummaryQuery.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfWalletMonthlySummaryQuery.copyWith.fieldName(...)`
class _$WalletMonthlySummaryQueryCWProxyImpl
    implements _$WalletMonthlySummaryQueryCWProxy {
  const _$WalletMonthlySummaryQueryCWProxyImpl(this._value);

  final WalletMonthlySummaryQuery _value;

  @override
  WalletMonthlySummaryQuery year(num year) => this(year: year);

  @override
  WalletMonthlySummaryQuery month(num month) => this(month: month);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `WalletMonthlySummaryQuery(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// WalletMonthlySummaryQuery(...).copyWith(id: 12, name: "My name")
  /// ````
  WalletMonthlySummaryQuery call({
    Object? year = const $CopyWithPlaceholder(),
    Object? month = const $CopyWithPlaceholder(),
  }) {
    return WalletMonthlySummaryQuery(
      year: year == const $CopyWithPlaceholder()
          ? _value.year
          // ignore: cast_nullable_to_non_nullable
          : year as num,
      month: month == const $CopyWithPlaceholder()
          ? _value.month
          // ignore: cast_nullable_to_non_nullable
          : month as num,
    );
  }
}

extension $WalletMonthlySummaryQueryCopyWith on WalletMonthlySummaryQuery {
  /// Returns a callable class that can be used as follows: `instanceOfWalletMonthlySummaryQuery.copyWith(...)` or like so:`instanceOfWalletMonthlySummaryQuery.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$WalletMonthlySummaryQueryCWProxy get copyWith =>
      _$WalletMonthlySummaryQueryCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletMonthlySummaryQuery _$WalletMonthlySummaryQueryFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('WalletMonthlySummaryQuery', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['year', 'month']);
  final val = WalletMonthlySummaryQuery(
    year: $checkedConvert('year', (v) => v as num),
    month: $checkedConvert('month', (v) => v as num),
  );
  return val;
});

Map<String, dynamic> _$WalletMonthlySummaryQueryToJson(
  WalletMonthlySummaryQuery instance,
) => <String, dynamic>{'year': instance.year, 'month': instance.month};
