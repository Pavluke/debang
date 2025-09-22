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

  /// The source [file] where the frame was captured (if available).
  final String? file;

  /// The [line] number in the source file (if available).
  final int? line;

  /// The [column] number in the source file (if available).
  final int? column;

  /// Creates a new [StackFrameInfo] with the given details.
  const StackFrameInfo({this.method, this.file, this.line, this.column});

  @override
  String toString() => 'StackFrameInfo(method: $method, file: $file, line: $line, column: $column)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StackFrameInfo &&
          runtimeType == other.runtimeType &&
          method == other.method &&
          file == other.file &&
          line == other.line &&
          column == other.column;

  @override
  int get hashCode => Object.hash(method, file, line, column);
}
