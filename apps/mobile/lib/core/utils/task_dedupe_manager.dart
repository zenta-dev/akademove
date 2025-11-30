import 'dart:async';
import 'dart:isolate';

/// A manager that prevents duplicate execution of tasks with the same key.
/// If multiple requests come in for the same task, they all wait for and share
/// the result of a single execution.
class TaskDedupeManager {
  TaskDedupeManager({Duration? timeout}) : _timeout = timeout;
  final Map<String, Future<dynamic>> _activeTasks = {};
  final Duration? _timeout;

  Future<T> execute<T>(String key, FutureOr<T> Function() task) async {
    if (_activeTasks.containsKey(key)) {
      return _activeTasks[key]! as Future<T>;
    }

    final completer = Completer<T>();

    _activeTasks[key] = completer.future;

    try {
      final resultOrFuture = task();

      final T result;
      if (resultOrFuture is Future<T>) {
        result = _timeout != null
            ? await resultOrFuture.timeout(_timeout)
            : await resultOrFuture;
      } else {
        result = resultOrFuture;
      }

      completer.complete(result);
      return result;
    } catch (e, stackTrace) {
      completer.completeError(e, stackTrace);
      rethrow;
    } finally {
      Future.delayed(const Duration(milliseconds: 10), () async {
        await _activeTasks.remove(key);
      });
    }
  }

  Future<T> executeInIsolate<T>(String key, FutureOr<T> Function() task) async {
    if (_activeTasks.containsKey(key)) {
      return _activeTasks[key]! as Future<T>;
    }

    final completer = Completer<T>();

    _activeTasks[key] = completer.future;

    try {
      final result = await _runInIsolate<T>(task, _timeout);
      completer.complete(result);
      return result;
    } catch (e, stackTrace) {
      completer.completeError(e, stackTrace);
      rethrow;
    } finally {
      Future.delayed(const Duration(milliseconds: 10), () async {
        await _activeTasks.remove(key);
      });
    }
  }

  Future<T> executeWithCache<T>(
    String key,
    FutureOr<T> Function() task, {
    Duration cacheDuration = const Duration(minutes: 5),
  }) async {
    return _CachedTaskDedupeManager._instance.execute(key, task, cacheDuration);
  }

  Future<T> executeInIsolateWithCache<T>(
    String key,
    FutureOr<T> Function() task,
    Duration cacheDuration,
  ) async {
    return _CachedTaskDedupeManager._instance.execute(
      key,
      task,
      cacheDuration,
      useIsolate: true,
    );
  }

  static Future<T> _runInIsolate<T>(
    FutureOr<T> Function() task,
    Duration? timeout,
  ) async {
    final receivePort = ReceivePort();

    try {
      await Isolate.spawn(
        _isolateEntryPoint<T>,
        _IsolateParams(sendPort: receivePort.sendPort, task: task),
      );

      final resultFuture = receivePort.first.then((result) {
        if (result is _IsolateError) {
          throw result.error;
        }
        return result as T;
      });

      if (timeout != null) {
        return await resultFuture.timeout(timeout);
      }

      return await resultFuture;
    } finally {
      receivePort.close();
    }
  }

  static Future<void> _isolateEntryPoint<T>(_IsolateParams<T> params) async {
    try {
      final resultOrFuture = params.task();

      final result = resultOrFuture is Future<T>
          ? await resultOrFuture
          : resultOrFuture;

      params.sendPort.send(result);
    } catch (e, stackTrace) {
      params.sendPort.send(_IsolateError(e as Exception, stackTrace));
    }
  }

  bool isRunning(String key) => _activeTasks.containsKey(key);

  int get activeTaskCount => _activeTasks.length;

  void cancelAll() {
    _activeTasks.clear();
  }

  Future<T?> waitFor<T>(String key) async {
    if (_activeTasks.containsKey(key)) {
      try {
        return await _activeTasks[key] as T;
      } catch (_) {
        return null;
      }
    }
    return null;
  }

  void clearCache() {
    _CachedTaskDedupeManager._instance.clearCache();
  }

  void clearCacheFor(String key) {
    _CachedTaskDedupeManager._instance.clearCacheFor(key);
  }
}

/// Internal class for managing cached task results
class _CachedTaskDedupeManager {
  _CachedTaskDedupeManager._();
  static final _CachedTaskDedupeManager _instance =
      _CachedTaskDedupeManager._();

  final Map<String, _CachedResult> _cache = {};
  final Map<String, Future<dynamic>> _activeTasks = {};

  Future<T> execute<T>(
    String key,
    FutureOr<T> Function() task,
    Duration cacheDuration, {
    bool useIsolate = false,
  }) async {
    if (_cache.containsKey(key)) {
      final cached = _cache[key]!;
      if (DateTime.now().isBefore(cached.expiresAt)) {
        return cached.result as T;
      } else {
        _cache.remove(key);
      }
    }

    if (_activeTasks.containsKey(key)) {
      return _activeTasks[key]! as Future<T>;
    }

    final completer = Completer<T>();
    _activeTasks[key] = completer.future;

    try {
      final T result;

      if (useIsolate) {
        result = await TaskDedupeManager._runInIsolate<T>(task, null);
      } else {
        final resultOrFuture = task();

        if (resultOrFuture is Future<T>) {
          result = await resultOrFuture;
        } else {
          result = resultOrFuture;
        }
      }

      _cache[key] = _CachedResult(
        result: result,
        expiresAt: DateTime.now().add(cacheDuration),
      );

      completer.complete(result);
      return result;
    } catch (e, stackTrace) {
      completer.completeError(e, stackTrace);
      rethrow;
    } finally {
      Future.delayed(const Duration(milliseconds: 10), () async {
        await _activeTasks.remove(key);
      });
    }
  }

  void clearCache() => _cache.clear();

  void clearCacheFor(String key) => _cache.remove(key);
}

class _CachedResult {
  _CachedResult({required this.result, required this.expiresAt});
  final dynamic result;
  final DateTime expiresAt;
}

/// Parameters for isolate communication
class _IsolateParams<T> {
  _IsolateParams({required this.sendPort, required this.task});

  final SendPort sendPort;
  final FutureOr<T> Function() task;
}

/// Error wrapper for isolate communication
class _IsolateError {
  _IsolateError(this.error, [this.stackTrace]);
  final Exception error;
  final StackTrace? stackTrace;
}
