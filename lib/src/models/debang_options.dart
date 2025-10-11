/// Options for customizing the output of a [Debang] exception.
class DebangOptions {
  /// Whether to show the expected value type in the exception output.
  final bool showExpected;

  /// Whether to show the method name in the exception output.
  final bool showMethod;

  /// Whether to show the file information in the exception output.
  final bool showFile;

  /// Whether to show the full stack trace in the exception output.
  /// Defaults to `false` to avoid verbose logs by default.
  final bool showStackTrace;

  /// Whether to notify observers when the exception is created.
  final bool shouldNotifyObservers;

  /// Creates a new instance of [DebangOptions].
  ///
  /// All parameters are optional and default to sensible values:
  /// - [showExpected] determines whether to show the expected value type (default: true).
  /// - [showMethod] determines whether to show the method name (default: true).
  /// - [showFile] determines whether to show the file information (default: true).
  /// - [showStackTrace] determines whether to include the full stack trace (default: false, to keep logs concise).
  /// - [shouldNotifyObservers] determines whether to notify observers when the exception is created (default: true).
  DebangOptions({
    this.showExpected = true,
    this.showMethod = true,
    this.showFile = true,
    this.showStackTrace = false,
    this.shouldNotifyObservers = true,
  });

  /// Creates a copy of this [DebangOptions] with the given fields replaced
  /// with the new values. Unspecified fields retain their original values.
  ///
  /// Example:
  /// ```dart
  /// final updated = options.copyWith(showStackTrace: true);
  /// ```
  DebangOptions copyWith({
    bool? showExpected,
    bool? showMethod,
    bool? showFile,
    bool? showStackTrace,
    bool? shouldNotifyObservers,
  }) {
    return DebangOptions(
      showExpected: showExpected ?? this.showExpected,
      showMethod: showMethod ?? this.showMethod,
      showFile: showFile ?? this.showFile,
      showStackTrace: showStackTrace ?? this.showStackTrace,
      shouldNotifyObservers: shouldNotifyObservers ?? this.shouldNotifyObservers,
    );
  }

  /// Returns a string representation of the options.
  @override
  String toString() {
    return 'DebangOptions('
        'showExpected: $showExpected, '
        'showMethod: $showMethod, '
        'showFile: $showFile, '
        'showStackTrace: $showStackTrace, '
        'shouldNotifyObservers: $shouldNotifyObservers)';
  }

  /// Checks if this [DebangOptions] is equal to another object.
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DebangOptions &&
          runtimeType == other.runtimeType &&
          showExpected == other.showExpected &&
          showMethod == other.showMethod &&
          showFile == other.showFile &&
          showStackTrace == other.showStackTrace &&
          shouldNotifyObservers == other.shouldNotifyObservers;

  /// Returns a hash code for this [DebangOptions].
  @override
  int get hashCode =>
      showExpected.hashCode ^
      showMethod.hashCode ^
      showFile.hashCode ^
      showStackTrace.hashCode ^
      shouldNotifyObservers.hashCode;
}
