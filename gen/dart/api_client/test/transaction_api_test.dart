import 'package:test/test.dart';
import 'package:api_client/api_client.dart';

/// tests for TransactionApi
void main() {
  final instance = ApiClient().getTransactionApi();

  group(TransactionApi, () {
    //Future<TransactionGet200Response> transactionGet(String id) async
    test('test transactionGet', () async {
      // TODO
    });

    //Future<TransactionList200Response> transactionList({ String cursor, Object limit, Object page, String query, String sortBy, String order }) async
    test('test transactionList', () async {
      // TODO
    });
  });
}
