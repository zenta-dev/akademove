import 'package:flutter/material.dart';

void noop() {}

Future<void> delay(Duration duration) async {
  await Future.delayed(duration, noop);
}

extension BuildContextExt on BuildContext {
  ThemeData get theme => Theme.of(this);
  bool get isDarkMode => theme.brightness == Brightness.dark;
}
