// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fraud_stats_query.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$FraudStatsQueryCWProxy {
  FraudStatsQuery startDate(DateTime? startDate);

  FraudStatsQuery endDate(DateTime? endDate);

  FraudStatsQuery trendDays(int? trendDays);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `FraudStatsQuery(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// FraudStatsQuery(...).copyWith(id: 12, name: "My name")
  /// ```
  FraudStatsQuery call({
    DateTime? startDate,
    DateTime? endDate,
    int? trendDays,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfFraudStatsQuery.copyWith(...)` or call `instanceOfFraudStatsQuery.copyWith.fieldName(value)` for a single field.
class _$FraudStatsQueryCWProxyImpl implements _$FraudStatsQueryCWProxy {
  const _$FraudStatsQueryCWProxyImpl(this._value);

  final FraudStatsQuery _value;

  @override
  FraudStatsQuery startDate(DateTime? startDate) => call(startDate: startDate);

  @override
  FraudStatsQuery endDate(DateTime? endDate) => call(endDate: endDate);

  @override
  FraudStatsQuery trendDays(int? trendDays) => call(trendDays: trendDays);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `FraudStatsQuery(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// FraudStatsQuery(...).copyWith(id: 12, name: "My name")
  /// ```
  FraudStatsQuery call({
    Object? startDate = const $CopyWithPlaceholder(),
    Object? endDate = const $CopyWithPlaceholder(),
    Object? trendDays = const $CopyWithPlaceholder(),
  }) {
    return FraudStatsQuery(
      startDate: startDate == const $CopyWithPlaceholder()
          ? _value.startDate
          // ignore: cast_nullable_to_non_nullable
          : startDate as DateTime?,
      endDate: endDate == const $CopyWithPlaceholder()
          ? _value.endDate
          // ignore: cast_nullable_to_non_nullable
          : endDate as DateTime?,
      trendDays: trendDays == const $CopyWithPlaceholder()
          ? _value.trendDays
          // ignore: cast_nullable_to_non_nullable
          : trendDays as int?,
    );
  }
}

extension $FraudStatsQueryCopyWith on FraudStatsQuery {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfFraudStatsQuery.copyWith(...)` or `instanceOfFraudStatsQuery.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$FraudStatsQueryCWProxy get copyWith => _$FraudStatsQueryCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FraudStatsQuery _$FraudStatsQueryFromJson(Map<String, dynamic> json) =>
    $checkedCreate('FraudStatsQuery', json, ($checkedConvert) {
      final val = FraudStatsQuery(
        startDate: $checkedConvert(
          'startDate',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
        endDate: $checkedConvert(
          'endDate',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
        trendDays: $checkedConvert('trendDays', (v) => (v as num?)?.toInt()),
      );
      return val;
    });

Map<String, dynamic> _$FraudStatsQueryToJson(FraudStatsQuery instance) =>
    <String, dynamic>{
      'startDate': ?instance.startDate?.toIso8601String(),
      'endDate': ?instance.endDate?.toIso8601String(),
      'trendDays': ?instance.trendDays,
    };
