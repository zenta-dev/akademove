import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';

class OrderChatCubit extends BaseCubit<OrderChatState> {
  OrderChatCubit({required OrderChatRepository orderChatRepository})
    : _orderChatRepository = orderChatRepository,
      super(OrderChatState());

  final OrderChatRepository _orderChatRepository;
  String? _currentOrderId;

  Future<void> init(String orderId) async {
    _currentOrderId = orderId;
    reset();
    await loadMessages();
  }

  void reset() {
    emit(OrderChatState());
  }

  Future<void> loadMessages({bool loadMore = false}) async =>
      await taskManager.execute('ORC-lM-$loadMore', () async {
        if (_currentOrderId == null) return;

        try {
          if (!loadMore) {
            emit(state.toLoading());
          }

          final orderId = _currentOrderId;
          if (orderId == null) {
            throw StateError('Order ID is null');
          }

          final res = await _orderChatRepository.listMessages(
            ListOrderChatMessagesQuery(
              orderId: orderId,
              limit: 50,
              cursor: loadMore ? state.nextCursor : null,
            ),
          );

          final existingMessages = loadMore
              ? (state.messages ?? [])
              : <OrderChatMessage>[];
          final newMessages = [...existingMessages, ...res.data.rows];

          emit(
            state.toSuccess(
              messages: newMessages,
              hasMore: res.data.hasMore,
              nextCursor: res.data.nextCursor,
              message: res.message,
            ),
          );
        } on BaseError catch (e, st) {
          logger.e(
            '[OrderChatCubit] - Error loading messages: ${e.message}',
            error: e,
            stackTrace: st,
          );
          emit(state.toFailure(e));
        }
      });

  Future<void> sendMessage(
    String message,
  ) async => await taskManager.execute('ORC-sM-$message', () async {
    final orderId = _currentOrderId;
    if (orderId == null) return;
    if (message.trim().isEmpty) return;
    try {
      final res = await _orderChatRepository.sendMessage(
        SendOrderChatMessageRequest(orderId: orderId, message: message.trim()),
      );

      final existingMessages = state.messages ?? [];
      final updatedMessages = [res.data, ...existingMessages];

      emit(state.toSuccess(messages: updatedMessages, message: res.message));
    } on BaseError catch (e, st) {
      logger.e(
        '[OrderChatCubit] - Error sending message: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.toFailure(e));
    }
  });

  Future<void> loadMoreMessages() async {
    if (!state.hasMore) return;
    await loadMessages(loadMore: true);
  }
}
