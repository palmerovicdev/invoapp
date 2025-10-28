import 'package:flutter/foundation.dart';

void logMessage(String type, String value, String color) {
  if (!kDebugMode) return;

  var trace = StackTrace.current.toString().split('\n');
  if (trace.length > 1) {
    var relevantTrace = trace[2];
    var match = RegExp(r'#\d+\s+(.+?)\s+\((.+?)\)').firstMatch(relevantTrace);

    if (match != null) {
      var location = match.group(1) ?? "Unknown";
      if (kDebugMode) {
        print('\n ');
      }
      debugPrint('[$type] $location -> $value');
      if (kDebugMode) {
        print('\n ');
      }
      return;
    }
  }
  if (kDebugMode) {
    print('\n ');
  }
  debugPrint('[$type] Unknown -> $value');
  if (kDebugMode) {
    print('\n ');
  }
}

void logI(String value) => logMessage("INFO", value, '');

void logE(String value) => logMessage("ERROR", value, '');

void logW(String value) => logMessage("WARNING", value, '');

void logS(String value) => logMessage("SUCCESS", value, '');
