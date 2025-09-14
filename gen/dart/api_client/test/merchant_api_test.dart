import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for MerchantApi
void main() {
  final instance = ApiClient().getMerchantApi();

  group(MerchantApi, () {
    //Future<CreateMerchantSuccessResponse> createMerchant({ CreateMerchantRequest createMerchantRequest }) async
    test('test createMerchant', () async {
      // TODO
    });

    //Future<DeleteMerchantSuccessResponse> deleteMerchant(String id) async
    test('test deleteMerchant', () async {
      // TODO
    });

    //Future<GetAllMerchantSuccessResponse> getAllMerchant(int page, int limit, { String cursor }) async
    test('test getAllMerchant', () async {
      // TODO
    });

    //Future<GetMerchantByIdSuccessResponse> getMerchantById(String id, bool fromCache) async
    test('test getMerchantById', () async {
      // TODO
    });

    //Future<UpdateMerchantSuccessResponse> updateMerchant(String id, { CreateMerchantRequest createMerchantRequest }) async
    test('test updateMerchant', () async {
      // TODO
    });

  });
}
