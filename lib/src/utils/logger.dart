import 'package:logger/logger.dart';

/// Centralized, formatted application logging.
///
/// Initialize this service once during startup with [init]. A lazy fallback is
/// retained so logging never silently disappears if a call happens earlier.
class AppLogger {
  AppLogger._();

  static Logger? _logger;

  static Logger get _instance => _logger ??= _createLogger();

  /// Initializes or resets the application logger.
  static void init() {
    _logger = _createLogger();
  }

  static Logger _createLogger() {
    return Logger(
      filter: DevelopmentFilter(),
      printer: PrettyPrinter(
        methodCount: 0,
        errorMethodCount: 8,
        lineLength: 120,
        colors: true,
        printEmojis: true,
        dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
      ),
    );
  }

  /// Detailed information useful while developing and diagnosing behavior.
  static void debug(String message) {
    _instance.d(message);
  }

  /// General information about application flow.
  static void info(String message) {
    _instance.i(message);
  }

  /// A successful operation worth highlighting during development.
  static void success(String message) {
    _instance.i('✅ $message');
  }

  /// A potentially harmful or unexpected situation.
  static void warning(String message) {
    _instance.w(message);
  }

  /// A recoverable error that may allow the application to continue.
  static void error(
    String message, [
    Object? error,
    StackTrace? stackTrace,
  ]) {
    _instance.e(message, error: error, stackTrace: stackTrace);
  }

  /// The most detailed trace-level diagnostic information.
  static void verbose(String message) {
    _instance.t(message);
  }

  /// A fatal condition that should never occur.
  static void wtf(
    String message, [
    Object? error,
    StackTrace? stackTrace,
  ]) {
    _instance.f(message, error: error, stackTrace: stackTrace);
  }
}

void logDebug(String message) => AppLogger.debug(message);
void logInfo(String message) => AppLogger.info(message);
void logSuccess(String message) => AppLogger.success(message);
void logWarning(String message) => AppLogger.warning(message);
void logError(
  String message, [
  Object? error,
  StackTrace? stackTrace,
]) =>
    AppLogger.error(message, error, stackTrace);
