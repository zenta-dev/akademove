import 'package:akademove/core/_export.dart';

/// Simple in-memory cache with TTL (Time To Live) support
///
/// Usage:
/// ```dart
/// final cache = CacheManager<Order>();
///
/// // Store with 5 minute TTL
/// cache.put('order-123', order, duration: Duration(minutes: 5));
///
/// // Retrieve
/// final order = cache.get('order-123');
///
/// // Check if exists and not expired
/// if (cache.has('order-123')) {
///   // Use cached data
/// }
/// ```
class CacheManager<T> {
  CacheManager({
    this.defaultTTL = const Duration(minutes: 5),
    this.maxSize = 100,
  });

  /// Default time-to-live for cached items
  final Duration defaultTTL;

  /// Maximum number of items to cache (LRU eviction)
  final int maxSize;

  final Map<String, _CacheEntry<T>> _cache = {};
  final List<String> _accessOrder = [];

  /// Store an item in cache with optional TTL
  void put(String key, T value, {Duration? duration}) {
    final ttl = duration ?? defaultTTL;
    final expiresAt = DateTime.now().add(ttl);

    // Remove if already exists
    if (_cache.containsKey(key)) {
      _accessOrder.remove(key);
    }

    // Add to cache
    _cache[key] = _CacheEntry(value: value, expiresAt: expiresAt);
    _accessOrder.add(key);

    // Evict oldest if exceeding max size
    if (_cache.length > maxSize) {
      final oldest = _accessOrder.removeAt(0);
      _cache.remove(oldest);
      logger.d('[CacheManager] Evicted oldest entry: $oldest');
    }
  }

  /// Retrieve an item from cache (returns null if expired or not found)
  T? get(String key) {
    final entry = _cache[key];
    if (entry == null) return null;

    // Check if expired
    if (entry.isExpired) {
      remove(key);
      return null;
    }

    // Update access order (LRU)
    _accessOrder.remove(key);
    _accessOrder.add(key);

    return entry.value;
  }

  /// Check if cache has a valid (non-expired) entry
  bool has(String key) {
    final entry = _cache[key];
    if (entry == null) return false;

    if (entry.isExpired) {
      remove(key);
      return false;
    }

    return true;
  }

  /// Remove an item from cache
  void remove(String key) {
    _cache.remove(key);
    _accessOrder.remove(key);
  }

  /// Clear all cached items
  void clear() {
    _cache.clear();
    _accessOrder.clear();
    logger.d('[CacheManager] Cache cleared');
  }

  /// Remove all expired entries
  void removeExpired() {
    final now = DateTime.now();
    final expiredKeys = <String>[];

    for (final entry in _cache.entries) {
      if (entry.value.expiresAt.isBefore(now)) {
        expiredKeys.add(entry.key);
      }
    }

    for (final key in expiredKeys) {
      remove(key);
    }

    if (expiredKeys.isNotEmpty) {
      logger.d('[CacheManager] Removed ${expiredKeys.length} expired entries');
    }
  }

  /// Get current cache size
  int get size => _cache.length;

  /// Get all cached keys
  List<String> get keys => List.unmodifiable(_cache.keys);

  /// Get cache statistics
  CacheStats get stats => CacheStats(
    size: _cache.length,
    maxSize: maxSize,
    expiredCount: _cache.values.where((e) => e.isExpired).length,
  );
}

class _CacheEntry<T> {
  _CacheEntry({required this.value, required this.expiresAt});

  final T value;
  final DateTime expiresAt;

  bool get isExpired => DateTime.now().isAfter(expiresAt);
}

class CacheStats {
  const CacheStats({
    required this.size,
    required this.maxSize,
    required this.expiredCount,
  });

  final int size;
  final int maxSize;
  final int expiredCount;

  @override
  String toString() =>
      'CacheStats(size: $size/$maxSize, expired: $expiredCount)';
}

/// Global cache instances for common types
class AppCaches {
  static final orders = CacheManager<Object>(
    defaultTTL: const Duration(minutes: 5),
    maxSize: 50,
  );

  static final driver = CacheManager<Object>(
    defaultTTL: const Duration(minutes: 10),
    maxSize: 10,
  );

  static final earnings = CacheManager<Object>(
    defaultTTL: const Duration(minutes: 15),
    maxSize: 20,
  );

  static void clearAll() {
    orders.clear();
    driver.clear();
    earnings.clear();
    logger.i('[AppCaches] All caches cleared');
  }

  static void removeExpired() {
    orders.removeExpired();
    driver.removeExpired();
    earnings.removeExpired();
  }
}
