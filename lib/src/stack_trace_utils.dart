import 'package:debang/src/models/stack_frame_info.dart';

mixin StackTraceUtils {
  final _debangPattern = RegExp(r'package:debang/');
  final _dartRuntimePattern = RegExp(r'^dart:');
  final _flutterRuntimePattern = RegExp(r'^flutter:');
  final _frameRegex = RegExp(r'#\d+\s+([\w<>.]+(?:\s+[\w<>.]+)*)\s+\((.+):(\d+):(\d+)\)');

  /// Returns the first relevant frame (method, file, line, column)
  /// from [stackTrace], skipping debang and `dart:runtime` frames.
  StackFrameInfo? firstRelevantFrame(StackTrace? stackTrace) {
    if (stackTrace == null) return null;

    final fullTrace = stackTrace.toString();
    final methodMatch = RegExp(r'Method:\s+(.+?)(?=\s*(?:File:|\n#|\Z))', multiLine: true).firstMatch(fullTrace);
    final fileMatch = RegExp(r'File:\s+(.+?):(\d+):(\d+)', multiLine: true).firstMatch(fullTrace);

    if (methodMatch != null && fileMatch != null) {
      final method = methodMatch.group(1)?.trim();
      final fullPath = fileMatch.group(1);
      final file = fullPath?.split('/').last;
      final line = int.tryParse(fileMatch.group(2) ?? '');
      final column = int.tryParse(fileMatch.group(3) ?? '');

      return StackFrameInfo(
        method: method,
        file: file,
        line: line,
        column: column,
      );
    }

    final lines = fullTrace.split('\n');
    RegExpMatch? frame;
    for (final line in lines) {
      if (_debangPattern.hasMatch(line) ||
          _dartRuntimePattern.hasMatch(line) ||
          _flutterRuntimePattern.hasMatch(line)) {
        continue;
      }
      frame = _frameRegex.firstMatch(line);
      if (frame != null) break;
    }

    if (frame == null) return null;

    final method = frame.group(1);
    final file = frame.group(2)?.split('/').last;
    final line = int.tryParse(frame.group(3) ?? '');
    final column = int.tryParse(frame.group(4) ?? '');

    return StackFrameInfo(
      method: method,
      file: file,
      line: line,
      column: column,
    );
  }
}
