import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:crashlytics/stacktrace.dart';

class Crashlytics {
  static const MethodChannel _channel =
      const MethodChannel('crashlytics');

  static _onError(FlutterErrorDetails details) {
    Crashlytics.recordError(details.exception, details.stack);
  }

  /// Setup Crashlytics library to catch uncaught exceptions.
  /// Call this before [runApp].
  /// Don't call this function twice. If call it twice, the single exception will be reported to Crashlytics twice.
  static setup() {
    if (FlutterError.onError != null) {
      final original = FlutterError.onError;
      FlutterError.onError = (FlutterErrorDetails details) {
        original(details);
        Crashlytics._onError(details);
      };
    } else {
      FlutterError.onError = Crashlytics._onError;
    }
  }

  /// Report an exception and a StackTrace to Crashlytics.
  static Future<void> recordError(Exception exception, StackTrace stackTrace) async {
    _channel.invokeMethod(
        "recordError", {
          "exception" : exception.toString(),
          "stackTrace" : parseStackTrace(stackTrace),
    });
  }
}
