import 'package:shared_preferences/shared_preferences.dart';

enum KeyValueKeys { token }

abstract class KeyValueService {
  Future<T?> get<T>(KeyValueKeys key);
  Future<void> set<T>(KeyValueKeys key, T value);
  Future<void> delete(KeyValueKeys key);
  Future<void> clear();
}

class SharedPrefKeyValueService implements KeyValueService {
  static String _mapKey(KeyValueKeys key) => key.toString();

  @override
  Future<T?> get<T>(KeyValueKeys key) async {
    final prefs = await SharedPreferences.getInstance();
    final mappedKey = _mapKey(key);

    final value = prefs.get(mappedKey);

    if (value == null) return null;

    if (value is T) {
      return value as T;
    }

    throw Exception(
      'Type mismatch for key $mappedKey. '
      'Expected $T but got ${value.runtimeType}.',
    );
  }

  @override
  Future<void> set<T>(KeyValueKeys key, T value) async {
    final prefs = await SharedPreferences.getInstance();
    final mappedKey = _mapKey(key);

    if (value is String) {
      await prefs.setString(mappedKey, value);
    } else if (value is int) {
      await prefs.setInt(mappedKey, value);
    } else if (value is double) {
      await prefs.setDouble(mappedKey, value);
    } else if (value is bool) {
      await prefs.setBool(mappedKey, value);
    } else if (value is List<String>) {
      await prefs.setStringList(mappedKey, value);
    } else {
      throw Exception(
        'Unsupported type ${value.runtimeType} for key $mappedKey',
      );
    }
  }

  @override
  Future<void> delete(KeyValueKeys key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_mapKey(key));
  }

  @override
  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
