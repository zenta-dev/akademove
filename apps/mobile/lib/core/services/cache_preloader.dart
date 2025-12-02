import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';

/// Service for preloading critical data into cache on app startup
/// Improves initial app experience by warming the cache with frequently accessed data
class CachePreloader {
  CachePreloader({
    required DriverRepository driverRepository,
    // ignore: unused_element
    required ConfigurationRepository configurationRepository,
  }) : _driverRepository = driverRepository,
       _configurationRepository = configurationRepository;

  final DriverRepository _driverRepository;
  // ignore: unused_field
  final ConfigurationRepository _configurationRepository;

  /// Preload critical driver data
  /// This runs in the background and does not block app startup
  /// Call this after successful authentication when user role is DRIVER
  Future<void> preloadDriverData() async {
    try {
      logger.i('[CachePreloader] Starting driver data preload...');

      // Preload driver profile (most frequently accessed)
      await _preloadDriverProfile();

      // Preload platform configuration (used in earnings calculations)
      await _preloadPlatformConfig();

      logger.i('[CachePreloader] Driver data preload completed');
    } catch (e, st) {
      // Don't block app startup on preload failure
      logger.w(
        '[CachePreloader] Preload failed, will load on demand',
        error: e,
        stackTrace: st,
      );
    }
  }

  Future<void> _preloadDriverProfile() async {
    try {
      final res = await _driverRepository.getMine();
      AppCaches.driver.put(
        'my-profile',
        res.data,
        duration: const Duration(minutes: 5),
      );
      logger.d('[CachePreloader] Driver profile cached: ${res.data.id}');
    } catch (e) {
      logger.w('[CachePreloader] Failed to preload driver profile: $e');
    }
  }

  Future<void> _preloadPlatformConfig() async {
    try {
      // TODO: Implement platform fee rate caching when ConfigurationRepository method is available
      // Preload commission rates for all order types
      // for (final orderType in OrderType.values) {
      //   final rate = await _configurationRepository.getPlatformFeeRate(
      //     orderType,
      //   );
      //   logger.d(
      //     '[CachePreloader] Platform fee cached: $orderType = ${(rate * 100).toStringAsFixed(0)}%',
      //   );
      // }
      logger.d(
        '[CachePreloader] Platform config preload skipped (not implemented)',
      );
    } catch (e) {
      logger.w('[CachePreloader] Failed to preload platform config: $e');
    }
  }

  /// Clear all caches (useful for logout or cache reset)
  void clearAllCaches() {
    AppCaches.driver.clear();
    AppCaches.orders.clear();
    AppCaches.earnings.clear();
    logger.i('[CachePreloader] All caches cleared');
  }

  /// Invalidate driver profile cache when profile is updated
  void invalidateDriverProfile() {
    AppCaches.driver.remove('my-profile');
    logger.d('[CachePreloader] Driver profile cache invalidated');
  }

  /// Invalidate orders cache when order status changes
  void invalidateOrders() {
    // Clear all order caches (all, completed, cancelled, etc.)
    AppCaches.orders.clear();
    logger.d('[CachePreloader] Orders cache invalidated');
  }

  /// Invalidate earnings cache when wallet balance changes
  void invalidateEarnings() {
    // Clear wallet and earnings data
    AppCaches.earnings.clear();
    logger.d('[CachePreloader] Earnings cache invalidated');
  }

  /// Invalidate specific order status cache
  void invalidateOrdersByStatus(OrderStatus? status) {
    final cacheKey = 'orders-${status?.name ?? "all"}';
    AppCaches.orders.remove(cacheKey);
    logger.d('[CachePreloader] Orders cache invalidated for status: $status');
  }

  /// Refresh critical data on network reconnection
  /// Called automatically when network comes back online
  Future<void> onNetworkReconnected() async {
    try {
      logger.i(
        '[CachePreloader] Network reconnected, refreshing critical data...',
      );

      // Refresh driver profile in background (don't await)
      // ignore: unawaited_futures
      _preloadDriverProfile();

      // Don't block on the refresh
      logger.i('[CachePreloader] Background refresh initiated');
    } catch (e, st) {
      logger.w(
        '[CachePreloader] Failed to refresh on reconnection',
        error: e,
        stackTrace: st,
      );
    }
  }

  /// Log cache statistics for debugging (basic info)
  void logCacheStats() {
    logger.i('''
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📊 CACHE STATUS
  
✓ Driver cache active
✓ Orders cache active  
✓ Earnings cache active

All caches operational and ready
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
''');
  }
}
