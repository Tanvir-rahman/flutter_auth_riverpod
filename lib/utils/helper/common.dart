import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

//coverage:ignore-start
final log = Logger(
  printer: PrettyPrinter(
    methodCount: 1,
    noBoxingByDefault: true,
  ),
  output: MultiOutput([
    if (kDebugMode) ConsoleOutput(),
    MyConsoleOutput(),
  ]),
  level: kDebugMode ? Level.debug : Level.error,
  filter: DevelopmentFilter(),
);

class MyConsoleOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    for (final line in event.lines) {
      developer.log(
        '${DateTime.now().toIso8601String()} $line',
        name: 'RestoLite',
      );
    }
  }
}
//coverage:ignore-end
