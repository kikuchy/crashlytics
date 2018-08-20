#import "CrashlyticsPlugin.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>

@implementation CrashlyticsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [Fabric with:@[[Crashlytics class]]];
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"crashlytics"
            binaryMessenger:[registrar messenger]];
  CrashlyticsPlugin* instance = [[CrashlyticsPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"recordError" isEqualToString:call.method]) {
    NSDictionary *args = (NSDictionary *)call.arguments;
    [self recordError:[args objectForKey:@"exception"] stackTrace:[args objectForKey:@"stackTrace"]];
    result(nil);
  } else {
    result(FlutterMethodNotImplemented);
  }
}

- (void)recordError:(NSString *)exception stackTrace:(NSArray<NSDictionary<NSString *, NSString *> *> *)stackTrace {
  NSMutableArray<CLSStackFrame *> *frames = [NSMutableArray array];
  [stackTrace enumerateObjectsUsingBlock:^(NSDictionary<NSString *, NSString * > *dict, NSUInteger idx, BOOL *stop) {
    CLSStackFrame *frame = [CLSStackFrame stackFrame];
    if ([dict objectForKey:@"lineNumber"] == nil) {
      frame.symbol = [dict objectForKey:@"description"];
    } else {
      frame.fileName = [dict objectForKey:@"fileName"];
      frame.symbol = [dict objectForKey:@"methodName"];
      frame.lineNumber = [[dict objectForKey:@"lineNumber"] intValue];
    }
    [frames addObject:frame];
  }];
  [CrashlyticsKit recordCustomExceptionName:@"FlutterException" reason:exception frameArray:frames];
}

@end
