// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_stats_high_cancellation_drivers_inner.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DashboardStatsHighCancellationDriversInnerCWProxy {
  DashboardStatsHighCancellationDriversInner id(String id);

  DashboardStatsHighCancellationDriversInner name(String name);

  DashboardStatsHighCancellationDriversInner totalOrders(num totalOrders);

  DashboardStatsHighCancellationDriversInner cancelledOrders(
    num cancelledOrders,
  );

  DashboardStatsHighCancellationDriversInner cancellationRate(
    num cancellationRate,
  );

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DashboardStatsHighCancellationDriversInner(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DashboardStatsHighCancellationDriversInner(...).copyWith(id: 12, name: "My name")
  /// ```
  DashboardStatsHighCancellationDriversInner call({
    String id,
    String name,
    num totalOrders,
    num cancelledOrders,
    num cancellationRate,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDashboardStatsHighCancellationDriversInner.copyWith(...)` or call `instanceOfDashboardStatsHighCancellationDriversInner.copyWith.fieldName(value)` for a single field.
class _$DashboardStatsHighCancellationDriversInnerCWProxyImpl
    implements _$DashboardStatsHighCancellationDriversInnerCWProxy {
  const _$DashboardStatsHighCancellationDriversInnerCWProxyImpl(this._value);

  final DashboardStatsHighCancellationDriversInner _value;

  @override
  DashboardStatsHighCancellationDriversInner id(String id) => call(id: id);

  @override
  DashboardStatsHighCancellationDriversInner name(String name) =>
      call(name: name);

  @override
  DashboardStatsHighCancellationDriversInner totalOrders(num totalOrders) =>
      call(totalOrders: totalOrders);

  @override
  DashboardStatsHighCancellationDriversInner cancelledOrders(
    num cancelledOrders,
  ) => call(cancelledOrders: cancelledOrders);

  @override
  DashboardStatsHighCancellationDriversInner cancellationRate(
    num cancellationRate,
  ) => call(cancellationRate: cancellationRate);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DashboardStatsHighCancellationDriversInner(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DashboardStatsHighCancellationDriversInner(...).copyWith(id: 12, name: "My name")
  /// ```
  DashboardStatsHighCancellationDriversInner call({
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? totalOrders = const $CopyWithPlaceholder(),
    Object? cancelledOrders = const $CopyWithPlaceholder(),
    Object? cancellationRate = const $CopyWithPlaceholder(),
  }) {
    return DashboardStatsHighCancellationDriversInner(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      totalOrders:
          totalOrders == const $CopyWithPlaceholder() || totalOrders == null
          ? _value.totalOrders
          // ignore: cast_nullable_to_non_nullable
          : totalOrders as num,
      cancelledOrders:
          cancelledOrders == const $CopyWithPlaceholder() ||
              cancelledOrders == null
          ? _value.cancelledOrders
          // ignore: cast_nullable_to_non_nullable
          : cancelledOrders as num,
      cancellationRate:
          cancellationRate == const $CopyWithPlaceholder() ||
              cancellationRate == null
          ? _value.cancellationRate
          // ignore: cast_nullable_to_non_nullable
          : cancellationRate as num,
    );
  }
}

extension $DashboardStatsHighCancellationDriversInnerCopyWith
    on DashboardStatsHighCancellationDriversInner {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDashboardStatsHighCancellationDriversInner.copyWith(...)` or `instanceOfDashboardStatsHighCancellationDriversInner.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DashboardStatsHighCancellationDriversInnerCWProxy get copyWith =>
      _$DashboardStatsHighCancellationDriversInnerCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardStatsHighCancellationDriversInner
_$DashboardStatsHighCancellationDriversInnerFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('DashboardStatsHighCancellationDriversInner', json, (
  $checkedConvert,
) {
  $checkKeys(
    json,
    requiredKeys: const [
      'id',
      'name',
      'totalOrders',
      'cancelledOrders',
      'cancellationRate',
    ],
  );
  final val = DashboardStatsHighCancellationDriversInner(
    id: $checkedConvert('id', (v) => v as String),
    name: $checkedConvert('name', (v) => v as String),
    totalOrders: $checkedConvert('totalOrders', (v) => v as num),
    cancelledOrders: $checkedConvert('cancelledOrders', (v) => v as num),
    cancellationRate: $checkedConvert('cancellationRate', (v) => v as num),
  );
  return val;
});

Map<String, dynamic> _$DashboardStatsHighCancellationDriversInnerToJson(
  DashboardStatsHighCancellationDriversInner instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'totalOrders': instance.totalOrders,
  'cancelledOrders': instance.cancelledOrders,
  'cancellationRate': instance.cancellationRate,
};
