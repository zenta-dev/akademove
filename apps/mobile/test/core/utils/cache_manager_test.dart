import 'package:akademove/core/utils/cache_manager.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CacheManager', () {
    late CacheManager<String> cache;

    setUp(() {
      cache = CacheManager<String>(
        defaultTTL: const Duration(seconds: 1),
        maxSize: 3,
      );
    });

    tearDown(() {
      cache.clear();
    });

    group('Basic Operations', () {
      test('should store and retrieve items', () {
        cache.put('key1', 'value1');
        expect(cache.get('key1'), equals('value1'));
      });

      test('should return null for non-existent keys', () {
        expect(cache.get('non-existent'), isNull);
      });

      test('should check if key exists', () {
        cache.put('key1', 'value1');
        expect(cache.has('key1'), isTrue);
        expect(cache.has('key2'), isFalse);
      });

      test('should remove items', () {
        cache.put('key1', 'value1');
        cache.remove('key1');
        expect(cache.get('key1'), isNull);
        expect(cache.has('key1'), isFalse);
      });

      test('should clear all items', () {
        cache.put('key1', 'value1');
        cache.put('key2', 'value2');
        cache.clear();
        expect(cache.get('key1'), isNull);
        expect(cache.get('key2'), isNull);
      });

      test('should update existing keys', () {
        cache.put('key1', 'value1');
        cache.put('key1', 'value2');
        expect(cache.get('key1'), equals('value2'));
      });
    });

    group('TTL (Time To Live)', () {
      test('should expire items after TTL', () async {
        cache.put('key1', 'value1');
        expect(cache.get('key1'), equals('value1'));

        // Wait for TTL to expire (1 second + buffer)
        await Future<void>.delayed(const Duration(milliseconds: 1100));

        expect(cache.get('key1'), isNull);
        expect(cache.has('key1'), isFalse);
      });

      test('should use custom TTL when provided', () async {
        cache.put(
          'key1',
          'value1',
          duration: const Duration(milliseconds: 500),
        );
        expect(cache.get('key1'), equals('value1'));

        // Wait for custom TTL to expire
        await Future<void>.delayed(const Duration(milliseconds: 600));

        expect(cache.get('key1'), isNull);
      });

      test('should auto-remove expired entries on get', () async {
        cache.put('key1', 'value1');

        // Wait for expiration
        await Future<void>.delayed(const Duration(milliseconds: 1100));

        // First get should return null and remove entry
        expect(cache.get('key1'), isNull);

        // Subsequent calls should also return null
        expect(cache.get('key1'), isNull);
      });

      test('should auto-remove expired entries on has', () async {
        cache.put('key1', 'value1');

        // Wait for expiration
        await Future<void>.delayed(const Duration(milliseconds: 1100));

        // has() should return false and remove entry
        expect(cache.has('key1'), isFalse);

        // Cache should be empty
        expect(cache.size, equals(0));
      });
    });

    group('LRU Eviction', () {
      test('should evict oldest item when exceeding maxSize', () {
        cache.put('key1', 'value1');
        cache.put('key2', 'value2');
        cache.put('key3', 'value3');

        // This should evict key1 (oldest)
        cache.put('key4', 'value4');

        expect(cache.get('key1'), isNull);
        expect(cache.get('key2'), equals('value2'));
        expect(cache.get('key3'), equals('value3'));
        expect(cache.get('key4'), equals('value4'));
      });

      test('should update access order on get', () {
        cache.put('key1', 'value1');
        cache.put('key2', 'value2');
        cache.put('key3', 'value3');

        // Access key1 to make it most recently used
        cache.get('key1');

        // This should evict key2 (oldest after access)
        cache.put('key4', 'value4');

        expect(cache.get('key1'), equals('value1')); // Should still exist
        expect(cache.get('key2'), isNull); // Should be evicted
        expect(cache.get('key3'), equals('value3'));
        expect(cache.get('key4'), equals('value4'));
      });

      test('should update access order on put to existing key', () {
        cache.put('key1', 'value1');
        cache.put('key2', 'value2');
        cache.put('key3', 'value3');

        // Update key1 to make it most recently used
        cache.put('key1', 'updated');

        // This should evict key2 (oldest after update)
        cache.put('key4', 'value4');

        expect(cache.get('key1'), equals('updated')); // Should still exist
        expect(cache.get('key2'), isNull); // Should be evicted
        expect(cache.get('key3'), equals('value3'));
        expect(cache.get('key4'), equals('value4'));
      });

      test('should respect maxSize limit', () {
        for (var i = 0; i < 10; i++) {
          cache.put('key$i', 'value$i');
        }

        // Only last 3 items should remain
        expect(cache.size, equals(3));
        expect(cache.get('key7'), equals('value7'));
        expect(cache.get('key8'), equals('value8'));
        expect(cache.get('key9'), equals('value9'));
      });
    });

    group('Statistics', () {
      test('should track cache size', () {
        expect(cache.size, equals(0));

        cache.put('key1', 'value1');
        expect(cache.size, equals(1));

        cache.put('key2', 'value2');
        expect(cache.size, equals(2));

        cache.remove('key1');
        expect(cache.size, equals(1));

        cache.clear();
        expect(cache.size, equals(0));
      });

      test('should list all keys', () {
        cache.put('key1', 'value1');
        cache.put('key2', 'value2');
        cache.put('key3', 'value3');

        final keys = cache.keys;
        expect(keys, containsAll(['key1', 'key2', 'key3']));
        expect(keys.length, equals(3));
      });

      test('should not include expired entries in size', () async {
        cache.put('key1', 'value1');
        cache.put('key2', 'value2');
        expect(cache.size, equals(2));

        // Wait for expiration
        await Future<void>.delayed(const Duration(milliseconds: 1100));

        // Trigger cleanup by accessing
        cache.get('key1');

        // Size should reflect removed expired entry
        expect(cache.size, equals(1));
      });
    });

    group('Edge Cases', () {
      test('should handle empty cache operations', () {
        expect(cache.get('key1'), isNull);
        expect(cache.has('key1'), isFalse);
        expect(cache.size, equals(0));
        expect(cache.keys, isEmpty);

        // Should not throw
        cache.remove('key1');
        cache.clear();
      });

      test('should handle duplicate removes', () {
        cache.put('key1', 'value1');
        cache.remove('key1');
        cache.remove('key1'); // Should not throw

        expect(cache.get('key1'), isNull);
      });

      test('should handle maxSize of 1', () {
        final tinyCache = CacheManager<String>(
          defaultTTL: const Duration(seconds: 1),
          maxSize: 1,
        );

        tinyCache.put('key1', 'value1');
        expect(tinyCache.get('key1'), equals('value1'));

        tinyCache.put('key2', 'value2');
        expect(tinyCache.get('key1'), isNull); // Evicted
        expect(tinyCache.get('key2'), equals('value2'));
        expect(tinyCache.size, equals(1));
      });

      test('should handle complex object types', () {
        final complexCache = CacheManager<Map<String, dynamic>>();
        final data = {
          'id': '123',
          'name': 'Test',
          'nested': {'value': 42},
        };

        complexCache.put('key1', data);
        final retrieved = complexCache.get('key1');

        expect(retrieved, equals(data));
        expect(retrieved?['nested']['value'], equals(42));
      });

      test('should handle zero duration TTL', () {
        cache.put('key1', 'value1', duration: Duration.zero);

        // Should be immediately expired
        expect(cache.get('key1'), isNull);
        expect(cache.has('key1'), isFalse);
      });
    });

    group('Concurrency Safety', () {
      test('should handle rapid sequential puts', () {
        for (var i = 0; i < 100; i++) {
          cache.put('key$i', 'value$i');
        }

        // Should maintain maxSize
        expect(cache.size, lessThanOrEqualTo(3));
      });

      test('should handle mixed operations', () {
        cache.put('key1', 'value1');
        cache.put('key2', 'value2');
        cache.get('key1');
        cache.put('key3', 'value3');
        cache.remove('key2');
        cache.put('key4', 'value4');

        expect(cache.size, lessThanOrEqualTo(3));
      });
    });
  });
}
