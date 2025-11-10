import 'dart:async';

void noop() {}

Future<void> delay(
  Duration duration, [
  FutureOr<void> Function()? computation,
]) async {
  await Future.delayed(duration, computation ?? noop);
}

String getMethodName() {
  try {
    throw Exception();
    // ignore: avoid_catches_without_on_clauses this intended like this
  } catch (e, stack) {
    final traceString = stack.toString().split('\n')[1];
    final match = RegExp(
      r'#1\s+[A-Za-z0-9_<>.]+\.(\w+)',
    ).firstMatch(traceString);
    return match?.group(1) ?? 'Unknown';
  }
}

String getClassName() {
  try {
    throw Exception();
  } catch (e, stack) {
    final traceString = stack.toString().split('\n')[1];
    final match = RegExp(r'#1\s+([A-Za-z0-9_<>]+)\.').firstMatch(traceString);
    return match?.group(1) ?? 'Unknown';
  }
}
