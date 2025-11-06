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

    //Future<ConfigurationList200Response> configurationList({ String cursor, Object limit, Object page, String query, String sortBy, String order }) async
    test('test configurationList', () async {
      // TODO
    });

    //Future<ConfigurationGet200Response> configurationUpdate(String key, UpdateConfiguration updateConfiguration) async
    test('test configurationUpdate', () async {
      // TODO
    });
  });
}
