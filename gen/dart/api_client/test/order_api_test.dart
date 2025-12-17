import 'package:test/test.dart';
import 'package:api_client/api_client.dart';

/// tests for OrderApi
void main() {
  final instance = ApiClient().getOrderApi();

  group(OrderApi, () {
    //Future<ChatGetUnreadCount200Response> chatGetUnreadCount(String orderId) async
    test('test chatGetUnreadCount', () async {
      // TODO
    });

    //Future<ChatList200Response> chatList(String orderId, int limit, { String cursor }) async
    test('test chatList', () async {
      // TODO
    });

    //Future<ChatMarkAsRead200Response> chatMarkAsRead(MarkChatAsRead markChatAsRead) async
    test('test chatMarkAsRead', () async {
      // TODO
    });

    //Future<ChatSend200Response> chatSend(InsertOrderChatMessage insertOrderChatMessage) async
    test('test chatSend', () async {
      // TODO
    });

    //Future<MerchantOrderAccept200Response> orderCancel(String id, OrderCancelRequest orderCancelRequest) async
    test('test orderCancel', () async {
      // TODO
    });

    //Future<MerchantOrderAccept200Response> orderCancelScheduledOrder(String id, OrderCancelRequest orderCancelRequest) async
    test('test orderCancelScheduledOrder', () async {
      // TODO
    });

    //Future<OrderEstimate200Response> orderEstimate(EstimateOrder estimateOrder) async
    test('test orderEstimate', () async {
      // TODO
    });

    //Future<MerchantOrderAccept200Response> orderGet(String id) async
    test('test orderGet', () async {
      // TODO
    });

    //Future<OrderGetActive200Response> orderGetActive() async
    test('test orderGetActive', () async {
      // TODO
    });

    //Future<OrderGetStatusHistory200Response> orderGetStatusHistory(String id) async
    test('test orderGetStatusHistory', () async {
      // TODO
    });

    //Future<OrderList200Response> orderList({ String cursor, Object limit, String direction, Object page, String query, String sortBy, PaginationOrder order, PaginationMode mode, Object statuses, Object type, DateTime startDate, DateTime endDate }) async
    test('test orderList', () async {
      // TODO
    });

    //Future<ChatList200Response> orderListMessages(String id, int limit, { String cursor }) async
    test('test orderListMessages', () async {
      // TODO
    });

    //Future<OrderList200Response> orderListScheduledOrders({ String cursor, Object limit, String direction, Object page, String query, String sortBy, PaginationOrder order, PaginationMode mode, Object statuses, Object type, DateTime startDate, DateTime endDate }) async
    test('test orderListScheduledOrders', () async {
      // TODO
    });

    //Future<OrderPlaceOrder200Response> orderPlaceOrder(PlaceOrder placeOrder) async
    test('test orderPlaceOrder', () async {
      // TODO
    });

    //Future<OrderPlaceScheduledOrder200Response> orderPlaceScheduledOrder(PlaceScheduledOrder placeScheduledOrder) async
    test('test orderPlaceScheduledOrder', () async {
      // TODO
    });

    //Future<ChatSend200Response> orderSendMessage(String id, OrderSendMessageRequest orderSendMessageRequest) async
    test('test orderSendMessage', () async {
      // TODO
    });

    //Future<MerchantOrderAccept200Response> orderUpdate(String id, UpdateOrder updateOrder) async
    test('test orderUpdate', () async {
      // TODO
    });

    //Future<MerchantOrderAccept200Response> orderUpdateScheduledOrder(String id, UpdateScheduledOrder updateScheduledOrder) async
    test('test orderUpdateScheduledOrder', () async {
      // TODO
    });

    //Future<OrderUploadDeliveryProof200Response> orderUploadAttachment(MultipartFile file) async
    test('test orderUploadAttachment', () async {
      // TODO
    });

    //Future<OrderUploadDeliveryProof200Response> orderUploadDeliveryItemPhoto(String id, MultipartFile file) async
    test('test orderUploadDeliveryItemPhoto', () async {
      // TODO
    });

    //Future<OrderUploadDeliveryProof200Response> orderUploadDeliveryProof(String id, MultipartFile file) async
    test('test orderUploadDeliveryProof', () async {
      // TODO
    });

    //Future<OrderVerifyDeliveryOTP200Response> orderVerifyDeliveryOTP(String id, OrderVerifyDeliveryOTPRequest orderVerifyDeliveryOTPRequest) async
    test('test orderVerifyDeliveryOTP', () async {
      // TODO
    });
  });
}
