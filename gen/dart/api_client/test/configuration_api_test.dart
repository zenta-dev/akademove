import 'package:test/test.dart';
import 'package:api_client/api_client.dart';

/// tests for ConfigurationApi
void main() {
  final instance = ApiClient().getConfigurationApi();

  group(ConfigurationApi, () {
    //Future<AuditList200Response> auditList({ String cursor, Object limit, String direction, Object page, String query, String sortBy, PaginationOrder order, PaginationMode mode, String tableName, String recordId, String operation, String updatedById, DateTime startDate, DateTime endDate }) async
    test('test auditList', () async {
      // TODO
    });

    //Future<ConfigurationGet200Response> configurationGet(String key) async
    test('test configurationGet', () async {
      // TODO
    });

    //Future<ConfigurationGetBusinessConfig200Response> configurationGetBusinessConfig() async
    test('test configurationGetBusinessConfig', () async {
      // TODO
    });

    //Future<ConfigurationList200Response> configurationList({ String cursor, Object limit, String direction, Object page, String query, String sortBy, PaginationOrder order, PaginationMode mode }) async
    test('test configurationList', () async {
      // TODO
    });

    //Future<ConfigurationGet200Response> configurationUpdate(String key, UpdateConfiguration updateConfiguration) async
    test('test configurationUpdate', () async {
      // TODO
    });
  });
}
