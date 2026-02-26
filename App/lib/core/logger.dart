enum LogLevel { info, debug, error, warn }

void appLog(String tag, dynamic message, {LogLevel level = LogLevel.info}) {
  final now = DateTime.now();
  final timestamp = "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";

  String color = '\u001b[0m';
  switch (level) {
    case LogLevel.error: color = '\u001b[31m'; break;
    case LogLevel.warn: color = '\u001b[33m'; break;
    case LogLevel.debug: color = '\u001b[34m'; break;
    case LogLevel.info: color = '\u001b[32m'; break;
  }

  final String logMessage = "[$timestamp] $color[${level.name.toUpperCase()}]\u001b[0m $tag: $message";

  print(logMessage);
}