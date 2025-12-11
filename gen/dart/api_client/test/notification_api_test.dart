import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for NotificationApi
void main() {
  final instance = ApiClient().getNotificationApi();

  group(NotificationApi, () {
    //Future<BannerDelete200Response> notificationDelete(String id) async
    test('test notificationDelete', () async {
      // TODO
    });

    //Future<NotificationGetUnreadCount200Response> notificationGetUnreadCount() async
    test('test notificationGetUnreadCount', () async {
      // TODO
    });

    //Future<NotificationList200Response> notificationList(String read, { String cursor, Object limit, String direction, Object page, String query, String sortBy, PaginationOrder order, PaginationMode mode }) async
    test('test notificationList', () async {
      // TODO
    });

    //Future<NotificationGetUnreadCount200Response> notificationMarkAllAsRead() async
    test('test notificationMarkAllAsRead', () async {
      // TODO
    });

    //Future<NotificationMarkAsRead200Response> notificationMarkAsRead(String id) async
    test('test notificationMarkAsRead', () async {
      // TODO
    });

    //Future<BannerDelete200Response> notificationRemoveToken(String token) async
    test('test notificationRemoveToken', () async {
      // TODO
    });

    //Future<BannerDelete200Response> notificationSaveToken(NotificationSaveTokenRequest notificationSaveTokenRequest) async
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
