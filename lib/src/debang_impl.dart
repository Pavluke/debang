import 'package:debang/debang.dart';
import 'package:debang/models/stack_frame_info.dart';
import 'package:debang/src/stack_trace_utils.dart';

/// A custom error type that provides additional context
/// (such as method, file, line, filtered stack trace) and notifies
/// observers when it is created.
///
/// This class is useful when you want to enrich exceptions with
/// more details about their origin, while also giving external
/// code the ability to listen to and react to errors.
///
/// Usage:
/// ```dart
/// throw Debang('Unexpected null value');
/// ```
class DebangImpl<T> with StackTraceUtils implements Debang<T> {
  @override
  final String assertion;

  @override
  late final StackTrace? stackTrace;

  @override
  late final StackFrameInfo? frame;

  /// Creates a new [DebangImpl] error with the given [assertion] description
  /// and an optional original [StackTrace].
  ///
  /// When created, the error notifies all registered observers.
  DebangImpl(this.assertion, [StackTrace? st]) {
    stackTrace = st ?? StackTrace.current;
    frame = firstRelevantFrame(stackTrace);
    if (Debang.options.shouldNotifyObservers) {
      notifyObservers();
    }
  }

  @override
  String get expectedType => T.toString();

  @override
  void notifyObservers() {
    for (final observer in Debang.observers) {
      observer(this);
    }
  }

  String _buildLog() {
    final buffer = StringBuffer();
    final options = Debang.options;
    buffer.writeln('This exception occurred because a `Debang` assertion failed');
    buffer.writeln('Assertion: $assertion');
    if (options.showExpected && T != dynamic) buffer.writeln('Expected:  $expectedType');

    if (frame case final f?) {
      if (f.method != null && options.showMethod) {
        buffer.writeln('Method:    ${f.method}');
      }
      if (f.file != null && options.showFile) {
        buffer.writeln('File:      ${f.file}:${f.line}:${f.column}');
      }
    }

    return buffer.toString();
  }

  @override
  String toString() => _buildLog();
}
