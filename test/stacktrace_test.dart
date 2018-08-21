import 'package:crashlytics/stacktrace.dart';
import 'package:test/test.dart';

void main() {
  test("stackTraceParser can parse dart stack trace", () {
    final source = new StackTrace.fromString(
        "#0      StandardMethodCodec.decodeEnvelope (package:flutter/src/services/message_codecs.dart:547:7)\n"
        "#1      MethodChannel.invokeMethod (package:flutter/src/services/platform_channel.dart:279:18)\n"
        "<asynchronous suspension>\n"
        "#19     _startIsolate.<anonymous closure> (dart:isolate/runtime/libisolate_patch.dart:279:19)\n"
        "#20     _RawReceivePortImpl._handleMessage (dart:isolate/runtime/libisolate_patch.dart:165:12)\n"
    );
    final exp = [
      {
        "description"     : "0",
        "methodName"      : "StandardMethodCodec.decodeEnvelope",
        "fileName"        : "package:flutter/src/services/message_codecs.dart",
        "lineNumber"      : "547",
        "positionInLine"  : "7",
      }, {
        "description"     : "1",
        "methodName"      : "MethodChannel.invokeMethod",
        "fileName"        : "package:flutter/src/services/platform_channel.dart",
        "lineNumber"      : "279",
        "positionInLine"  : "18",
      }, {
        "description"     : "<asynchronous suspension>"
      }, {
        "description"     : "19",
        "methodName"      : "_startIsolate.<anonymous closure>",
        "fileName"        : "dart:isolate/runtime/libisolate_patch.dart",
        "lineNumber"      : "279",
        "positionInLine"  : "19",
      }, {
        "description"     : "20",
        "methodName"      : "_RawReceivePortImpl._handleMessage",
        "fileName"        : "dart:isolate/runtime/libisolate_patch.dart",
        "lineNumber"      : "165",
        "positionInLine"  : "12",
      }
    ];
    expect(parseStackTrace(source), exp);
  });
}