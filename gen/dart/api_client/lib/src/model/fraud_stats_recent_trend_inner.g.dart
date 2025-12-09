// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fraud_stats_recent_trend_inner.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$FraudStatsRecentTrendInnerCWProxy {
  FraudStatsRecentTrendInner date(String date);

  FraudStatsRecentTrendInner count(int count);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `FraudStatsRecentTrendInner(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// FraudStatsRecentTrendInner(...).copyWith(id: 12, name: "My name")
  /// ```
  FraudStatsRecentTrendInner call({String date, int count});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfFraudStatsRecentTrendInner.copyWith(...)` or call `instanceOfFraudStatsRecentTrendInner.copyWith.fieldName(value)` for a single field.
class _$FraudStatsRecentTrendInnerCWProxyImpl
    implements _$FraudStatsRecentTrendInnerCWProxy {
  const _$FraudStatsRecentTrendInnerCWProxyImpl(this._value);

  final FraudStatsRecentTrendInner _value;

  @override
  FraudStatsRecentTrendInner date(String date) => call(date: date);

  @override
  FraudStatsRecentTrendInner count(int count) => call(count: count);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `FraudStatsRecentTrendInner(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// FraudStatsRecentTrendInner(...).copyWith(id: 12, name: "My name")
  /// ```
  FraudStatsRecentTrendInner call({
    Object? date = const $CopyWithPlaceholder(),
    Object? count = const $CopyWithPlaceholder(),
  }) {
    return FraudStatsRecentTrendInner(
      date: date == const $CopyWithPlaceholder() || date == null
          ? _value.date
          // ignore: cast_nullable_to_non_nullable
          : date as String,
      count: count == const $CopyWithPlaceholder() || count == null
          ? _value.count
          // ignore: cast_nullable_to_non_nullable
          : count as int,
    );
  }
}

extension $FraudStatsRecentTrendInnerCopyWith on FraudStatsRecentTrendInner {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfFraudStatsRecentTrendInner.copyWith(...)` or `instanceOfFraudStatsRecentTrendInner.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$FraudStatsRecentTrendInnerCWProxy get copyWith =>
      _$FraudStatsRecentTrendInnerCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FraudStatsRecentTrendInner _$FraudStatsRecentTrendInnerFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('FraudStatsRecentTrendInner', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['date', 'count']);
  final val = FraudStatsRecentTrendInner(
    date: $checkedConvert('date', (v) => v as String),
    count: $checkedConvert('count', (v) => (v as num).toInt()),
  );
  return val;
});

Map<String, dynamic> _$FraudStatsRecentTrendInnerToJson(
  FraudStatsRecentTrendInner instance,
) => <String, dynamic>{'date': instance.date, 'count': instance.count};
