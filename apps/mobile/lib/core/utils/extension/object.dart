import 'dart:convert';

extension JsonPrettify on Object {
  String toPrettyJson({int indent = 2}) {
    try {
      final encoder = JsonEncoder.withIndent(' ' * indent);
      return encoder.convert(this);
    } catch (e) {
      return toString();
    }
  }
}
