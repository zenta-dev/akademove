import 'package:test/test.dart';
import 'package:api_client/api_client.dart';

/// tests for SupportChatApi
void main() {
  final instance = ApiClient().getSupportChatApi();

  group(SupportChatApi, () {
    //Future<SupportChatCreateTicket201Response> supportChatCreateTicket(InsertSupportTicket insertSupportTicket) async
    test('test supportChatCreateTicket', () async {
      // TODO
    });

    //Future<SupportChatCreateTicket201Response> supportChatGetTicket(String id) async
    test('test supportChatGetTicket', () async {
      // TODO
    });

    //Future<SupportChatGetUnreadCount200Response> supportChatGetUnreadCount(String ticketId) async
    test('test supportChatGetUnreadCount', () async {
      // TODO
    });

    //Future<SupportChatListMessages200Response> supportChatListMessages(String ticketId, int limit, { String cursor }) async
    test('test supportChatListMessages', () async {
      // TODO
    });

    //Future<SupportChatListTickets200Response> supportChatListTickets(int limit, { SupportTicketStatus status, SupportTicketCategory category, SupportTicketPriority priority, String assignedToId, String userId, String search, String cursor }) async
    test('test supportChatListTickets', () async {
      // TODO
    });

    //Future<SupportChatMarkAsRead200Response> supportChatMarkAsRead(SupportChatMarkAsReadRequest supportChatMarkAsReadRequest) async
    test('test supportChatMarkAsRead', () async {
      // TODO
    });

    //Future<SupportChatSendMessage201Response> supportChatSendMessage(InsertSupportChatMessage insertSupportChatMessage) async
    test('test supportChatSendMessage', () async {
      // TODO
    });

    //Future<SupportChatCreateTicket201Response> supportChatUpdateTicket(String id, UpdateSupportTicket updateSupportTicket) async
    test('test supportChatUpdateTicket', () async {
      // TODO
    });
  });
}
