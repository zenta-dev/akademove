import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for ConfigurationApi
void main() {
  final instance = ApiClient().getConfigurationApi();

  group(ConfigurationApi, () {
    //Future<ConfigurationGet200Response> configurationGet(String key) async
    test('test configurationGet', () async {
      // TODO
    });

    //Future<ConfigurationList200Response> configurationList({ String cursor, JsonObject page, JsonObject limit }) async
    test('test configurationList', () async {
      // TODO
    });

    //Future<ConfigurationGet200Response> configurationUpdate(String key, ConfigurationUpdateRequest configurationUpdateRequest) async
    test('test configurationUpdate', () async {
      // TODO
    });

  });
}
