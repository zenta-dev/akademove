import 'package:api_client/api_client.dart';
import 'package:built_value/serializer.dart';

extension JsonsSerializer<T> on Serializer<T> {
  Object? toJson<T>(T object) {
    final json = serializers.serializeWith(this, object);
    return json;
  }

  T fromJson<T>(List<dynamic> jsonString) {
    final json = serializers.deserializeWith(this, jsonString);
    if (json == null) throw Exception('Failed to serialize ${T.runtimeType}');
    return json as T;
  }
}
