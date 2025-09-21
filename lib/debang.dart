library;

import 'package:debang/models/models.dart';
import 'package:debang/src/debang_impl.dart';

export 'extensions/extensions.dart';
export 'models/debang_observer.dart';

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
abstract class Debang<T> implements Exception {
  /// Creates a new [Debang] error with the given [assertion] description
  /// and an optional original [StackTrace].
  ///
  /// When created, the error notifies all registered observers.
  factory Debang(String assertion, [StackTrace? st]) => DebangImpl(assertion, st);

  /// The developer's assertion (guarantee) describing why this value
  /// was assumed to be non-null at the point of failure.
  String get assertion;

  /// The original [StackTrace] captured at the moment of error creation.
  StackTrace? get stackTrace;

  /// Utility class used to extract and filter stack trace information.
  ///
  /// The first relevant frame extracted from the stack trace.
  /// Provides information about method, file, line and column.
  StackFrameInfo? get frame;

  /// The generic type [T] that was expected to be present but turned out
  /// to be `null`.
  ///
  /// This helps identify what kind of value the developer asserted to
  /// be non-null at the failure point.
  String get expectedType;

  /// Called when a new [Debang] error is created.
  void notifyObservers();

  /// The list of registered observers that listen for [Debang] errors.
  static final List<DebangObserver> _observers = [];

  /// Returns the list of registered [DebangObserver] instances.
  static List<DebangObserver> get observers => _observers;

  /// Default options for customizing the output of a [Debang] exception.
  static DebangOptions options = DebangOptions();
}
