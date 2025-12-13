// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chart_data_point.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ChartDataPointCWProxy {
  ChartDataPoint label(String label);

  ChartDataPoint income(num income);

  ChartDataPoint outcome(num outcome);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `ChartDataPoint(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ChartDataPoint(...).copyWith(id: 12, name: "My name")
  /// ```
  ChartDataPoint call({String label, num income, num outcome});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfChartDataPoint.copyWith(...)` or call `instanceOfChartDataPoint.copyWith.fieldName(value)` for a single field.
class _$ChartDataPointCWProxyImpl implements _$ChartDataPointCWProxy {
  const _$ChartDataPointCWProxyImpl(this._value);

  final ChartDataPoint _value;

  @override
  ChartDataPoint label(String label) => call(label: label);

  @override
  ChartDataPoint income(num income) => call(income: income);

  @override
  ChartDataPoint outcome(num outcome) => call(outcome: outcome);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `ChartDataPoint(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ChartDataPoint(...).copyWith(id: 12, name: "My name")
  /// ```
  ChartDataPoint call({
    Object? label = const $CopyWithPlaceholder(),
    Object? income = const $CopyWithPlaceholder(),
    Object? outcome = const $CopyWithPlaceholder(),
  }) {
    return ChartDataPoint(
      label: label == const $CopyWithPlaceholder() || label == null
          ? _value.label
          // ignore: cast_nullable_to_non_nullable
          : label as String,
      income: income == const $CopyWithPlaceholder() || income == null
          ? _value.income
          // ignore: cast_nullable_to_non_nullable
          : income as num,
      outcome: outcome == const $CopyWithPlaceholder() || outcome == null
          ? _value.outcome
          // ignore: cast_nullable_to_non_nullable
          : outcome as num,
    );
  }
}

extension $ChartDataPointCopyWith on ChartDataPoint {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfChartDataPoint.copyWith(...)` or `instanceOfChartDataPoint.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ChartDataPointCWProxy get copyWith => _$ChartDataPointCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChartDataPoint _$ChartDataPointFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ChartDataPoint', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['label', 'income', 'outcome']);
      final val = ChartDataPoint(
        label: $checkedConvert('label', (v) => v as String),
        income: $checkedConvert('income', (v) => v as num),
        outcome: $checkedConvert('outcome', (v) => v as num),
      );
      return val;
    });

Map<String, dynamic> _$ChartDataPointToJson(ChartDataPoint instance) =>
    <String, dynamic>{
      'label': instance.label,
      'income': instance.income,
      'outcome': instance.outcome,
    };
