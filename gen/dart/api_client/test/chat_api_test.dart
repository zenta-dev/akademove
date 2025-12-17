import 'package:test/test.dart';
import 'package:api_client/api_client.dart';

/// tests for ChatApi
void main() {
  final instance = ApiClient().getChatApi();

  group(ChatApi, () {
    //Future<QuickMessageCreate200Response> quickMessageCreate(InsertQuickMessageTemplate insertQuickMessageTemplate) async
    test('test quickMessageCreate', () async {
      // TODO
    });

    //Future<AccountDeletionDelete200Response> quickMessageDelete(String id) async
    test('test quickMessageDelete', () async {
      // TODO
    });

    //Future<QuickMessageCreate200Response> quickMessageGet(String id) async
    test('test quickMessageGet', () async {
      // TODO
    });

    //Future<QuickMessageList200Response> quickMessageList({ String role, String orderType, String locale, String status }) async
    test('test quickMessageList', () async {
      // TODO
    });

    //Future<QuickMessageCreate200Response> quickMessageUpdate(String id, UpdateQuickMessageTemplate updateQuickMessageTemplate) async
    test('test quickMessageUpdate', () async {
      // TODO
    });
  });
}
