import 'package:shadcn_flutter/shadcn_flutter.dart';

void noop() {}

Future<void> delay(Duration duration) async {
  await Future.delayed(duration, noop);
}

extension BuildContextExt on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => theme.colorScheme;
  Typography get typography => theme.typography;

  bool get isDarkMode => theme.brightness == Brightness.dark;

  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get mediaQuerySize => mediaQuery.size;

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
