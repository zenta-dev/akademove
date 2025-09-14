import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for DriverApi
void main() {
  final instance = ApiClient().getDriverApi();

  group(DriverApi, () {
    //Future<CreateDriverSuccessResponse> createDriver({ CreateDriverRequest createDriverRequest }) async
    test('test createDriver', () async {
      // TODO
    });

    //Future<DeleteDriverSuccessResponse> deleteDriver(String id) async
    test('test deleteDriver', () async {
      // TODO
    });

    //Future<GetAllDriverSuccessResponse> getAllDriver(int page, int limit, { String cursor }) async
    test('test getAllDriver', () async {
      // TODO
    });

    //Future<GetDriverByIdSuccessResponse> getDriverById(String id, bool fromCache) async
    test('test getDriverById', () async {
      // TODO
    });

    //Future<UpdateDriverSuccessResponse> updateDriver(String id, { UpdateDriverRequest updateDriverRequest }) async
    test('test updateDriver', () async {
      // TODO
    });

  });
}
