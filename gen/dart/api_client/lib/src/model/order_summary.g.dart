// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_summary.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderSummaryCWProxy {
  OrderSummary distanceKm(num distanceKm);

  OrderSummary baseFare(num baseFare);

  OrderSummary distanceFare(num distanceFare);

  OrderSummary additionalFees(num additionalFees);

  OrderSummary subtotal(num subtotal);

  OrderSummary platformFee(num platformFee);

  OrderSummary tax(num tax);

  OrderSummary totalCost(num totalCost);

  OrderSummary breakdown(OrderSummaryBreakdown breakdown);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderSummary(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderSummary(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderSummary call({
    num distanceKm,
    num baseFare,
    num distanceFare,
    num additionalFees,
    num subtotal,
    num platformFee,
    num tax,
    num totalCost,
    OrderSummaryBreakdown breakdown,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOrderSummary.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOrderSummary.copyWith.fieldName(...)`
class _$OrderSummaryCWProxyImpl implements _$OrderSummaryCWProxy {
  const _$OrderSummaryCWProxyImpl(this._value);

  final OrderSummary _value;

  @override
  OrderSummary distanceKm(num distanceKm) => this(distanceKm: distanceKm);

  @override
  OrderSummary baseFare(num baseFare) => this(baseFare: baseFare);

  @override
  OrderSummary distanceFare(num distanceFare) =>
      this(distanceFare: distanceFare);

  @override
  OrderSummary additionalFees(num additionalFees) =>
      this(additionalFees: additionalFees);

  @override
  OrderSummary subtotal(num subtotal) => this(subtotal: subtotal);

  @override
  OrderSummary platformFee(num platformFee) => this(platformFee: platformFee);

  @override
  OrderSummary tax(num tax) => this(tax: tax);

  @override
  OrderSummary totalCost(num totalCost) => this(totalCost: totalCost);

  @override
  OrderSummary breakdown(OrderSummaryBreakdown breakdown) =>
      this(breakdown: breakdown);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderSummary(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderSummary(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderSummary call({
    Object? distanceKm = const $CopyWithPlaceholder(),
    Object? baseFare = const $CopyWithPlaceholder(),
    Object? distanceFare = const $CopyWithPlaceholder(),
    Object? additionalFees = const $CopyWithPlaceholder(),
    Object? subtotal = const $CopyWithPlaceholder(),
    Object? platformFee = const $CopyWithPlaceholder(),
    Object? tax = const $CopyWithPlaceholder(),
    Object? totalCost = const $CopyWithPlaceholder(),
    Object? breakdown = const $CopyWithPlaceholder(),
  }) {
    return OrderSummary(
      distanceKm: distanceKm == const $CopyWithPlaceholder()
          ? _value.distanceKm
          // ignore: cast_nullable_to_non_nullable
          : distanceKm as num,
      baseFare: baseFare == const $CopyWithPlaceholder()
          ? _value.baseFare
          // ignore: cast_nullable_to_non_nullable
          : baseFare as num,
      distanceFare: distanceFare == const $CopyWithPlaceholder()
          ? _value.distanceFare
          // ignore: cast_nullable_to_non_nullable
          : distanceFare as num,
      additionalFees: additionalFees == const $CopyWithPlaceholder()
          ? _value.additionalFees
          // ignore: cast_nullable_to_non_nullable
          : additionalFees as num,
      subtotal: subtotal == const $CopyWithPlaceholder()
          ? _value.subtotal
          // ignore: cast_nullable_to_non_nullable
          : subtotal as num,
      platformFee: platformFee == const $CopyWithPlaceholder()
          ? _value.platformFee
          // ignore: cast_nullable_to_non_nullable
          : platformFee as num,
      tax: tax == const $CopyWithPlaceholder()
          ? _value.tax
          // ignore: cast_nullable_to_non_nullable
          : tax as num,
      totalCost: totalCost == const $CopyWithPlaceholder()
          ? _value.totalCost
          // ignore: cast_nullable_to_non_nullable
          : totalCost as num,
      breakdown: breakdown == const $CopyWithPlaceholder()
          ? _value.breakdown
          // ignore: cast_nullable_to_non_nullable
          : breakdown as OrderSummaryBreakdown,
    );
  }
}

extension $OrderSummaryCopyWith on OrderSummary {
  /// Returns a callable class that can be used as follows: `instanceOfOrderSummary.copyWith(...)` or like so:`instanceOfOrderSummary.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderSummaryCWProxy get copyWith => _$OrderSummaryCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderSummary _$OrderSummaryFromJson(Map<String, dynamic> json) =>
    $checkedCreate('OrderSummary', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'distanceKm',
          'baseFare',
          'distanceFare',
          'additionalFees',
          'subtotal',
          'platformFee',
          'tax',
          'totalCost',
          'breakdown',
        ],
      );
      final val = OrderSummary(
        distanceKm: $checkedConvert('distanceKm', (v) => v as num),
        baseFare: $checkedConvert('baseFare', (v) => v as num),
        distanceFare: $checkedConvert('distanceFare', (v) => v as num),
        additionalFees: $checkedConvert('additionalFees', (v) => v as num),
        subtotal: $checkedConvert('subtotal', (v) => v as num),
        platformFee: $checkedConvert('platformFee', (v) => v as num),
        tax: $checkedConvert('tax', (v) => v as num),
        totalCost: $checkedConvert('totalCost', (v) => v as num),
        breakdown: $checkedConvert(
          'breakdown',
          (v) => OrderSummaryBreakdown.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$OrderSummaryToJson(OrderSummary instance) =>
    <String, dynamic>{
      'distanceKm': instance.distanceKm,
      'baseFare': instance.baseFare,
      'distanceFare': instance.distanceFare,
      'additionalFees': instance.additionalFees,
      'subtotal': instance.subtotal,
      'platformFee': instance.platformFee,
      'tax': instance.tax,
      'totalCost': instance.totalCost,
      'breakdown': instance.breakdown.toJson(),
    };
