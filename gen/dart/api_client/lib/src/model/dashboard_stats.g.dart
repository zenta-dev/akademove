// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_stats.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DashboardStatsCWProxy {
  DashboardStats totalUsers(num totalUsers);

  DashboardStats totalDrivers(num totalDrivers);

  DashboardStats totalMerchants(num totalMerchants);

  DashboardStats activeOrders(num activeOrders);

  DashboardStats totalOrders(num totalOrders);

  DashboardStats completedOrders(num completedOrders);

  DashboardStats cancelledOrders(num cancelledOrders);

  DashboardStats totalRevenue(num totalRevenue);

  DashboardStats todayRevenue(num todayRevenue);

  DashboardStats todayOrders(num todayOrders);

  DashboardStats onlineDrivers(num onlineDrivers);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DashboardStats(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DashboardStats(...).copyWith(id: 12, name: "My name")
  /// ```
  DashboardStats call({
    num totalUsers,
    num totalDrivers,
    num totalMerchants,
    num activeOrders,
    num totalOrders,
    num completedOrders,
    num cancelledOrders,
    num totalRevenue,
    num todayRevenue,
    num todayOrders,
    num onlineDrivers,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDashboardStats.copyWith(...)` or call `instanceOfDashboardStats.copyWith.fieldName(value)` for a single field.
class _$DashboardStatsCWProxyImpl implements _$DashboardStatsCWProxy {
  const _$DashboardStatsCWProxyImpl(this._value);

  final DashboardStats _value;

  @override
  DashboardStats totalUsers(num totalUsers) => call(totalUsers: totalUsers);

  @override
  DashboardStats totalDrivers(num totalDrivers) => call(totalDrivers: totalDrivers);

  @override
  DashboardStats totalMerchants(num totalMerchants) => call(totalMerchants: totalMerchants);

  @override
  DashboardStats activeOrders(num activeOrders) => call(activeOrders: activeOrders);

  @override
  DashboardStats totalOrders(num totalOrders) => call(totalOrders: totalOrders);

  @override
  DashboardStats completedOrders(num completedOrders) => call(completedOrders: completedOrders);

  @override
  DashboardStats cancelledOrders(num cancelledOrders) => call(cancelledOrders: cancelledOrders);

  @override
  DashboardStats totalRevenue(num totalRevenue) => call(totalRevenue: totalRevenue);

  @override
  DashboardStats todayRevenue(num todayRevenue) => call(todayRevenue: todayRevenue);

  @override
  DashboardStats todayOrders(num todayOrders) => call(todayOrders: todayOrders);

  @override
  DashboardStats onlineDrivers(num onlineDrivers) => call(onlineDrivers: onlineDrivers);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DashboardStats(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DashboardStats(...).copyWith(id: 12, name: "My name")
  /// ```
  DashboardStats call({
    Object? totalUsers = const $CopyWithPlaceholder(),
    Object? totalDrivers = const $CopyWithPlaceholder(),
    Object? totalMerchants = const $CopyWithPlaceholder(),
    Object? activeOrders = const $CopyWithPlaceholder(),
    Object? totalOrders = const $CopyWithPlaceholder(),
    Object? completedOrders = const $CopyWithPlaceholder(),
    Object? cancelledOrders = const $CopyWithPlaceholder(),
    Object? totalRevenue = const $CopyWithPlaceholder(),
    Object? todayRevenue = const $CopyWithPlaceholder(),
    Object? todayOrders = const $CopyWithPlaceholder(),
    Object? onlineDrivers = const $CopyWithPlaceholder(),
  }) {
    return DashboardStats(
      totalUsers: totalUsers == const $CopyWithPlaceholder() || totalUsers == null
          ? _value.totalUsers
          // ignore: cast_nullable_to_non_nullable
          : totalUsers as num,
      totalDrivers: totalDrivers == const $CopyWithPlaceholder() || totalDrivers == null
          ? _value.totalDrivers
          // ignore: cast_nullable_to_non_nullable
          : totalDrivers as num,
      totalMerchants: totalMerchants == const $CopyWithPlaceholder() || totalMerchants == null
          ? _value.totalMerchants
          // ignore: cast_nullable_to_non_nullable
          : totalMerchants as num,
      activeOrders: activeOrders == const $CopyWithPlaceholder() || activeOrders == null
          ? _value.activeOrders
          // ignore: cast_nullable_to_non_nullable
          : activeOrders as num,
      totalOrders: totalOrders == const $CopyWithPlaceholder() || totalOrders == null
          ? _value.totalOrders
          // ignore: cast_nullable_to_non_nullable
          : totalOrders as num,
      completedOrders: completedOrders == const $CopyWithPlaceholder() || completedOrders == null
          ? _value.completedOrders
          // ignore: cast_nullable_to_non_nullable
          : completedOrders as num,
      cancelledOrders: cancelledOrders == const $CopyWithPlaceholder() || cancelledOrders == null
          ? _value.cancelledOrders
          // ignore: cast_nullable_to_non_nullable
          : cancelledOrders as num,
      totalRevenue: totalRevenue == const $CopyWithPlaceholder() || totalRevenue == null
          ? _value.totalRevenue
          // ignore: cast_nullable_to_non_nullable
          : totalRevenue as num,
      todayRevenue: todayRevenue == const $CopyWithPlaceholder() || todayRevenue == null
          ? _value.todayRevenue
          // ignore: cast_nullable_to_non_nullable
          : todayRevenue as num,
      todayOrders: todayOrders == const $CopyWithPlaceholder() || todayOrders == null
          ? _value.todayOrders
          // ignore: cast_nullable_to_non_nullable
          : todayOrders as num,
      onlineDrivers: onlineDrivers == const $CopyWithPlaceholder() || onlineDrivers == null
          ? _value.onlineDrivers
          // ignore: cast_nullable_to_non_nullable
          : onlineDrivers as num,
    );
  }
}

extension $DashboardStatsCopyWith on DashboardStats {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDashboardStats.copyWith(...)` or `instanceOfDashboardStats.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DashboardStatsCWProxy get copyWith => _$DashboardStatsCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardStats _$DashboardStatsFromJson(Map<String, dynamic> json) =>
    $checkedCreate('DashboardStats', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'totalUsers',
          'totalDrivers',
          'totalMerchants',
          'activeOrders',
          'totalOrders',
          'completedOrders',
          'cancelledOrders',
          'totalRevenue',
          'todayRevenue',
          'todayOrders',
          'onlineDrivers',
        ],
      );
      final val = DashboardStats(
        totalUsers: $checkedConvert('totalUsers', (v) => v as num),
        totalDrivers: $checkedConvert('totalDrivers', (v) => v as num),
        totalMerchants: $checkedConvert('totalMerchants', (v) => v as num),
        activeOrders: $checkedConvert('activeOrders', (v) => v as num),
        totalOrders: $checkedConvert('totalOrders', (v) => v as num),
        completedOrders: $checkedConvert('completedOrders', (v) => v as num),
        cancelledOrders: $checkedConvert('cancelledOrders', (v) => v as num),
        totalRevenue: $checkedConvert('totalRevenue', (v) => v as num),
        todayRevenue: $checkedConvert('todayRevenue', (v) => v as num),
        todayOrders: $checkedConvert('todayOrders', (v) => v as num),
        onlineDrivers: $checkedConvert('onlineDrivers', (v) => v as num),
      );
      return val;
    });

Map<String, dynamic> _$DashboardStatsToJson(DashboardStats instance) => <String, dynamic>{
  'totalUsers': instance.totalUsers,
  'totalDrivers': instance.totalDrivers,
  'totalMerchants': instance.totalMerchants,
  'activeOrders': instance.activeOrders,
  'totalOrders': instance.totalOrders,
  'completedOrders': instance.completedOrders,
  'cancelledOrders': instance.cancelledOrders,
  'totalRevenue': instance.totalRevenue,
  'todayRevenue': instance.todayRevenue,
  'todayOrders': instance.todayOrders,
  'onlineDrivers': instance.onlineDrivers,
};
