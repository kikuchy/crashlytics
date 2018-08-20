package net.kikuchy.crashlytics;

import java.util.List;
import java.util.Map;

public class FlutterException extends Exception {
    public FlutterException(String exception, List<Map<String, String>> stackTrace) {
        super(exception);
        setStackTrace(convertToStackTraceElement(stackTrace));
    }

    public static StackTraceElement[] convertToStackTraceElement(List<Map<String, String>> stackTrace) {
        StackTraceElement[] ret = new StackTraceElement[stackTrace.size()];
        for (int i = 0; i < stackTrace.size(); i++) {
            Map<String, String> s = stackTrace.get(i);
            if (!s.containsKey("lineNumber")) {
                ret[i] = new StackTraceElement(s.get("description"), "", "", 0);
            } else {
                ret[i] = new StackTraceElement(
                        s.get("description"),
                        s.get("methodName"),
                        s.get("fileName"),
                        Integer.parseInt(s.get("lineNumber"))
                );
            }
        }
        return ret;
    }
}
