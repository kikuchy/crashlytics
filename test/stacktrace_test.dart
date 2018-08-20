import 'package:test/test.dart';
import 'package:crashlytics/stacktrace.dart';

void main() {
  test("stackTraceParser can parse dart stack trace", () {
    final actual = StackTrace.fromString(
        "#0      StandardMethodCodec.decodeEnvelope (package:flutter/src/services/message_codecs.dart:547:7)\n"
        "#1      MethodChannel.invokeMethod (package:flutter/src/services/platform_channel.dart:279:18)\n"
        "<asynchronous suspension>\n"
        "#19     _startIsolate.<anonymous closure> (dart:isolate/runtime/libisolate_patch.dart:279:19)\n"
        "#20     _RawReceivePortImpl._handleMessage (dart:isolate/runtime/libisolate_patch.dart:165:12)\n"
//        "#2      Crashlytics.sendError (package:crashlytics/crashlytics.dart:15:14)\n"
//        "<asynchronous suspension>\n"
//        "#3      main.<anonymous closure> (file:///Users/kikuchy/dev/diverse/crashlytics/example/lib/main.dart:9:17)\n"
//        "#4      FlutterError.reportError (package:flutter/src/foundation/assertions.dart:408:14)\n"
//        "#5      _debugReportException (package:flutter/src/widgets/framework.dart:4794:16)\n"
//        "#6      ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:3645:35)\n"
//        "#7      Element.rebuild (package:flutter/src/widgets/framework.dart:3495:5)\n"
//        "#8      BuildOwner.buildScope (package:flutter/src/widgets/framework.dart:2242:33)\n"
//        "#9      _WidgetsFlutterBinding&BindingBase&GestureBinding&ServicesBinding&SchedulerBinding&PaintingBinding&RendererBinding&WidgetsBinding.drawFrame (package:flutter/src/widgets/binding.dart:626:20)\n"
//        "#10     _WidgetsFlutterBinding&BindingBase&GestureBinding&ServicesBinding&SchedulerBinding&PaintingBinding&RendererBinding._handlePersistentFrameCallback (package:flutter/src/rendering/binding.dart:208:5)\n"
//        "#11     _WidgetsFlutterBinding&BindingBase&GestureBinding&ServicesBinding&SchedulerBinding._invokeFrameCallback (package:flutter/src/scheduler/binding.dart:990:15)\n"
//        "#12     _WidgetsFlutterBinding&BindingBase&GestureBinding&ServicesBinding&SchedulerBinding.handleDrawFrame (package:flutter/src/scheduler/binding.dart:930:9)\n"
//        "#13     _WidgetsFlutterBinding&BindingBase&GestureBinding&ServicesBinding&SchedulerBinding._handleDrawFrame (package:flutter/src/scheduler/binding.dart:842:5)\n"
//        "#14     _rootRun (dart:async/zone.dart:1126:13)\n"
//        "#15     _CustomZone.run (dart:async/zone.dart:1023:19)\n"
//        "#16     _CustomZone.runGuarded (dart:async/zone.dart:925:7)\n"
//        "#17     _invoke (dart:ui/hooks.dart:122:10)\n"
//        "#18     _drawFrame (dart:ui/hooks.dart:109:3)"
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
    expect(parseStackTrace(actual), exp);
  });

  test("trim can erase newline", () {
    expect("hoge\nfuga\n".trim().split("\n"), ["hoge", "fuga"]);
  });
}