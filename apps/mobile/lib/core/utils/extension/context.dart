import 'dart:math';

import 'package:akademove/app/_export.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

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

  String formatCurrency(num amount, {Locale? locale, String? symbol}) {
    final locale = read<AppCubit>().state.data?.locale ?? const Locale('id');
    final formatter = NumberFormat.currency(
      locale: locale.toString(),
      symbol: symbol ?? 'Rp ',
      decimalDigits: 0,
    );
    return formatter.format(amount);
  }

  Color get randomColor {
    final colors = [
      colorScheme.primary,
      colorScheme.secondary,
      Colors.red,
      Colors.blue,
      Colors.green,
    ];

    return colors[Random().nextInt(colors.length)];
  }
}
