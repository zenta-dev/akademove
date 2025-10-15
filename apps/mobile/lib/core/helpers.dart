import 'package:shadcn_flutter/shadcn_flutter.dart';

void noop() {}

Future<void> delay(Duration duration) async {
  await Future.delayed(duration, noop);
}

extension BuildContextExt on BuildContext {
  ThemeData get theme => Theme.of(this);
  bool get isDarkMode => theme.brightness == Brightness.dark;

  Widget buildToast({
    required String title,
    required String message,
  }) {
    return SurfaceCard(
      child: Basic(
        title: Text(title),
        subtitle: Text(message),
        trailingAlignment: Alignment.center,
      ),
    );
  }
}
