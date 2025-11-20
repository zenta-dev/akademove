// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_monthly_summary_query.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$WalletMonthlySummaryQueryCWProxy {
  WalletMonthlySummaryQuery year(num year);

  WalletMonthlySummaryQuery month(num month);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `WalletMonthlySummaryQuery(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// WalletMonthlySummaryQuery(...).copyWith(id: 12, name: "My name")
  /// ```
  WalletMonthlySummaryQuery call({num year, num month});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfWalletMonthlySummaryQuery.copyWith(...)` or call `instanceOfWalletMonthlySummaryQuery.copyWith.fieldName(value)` for a single field.
class _$WalletMonthlySummaryQueryCWProxyImpl
    implements _$WalletMonthlySummaryQueryCWProxy {
  const _$WalletMonthlySummaryQueryCWProxyImpl(this._value);

  final WalletMonthlySummaryQuery _value;

  @override
  WalletMonthlySummaryQuery year(num year) => call(year: year);

  @override
  WalletMonthlySummaryQuery month(num month) => call(month: month);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `WalletMonthlySummaryQuery(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// WalletMonthlySummaryQuery(...).copyWith(id: 12, name: "My name")
  /// ```
  WalletMonthlySummaryQuery call({
    Object? year = const $CopyWithPlaceholder(),
    Object? month = const $CopyWithPlaceholder(),
  }) {
    return WalletMonthlySummaryQuery(
      year: year == const $CopyWithPlaceholder() || year == null
          ? _value.year
          // ignore: cast_nullable_to_non_nullable
          : year as num,
      month: month == const $CopyWithPlaceholder() || month == null
          ? _value.month
          // ignore: cast_nullable_to_non_nullable
          : month as num,
    );
  }
}

extension $WalletMonthlySummaryQueryCopyWith on WalletMonthlySummaryQuery {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfWalletMonthlySummaryQuery.copyWith(...)` or `instanceOfWalletMonthlySummaryQuery.copyWith.fieldName(...)`.
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
