import 'dart:convert';

typedef JSON = Object?; // Can be Map<String, dynamic> or List<dynamic>

extension SafeJsonParsing on String {
  JSON? parseJson() {
    try {
      final result = jsonDecode(this);
      if (result is Map<String, dynamic> || result is List<dynamic>) {
        return result;
      }
      return null;
    } catch (_) {
      return null;
    }
  }
}

extension StringExtensions on String {
  String format(int chunkSize, {String separator = ' '}) {
    final buffer = StringBuffer();
    for (var i = 0; i < length; i++) {
      buffer.write(this[i]);
      if ((i + 1) % chunkSize == 0 && i + 1 != length) {
        buffer.write(separator);
      }
    }
    return buffer.toString();
  }
}
