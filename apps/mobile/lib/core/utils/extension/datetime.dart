import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;

extension DateTimeExt on DateTime {
  /// Formats the date for order display, converting to local timezone first
  String get orderFormat => DateFormat('d MMM, HH:mm').format(toLocal());

  /// Formats the date with custom format, converting to local timezone first
  String format(String format) {
    final dt = tz.TZDateTime.from(this, tz.local);
    return DateFormat(format).format(dt);
  }
}
