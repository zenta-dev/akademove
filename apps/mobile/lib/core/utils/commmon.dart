import 'dart:async';

void noop() {}

Future<void> delay(
  Duration duration, [
  FutureOr<void> Function()? computation,
]) async {
  await Future.delayed(duration, computation ?? noop);
}
