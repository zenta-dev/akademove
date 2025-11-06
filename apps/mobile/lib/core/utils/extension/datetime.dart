import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;

extension DateTimeExt on DateTime {
  String get orderFormat => DateFormat('d MMM, HH:mm').format(this);
  String format(String format) {
    final dt = tz.TZDateTime.from(this, tz.local);
    return DateFormat(format).format(dt);
  }
}
