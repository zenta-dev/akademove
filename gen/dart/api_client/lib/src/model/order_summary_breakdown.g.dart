// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_summary_breakdown.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderSummaryBreakdownCWProxy {
  OrderSummaryBreakdown distance(num? distance);

  OrderSummaryBreakdown duration(num? duration);

  OrderSummaryBreakdown perMinuteRate(num? perMinuteRate);

  OrderSummaryBreakdown weight(num? weight);

  OrderSummaryBreakdown perKgRate(num? perKgRate);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderSummaryBreakdown(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderSummaryBreakdown(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderSummaryBreakdown call({
    num? distance,
    num? duration,
    num? perMinuteRate,
    num? weight,
    num? perKgRate,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfOrderSummaryBreakdown.copyWith(...)` or call `instanceOfOrderSummaryBreakdown.copyWith.fieldName(value)` for a single field.
class _$OrderSummaryBreakdownCWProxyImpl
    implements _$OrderSummaryBreakdownCWProxy {
  const _$OrderSummaryBreakdownCWProxyImpl(this._value);

  final OrderSummaryBreakdown _value;

  @override
  OrderSummaryBreakdown distance(num? distance) => call(distance: distance);

  @override
  OrderSummaryBreakdown duration(num? duration) => call(duration: duration);

  @override
  OrderSummaryBreakdown perMinuteRate(num? perMinuteRate) =>
      call(perMinuteRate: perMinuteRate);

  @override
  OrderSummaryBreakdown weight(num? weight) => call(weight: weight);

  @override
  OrderSummaryBreakdown perKgRate(num? perKgRate) => call(perKgRate: perKgRate);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderSummaryBreakdown(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderSummaryBreakdown(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderSummaryBreakdown call({
    Object? distance = const $CopyWithPlaceholder(),
    Object? duration = const $CopyWithPlaceholder(),
    Object? perMinuteRate = const $CopyWithPlaceholder(),
    Object? weight = const $CopyWithPlaceholder(),
    Object? perKgRate = const $CopyWithPlaceholder(),
  }) {
    return OrderSummaryBreakdown(
      distance: distance == const $CopyWithPlaceholder()
          ? _value.distance
          // ignore: cast_nullable_to_non_nullable
          : distance as num?,
      duration: duration == const $CopyWithPlaceholder()
          ? _value.duration
          // ignore: cast_nullable_to_non_nullable
          : duration as num?,
      perMinuteRate: perMinuteRate == const $CopyWithPlaceholder()
          ? _value.perMinuteRate
          // ignore: cast_nullable_to_non_nullable
          : perMinuteRate as num?,
      weight: weight == const $CopyWithPlaceholder()
          ? _value.weight
          // ignore: cast_nullable_to_non_nullable
          : weight as num?,
      perKgRate: perKgRate == const $CopyWithPlaceholder()
          ? _value.perKgRate
          // ignore: cast_nullable_to_non_nullable
          : perKgRate as num?,
    );
  }
}

extension $OrderSummaryBreakdownCopyWith on OrderSummaryBreakdown {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfOrderSummaryBreakdown.copyWith(...)` or `instanceOfOrderSummaryBreakdown.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderSummaryBreakdownCWProxy get copyWith =>
      _$OrderSummaryBreakdownCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderSummaryBreakdown _$OrderSummaryBreakdownFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('OrderSummaryBreakdown', json, ($checkedConvert) {
  final val = OrderSummaryBreakdown(
    distance: $checkedConvert('distance', (v) => v as num?),
    duration: $checkedConvert('duration', (v) => v as num?),
    perMinuteRate: $checkedConvert('perMinuteRate', (v) => v as num?),
    weight: $checkedConvert('weight', (v) => v as num?),
    perKgRate: $checkedConvert('perKgRate', (v) => v as num?),
  );
  return val;
});

Map<String, dynamic> _$OrderSummaryBreakdownToJson(
  OrderSummaryBreakdown instance,
) => <String, dynamic>{
  'distance': ?instance.distance,
  'duration': ?instance.duration,
  'perMinuteRate': ?instance.perMinuteRate,
  'weight': ?instance.weight,
  'perKgRate': ?instance.perKgRate,
};
