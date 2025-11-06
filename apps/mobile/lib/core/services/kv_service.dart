import 'package:akademove/core/_export.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum KeyValueKeys { token }

abstract class KeyValueService extends BaseService {
  Future<T?> get<T>(KeyValueKeys key);
  Future<void> set<T>(KeyValueKeys key, T value);
  Future<void> remove(KeyValueKeys key);
  Future<void> clear();
}

class SharedPrefKeyValueService implements KeyValueService {
  SharedPrefKeyValueService();

  late final SharedPreferences _prefs;

  @override
  Future<KeyValueService> setup() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  @override
  void teardown() {}

  @override
  Future<T?> get<T>(KeyValueKeys key) async {
    final value = _prefs.get(key.name);

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
    final success = switch (value) {
      final String v => await _prefs.setString(key.name, v),
      final int v => await _prefs.setInt(key.name, v),
      final double v => await _prefs.setDouble(key.name, v),
      final bool v => await _prefs.setBool(key.name, v),
      final List<String> v => await _prefs.setStringList(key.name, v),
      _ => throw ServiceError(
        'Unsupported type ${value.runtimeType} for key "${key.name}".',
        code: ErrorCode.invalidType,
      ),
    };

    if (success == false) {
      throw const ServiceError(
        'Failed to write value to SharedPreferences',
        code: ErrorCode.unknown,
      );
    }
  }

  @override
  Future<void> remove(KeyValueKeys key) async {
    await _prefs.remove(key.name);
  }

  @override
  Future<void> clear() async {
    await _prefs.clear();
  }
}
