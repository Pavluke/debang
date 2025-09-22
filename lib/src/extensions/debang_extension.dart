import '../../debang.dart';

// Extension for convenient null checking.
extension DebangExtension<T> on T? {
  /// Returns the non-null value or throws a [Debang] exception.
  ///
  /// If the value is null, a [Debang] exception is thrown with the provided [assertion].
  /// The [assertion] is a required description of the guarantee or assumption made
  /// by the developer about why this value must not be null.
  ///
  /// This makes null-safety violations explicit and self-documented.
  ///
  /// Example:
  /// ```dart
  /// String? value = Random().nextBool()? 'Hello!': null;
  /// String newValue = value.debang(
  ///   'newValue is guaranteed to be non-null because it is initialized earlier'
  /// );
  /// ```
  T debang(String assertion, [StackTrace? st]) => this ?? (throw Debang<T>(assertion, st ?? StackTrace.current));
}
