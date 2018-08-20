List<Map<String, String>> parseStackTrace(StackTrace stackTrace) {
  final linePattern = RegExp(r"#(\d+)\s+(.+?)\s\(([^:]+:[^:]+):(\d+):(\d+)\)");
  return stackTrace.toString().trim().split("\n").map((line) {
    if (line == "<asynchronous suspension>") {
      return {
        "description": line,
      };
    } else {
      final match = linePattern.firstMatch(line);
      if (match == null) {
        throw FormatException("Unknown format of StackTrace. : $line");
      }
      return <String, String>{
        "description": match.group(1),
        "methodName": match.group(2),
        "fileName": match.group(3),
        "lineNumber": match.group(4),
        "positionInLine": match.group(5),
      };
    }
  }).toList();
}
