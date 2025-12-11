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

    //Future<BannerCreate201Response> bannerCreate(BannerCreateRequest bannerCreateRequest) async
    test('test bannerCreate', () async {
      // TODO
    });

    //Future<BannerDelete200Response> bannerDelete(String id) async
    test('test bannerDelete', () async {
      // TODO
    });

    //Future<BannerCreate201Response> bannerGet(String id) async
    test('test bannerGet', () async {
      // TODO
    });

    //Future<BannerList200Response> bannerList({ String cursor, Object limit, String direction, Object page, String query, String sortBy, PaginationOrder order, PaginationMode mode, String placement, String targetAudience, bool isActive, String search }) async
    test('test bannerList', () async {
      // TODO
    });

    //Future<BannerListPublic200Response> bannerListPublic({ String placement }) async
    test('test bannerListPublic', () async {
      // TODO
    });

    //Future<BannerCreate201Response> bannerToggleActive(String id) async
    test('test bannerToggleActive', () async {
      // TODO
    });

    //Future<BannerCreate201Response> bannerUpdate(String id, BannerUpdateRequest bannerUpdateRequest) async
    test('test bannerUpdate', () async {
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
