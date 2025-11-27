import 'dart:developer';

import 'package:logger/logger.dart';

final logger = Logger(
  printer: PrettyPrinter(
    lineLength: 100,
    dateTimeFormat: DateTimeFormat.onlyTime,
  ),
  output: _PrintOutput(),
);

class _PrintOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    event.lines.forEach(log);
  }
}
