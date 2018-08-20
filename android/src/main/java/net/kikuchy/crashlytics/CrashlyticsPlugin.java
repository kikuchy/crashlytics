package net.kikuchy.crashlytics;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import com.crashlytics.android.Crashlytics;
import io.fabric.sdk.android.Fabric;

import java.util.List;
import java.util.Map;

/** CrashlyticsPlugin */
public class CrashlyticsPlugin implements MethodCallHandler {
  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    Fabric.with(registrar.activity(), new Crashlytics());
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "crashlytics");
    channel.setMethodCallHandler(new CrashlyticsPlugin());
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    if (call.method.equals("recordError")) {
      recordError((String) call.argument("exception"), (List<Map<String, String>>) call.argument("stackTrace"));
      result.success(null);
    } else {
      result.notImplemented();
    }
  }

  private void recordError(String exception, List<Map<String, String>> stackTrace) {
    Crashlytics.logException(new FlutterException(exception, stackTrace));
  }
}
