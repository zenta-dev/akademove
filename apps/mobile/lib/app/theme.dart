import 'package:shadcn_flutter/shadcn_flutter.dart';

abstract class AppTheme {
  static ThemeData light = ThemeData().copyWith(
    colorScheme: () => ColorSchemes.lightBlue,
    scaling: () => 0.9,
  );
  static ThemeData dark = ThemeData.dark().copyWith(
    colorScheme: () => ColorSchemes.darkBlue,
    scaling: () => 0.9,
  );
}
