/// Returns a safe substring of [str] from [start] to [end].
///
/// If [str] is empty, returns empty string.
/// If [start] is greater than the string length, returns empty string.
/// If [end] is null or greater than string length, uses string length as end.
///
/// Example:
/// ```dart
/// safeSubstring('hello', 0, 3) // Returns 'hel'
/// safeSubstring('hi', 0, 10) // Returns 'hi'
/// safeSubstring('', 0, 5) // Returns ''
/// ```
String safeSubstring(String str, int start, [int? end]) {
  if (str.isEmpty) return str;
  if (start >= str.length) return '';

  final actualStart = start < 0 ? 0 : start;
  final actualEnd = end == null
      ? str.length
      : (end > str.length ? str.length : end);

  if (actualStart >= actualEnd) return '';

  return str.substring(actualStart, actualEnd);
}

/// Returns the first [length] characters of [str], or the entire string
/// if it's shorter than [length].
///
/// Example:
/// ```dart
/// safePrefix('hello', 3) // Returns 'hel'
/// safePrefix('hi', 10) // Returns 'hi'
/// safePrefix('', 5) // Returns ''
/// ```
String safePrefix(String str, int length) {
  if (str.isEmpty || length <= 0) return '';
  return str.length <= length ? str : str.substring(0, length);
}

/// Returns the first character of [str], or empty string if [str] is empty.
///
/// Useful for avatar initials.
///
/// Example:
/// ```dart
/// safeFirstChar('Hello') // Returns 'H'
/// safeFirstChar('') // Returns ''
/// ```
String safeFirstChar(String str) {
  return str.isEmpty ? '' : str[0];
}

/// Truncates [str] to [maxLength] and appends [ellipsis] if truncated.
///
/// Example:
/// ```dart
/// truncateWithEllipsis('Hello World', 8) // Returns 'Hello...'
/// truncateWithEllipsis('Hi', 10) // Returns 'Hi'
/// ```
String truncateWithEllipsis(
  String str,
  int maxLength, {
  String ellipsis = '...',
}) {
  if (str.isEmpty || maxLength <= 0) return '';
  if (str.length <= maxLength) return str;

  final truncatedLength = maxLength - ellipsis.length;
  if (truncatedLength <= 0) return ellipsis.substring(0, maxLength);

  return '${str.substring(0, truncatedLength)}$ellipsis';
}

/// Extension methods for safe string operations
extension SafeStringExtension on String {
  /// Safe substring that handles bounds checking
  String safe(int start, [int? end]) => safeSubstring(this, start, end);

  /// Get the first [length] characters safely
  String prefix(int length) => safePrefix(this, length);

  /// Get the first character safely
  String get firstChar => safeFirstChar(this);

  /// Truncate with ellipsis
  String truncate(int maxLength, {String ellipsis = '...'}) =>
      truncateWithEllipsis(this, maxLength, ellipsis: ellipsis);
}

/// Extension methods for nullable strings
extension SafeNullableStringExtension on String? {
  /// Safe substring that handles null and bounds checking
  String safe(int start, [int? end]) {
    if (this == null) return '';
    return safeSubstring(this!, start, end);
  }

  /// Get the first [length] characters safely, returns empty if null
  String prefix(int length) {
    if (this == null) return '';
    return safePrefix(this!, length);
  }

  /// Get the first character safely, returns empty if null
  String get firstChar {
    if (this == null) return '';
    return safeFirstChar(this!);
  }
}
