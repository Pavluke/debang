import 'package:debang/debang.dart';

/// Defines an observer that is notified whenever a [Debang] exception is created.
///
/// This allows external systems (e.g., loggers, crash reporters, monitoring tools)
/// to react immediately when an error occurs, without modifying the error-throwing code.
///
/// The [call] method provides access to:
/// - [Debang.assertion] — developer's guarantee describing why the value
///   was assumed non-null (the failed assertion message).
/// - [Debang.expectedType] — the generic type [T] that was expected to be non-null.
/// - [Debang.frame] — structured stack frame info (method, file, line, column).
/// - [Debang.stackTrace] — the original stack trace.
abstract interface class DebangObserver {
  /// Called when a [Debang] exception is created, if [Debang.options.shouldNotifyObservers] is true.
  void call(Debang debang);
}
