import 'dart:developer' as developer;

class DebugLogger {
  static void log(String message) {
    developer.log(message, name: "DEBUG_LOG");
  }
}
