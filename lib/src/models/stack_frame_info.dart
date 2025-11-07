/// Represents a single relevant frame extracted from a [StackTrace].
///
/// This model is used to provide structured information about the
/// source of an error (method, file, line, column).
///
/// All fields are nullable, since not every stack trace frame
/// contains complete information.
///
class StackFrameInfo {
  /// The [method] name where the frame was captured (if available).
  final String? method;

  /// The full [path] to the source file where the frame was captured (if available),
  /// e.g., 'package:app_name/lib/src/main.dart'.
  final String? path;

  /// The short source [file] name where the frame was captured (if available),
  /// e.g., 'main.dart'.
  final String? file;

  /// The [line] number in the source file (if available).
  final int? line;

  /// The [column] number in the source file (if available).
  final int? column;

  /// Creates a new [StackFrameInfo] with the given details.
  const StackFrameInfo({
    this.method,
    this.path,
    this.file,
    this.line,
    this.column,
  });

  /// Returns a formatted string representing the full path with line and column,
  /// e.g., 'package:app_name/lib/src/main.dart 3:10'.
  String? get fullPathLocation {
    if (path == null) return null;
    final loc = '${line ?? ''}:${column ?? ''}';
    return '$path ${loc.isNotEmpty ? loc : ''}'.trim();
  }

  @override
  String toString() =>
      'StackFrameInfo(method: $method, fullPath: $path, file: $file, line: $line, column: $column)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StackFrameInfo &&
          runtimeType == other.runtimeType &&
          method == other.method &&
          path == other.path &&
          file == other.file &&
          line == other.line &&
          column == other.column;

  @override
  int get hashCode => Object.hash(method, path, file, line, column);
}
