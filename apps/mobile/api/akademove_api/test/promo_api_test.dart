import 'package:test/test.dart';
import 'package:akademove_api/akademove_api.dart';

/// tests for PromoApi
void main() {
  final instance = AkademoveApi().getPromoApi();

  group(PromoApi, () {
    //Future<CreatePromoSuccessResponse> createPromo({ CreatePromoRequest createPromoRequest }) async
    test('test createPromo', () async {
      // TODO
    });

    //Future<DeletePromoSuccessResponse> deletePromo(String id) async
    test('test deletePromo', () async {
      // TODO
    });

    //Future<GetAllPromoSuccessResponse> getAllPromo(int page, int limit, { String cursor }) async
    test('test getAllPromo', () async {
      // TODO
    });

    //Future<GetPromoByIdSuccessResponse> getPromoById(String id, bool fromCache) async
    test('test getPromoById', () async {
      // TODO
    });

    //Future<UpdatePromoSuccessResponse> updatePromo(String id, { CreatePromoRequest createPromoRequest }) async
    test('test updatePromo', () async {
      // TODO
    });
  });
}
