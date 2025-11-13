import 'package:test/test.dart';
import 'package:api_client/api_client.dart';

/// tests for NotificationApi
void main() {
  final instance = ApiClient().getNotificationApi();

  group(NotificationApi, () {
    //Future<NotificationList200Response> notificationList(String read, { String cursor, Object limit, Object page, String query, String sortBy, String order }) async
    test('test notificationList', () async {
      // TODO
    });

    //Future<NotificationSaveToken200Response> notificationRemoveToken(String token) async
    test('test notificationRemoveToken', () async {
      // TODO
    });

    //Future<NotificationSaveToken200Response> notificationSaveToken(NotificationSaveTokenRequest notificationSaveTokenRequest) async
    test('test notificationSaveToken', () async {
      // TODO
    });

    //Future<NotificationSubscribeToTopic200Response> notificationSubscribeToTopic(NotificationSubscribeToTopicRequest notificationSubscribeToTopicRequest) async
    test('test notificationSubscribeToTopic', () async {
      // TODO
    });

    //Future<NotificationSubscribeToTopic200Response> notificationUnsubscribeToTopic(NotificationSubscribeToTopicRequest notificationSubscribeToTopicRequest) async
    test('test notificationUnsubscribeToTopic', () async {
      // TODO
    });
  });
}
