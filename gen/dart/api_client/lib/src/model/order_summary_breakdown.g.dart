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

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderSummaryBreakdown(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderSummaryBreakdown(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderSummaryBreakdown call({
    num? distance,
    num? duration,
    num? perMinuteRate,
    num? weight,
    num? perKgRate,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOrderSummaryBreakdown.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOrderSummaryBreakdown.copyWith.fieldName(...)`
class _$OrderSummaryBreakdownCWProxyImpl
    implements _$OrderSummaryBreakdownCWProxy {
  const _$OrderSummaryBreakdownCWProxyImpl(this._value);

  final OrderSummaryBreakdown _value;

  @override
  OrderSummaryBreakdown distance(num? distance) => this(distance: distance);

  @override
  OrderSummaryBreakdown duration(num? duration) => this(duration: duration);

  @override
  OrderSummaryBreakdown perMinuteRate(num? perMinuteRate) =>
      this(perMinuteRate: perMinuteRate);

  @override
  OrderSummaryBreakdown weight(num? weight) => this(weight: weight);

  @override
  OrderSummaryBreakdown perKgRate(num? perKgRate) => this(perKgRate: perKgRate);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderSummaryBreakdown(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderSummaryBreakdown(...).copyWith(id: 12, name: "My name")
  /// ````
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
  /// Returns a callable class that can be used as follows: `instanceOfOrderSummaryBreakdown.copyWith(...)` or like so:`instanceOfOrderSummaryBreakdown.copyWith.fieldName(...)`.
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
