import 'package:logger/logger.dart';

class AppLogger {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.none,
    ),
    filter: ProductionFilter(),
    level: Level.debug,
  );

  static void trace(String message) {
    _logger.t(message);
  }

  static void debug(String message) {
    _logger.d(message);
  }

  static void info(String message) {
    _logger.i(message);
  }

  static void warning(String message, {dynamic error}) {
    _logger.w(message, error: error);
  }

  static void error(String message, {dynamic error, StackTrace? stackTrace}) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }

  static void fatal(String message, {dynamic error, StackTrace? stackTrace}) {
    _logger.f(message, error: error, stackTrace: stackTrace);
  }

  /// Logs detailed information about a network request and response.
  static void network({
    required String method,
    required String url,
    dynamic request,
    dynamic response,
    int? statusCode,
    Duration? duration,
  }) {
    _logger.i(
      '''
🚀 Network Request
┌────────────────────────────────────────────────────────────
│ Method: $method
│ URL: $url
│ Status: $statusCode
│ Duration: ${duration?.inMilliseconds}ms
├────────────────────────────────────────────────────────────
│ Request: $request
├────────────────────────────────────────────────────────────
│ Response: $response
└────────────────────────────────────────────────────────────
      ''',
    );
  }
}
