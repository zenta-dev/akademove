import 'package:test/test.dart';
import 'package:api_client/api_client.dart';

/// tests for ReviewApi
void main() {
  final instance = ApiClient().getReviewApi();

  group(ReviewApi, () {
    //Future<ReviewCreate200Response> reviewCreate(InsertReview insertReview) async
    test('test reviewCreate', () async {
      // TODO
    });

    //Future<ReviewCreate200Response> reviewGet(String id) async
    test('test reviewGet', () async {
      // TODO
    });

    //Future<ReviewList200Response> reviewList({ String cursor, Object limit, Object page, String query, String sortBy, String order }) async
    test('test reviewList', () async {
      // TODO
    });

    //Future<BadgeRemove200Response> reviewRemove(String id) async
    test('test reviewRemove', () async {
      // TODO
    });

    //Future<ReviewCreate200Response> reviewUpdate(String id, UpdateReview updateReview) async
    test('test reviewUpdate', () async {
      // TODO
    });
  });
}
