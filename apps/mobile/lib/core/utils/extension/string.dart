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
