import 'package:akademove/core/_export.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum KeyValueKeys {
  token,
  fcmToken,
  themeMode,
  locale,
  cart,
  activeOrderId,
  driverActiveOrderId,
}

abstract class KeyValueService {
  Future<T?> get<T>(KeyValueKeys key);
  Future<void> set<T>(KeyValueKeys key, T value);
  Future<void> remove(KeyValueKeys key);
  Future<void> clear();
}

class SharedPrefKeyValueService implements KeyValueService {
  SharedPrefKeyValueService();

  SharedPreferences? _prefs;

  Future<SharedPreferences> _ensurePrefsInitialized() async {
    return _prefs ??= await SharedPreferences.getInstance();
  }

  @override
  Future<T?> get<T>(KeyValueKeys key) async {
    final prefs = await _ensurePrefsInitialized();
    final value = prefs.get(key.index.toString());

    if (value == null) return null;

    if (value is T) {
      return value as T;
    }

    throw ServiceError(
      // ignore: lines_longer_than_80_chars
      'Type mismatch for key "${key.name}". Expected $T but got ${value.runtimeType}.',
      code: ErrorCode.invalidType,
    );
  }

  @override
  Future<void> set<T>(KeyValueKeys key, T value) async {
    final prefs = await _ensurePrefsInitialized();
    final success = switch (value) {
      final String v => await prefs.setString(key.index.toString(), v),
      final int v => await prefs.setInt(key.index.toString(), v),
      final double v => await prefs.setDouble(key.index.toString(), v),
      final bool v => await prefs.setBool(key.index.toString(), v),
      final List<String> v => await prefs.setStringList(
        key.index.toString(),
        v,
      ),
      _ => throw ServiceError(
        'Unsupported type ${value.runtimeType} for key "${key.name}".',
        code: ErrorCode.invalidType,
      ),
    };

    if (!success) {
      throw const ServiceError(
        'Failed to write value to SharedPreferences',
        code: ErrorCode.unknown,
      );
    }
  }

  @override
  Future<void> remove(KeyValueKeys key) async {
    final prefs = await _ensurePrefsInitialized();
    await prefs.remove(key.index.toString());
  }

  @override
  Future<void> clear() async {
    final prefs = await _ensurePrefsInitialized();
    await prefs.clear();
  }
}
