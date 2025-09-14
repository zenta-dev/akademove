import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for ReviewApi
void main() {
  final instance = ApiClient().getReviewApi();

  group(ReviewApi, () {
    //Future<CreateReviewSuccessResponse> createReview({ CreateReviewRequest createReviewRequest }) async
    test('test createReview', () async {
      // TODO
    });

    //Future<DeleteReviewSuccessResponse> deleteReview(String id) async
    test('test deleteReview', () async {
      // TODO
    });

    //Future<GetAllReviewSuccessResponse> getAllReview(int page, int limit, { String cursor }) async
    test('test getAllReview', () async {
      // TODO
    });

    //Future<GetReviewByIdSuccessResponse> getReviewById(String id, bool fromCache) async
    test('test getReviewById', () async {
      // TODO
    });

    //Future<UpdateReviewSuccessResponse> updateReview(String id, { CreateReviewRequest createReviewRequest }) async
    test('test updateReview', () async {
      // TODO
    });

  });
}
