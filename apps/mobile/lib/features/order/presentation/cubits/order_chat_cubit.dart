import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';

class OrderChatCubit extends BaseCubit<OrderChatState> {
  OrderChatCubit({required OrderChatRepository orderChatRepository})
    : _orderChatRepository = orderChatRepository,
      super(const OrderChatState());

  final OrderChatRepository _orderChatRepository;
  String? _currentOrderId;

  Future<void> init(String orderId) async {
    _currentOrderId = orderId;
    reset();
    await loadMessages();
  }

  void reset() {
    emit(const OrderChatState());
  }

  Future<void> loadMessages({
    bool loadMore = false,
  }) async => await taskManager.execute('ORC-lM-$loadMore', () async {
    if (_currentOrderId == null) return;

    try {
      if (!loadMore) {
        emit(state.copyWith(messages: const OperationResult.loading()));
      }

      final orderId = _currentOrderId;
      if (orderId == null) {
        throw StateError('Order ID is null');
      }

      // TODO: Cursor pagination not fully implemented in state yet, assuming simple list for now or need adjusting state
      // The repository call needs cursor
      final res = await _orderChatRepository.listMessages(
        ListOrderChatMessagesQuery(
          orderId: orderId,
          limit: 50,
          cursor:
              null, // loadMore ? state.nextCursor : null, // Cursor removed from state for now, assuming simple refresh
        ),
      );

      final existingMessages = loadMore
          ? (state.messages.value ?? [])
          : <OrderChatMessage>[];
      final newMessages = [...existingMessages, ...res.data.rows];

      emit(state.copyWith(messages: OperationResult.success(newMessages)));
    } on BaseError catch (e, st) {
      logger.e(
        '[OrderChatCubit] - Error loading messages: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.copyWith(messages: OperationResult.failed(e)));
    }
  });

  Future<void> sendMessage(String message) async =>
      await taskManager.execute('ORC-sM-$message', () async {
        final orderId = _currentOrderId;
        if (orderId == null) return;
        if (message.trim().isEmpty) return;
        try {
          emit(state.copyWith(sendMessage: const OperationResult.loading()));

          final res = await _orderChatRepository.sendMessage(
            SendOrderChatMessageRequest(
              orderId: orderId,
              message: message.trim(),
            ),
          );

          final existingMessages = state.messages.value ?? [];
          final updatedMessages = [res.data, ...existingMessages];

          emit(
            state.copyWith(
              messages: OperationResult.success(updatedMessages),
              sendMessage: OperationResult.success(res.data),
            ),
          );
        } on BaseError catch (e, st) {
          logger.e(
            '[OrderChatCubit] - Error sending message: ${e.message}',
            error: e,
            stackTrace: st,
          );
          emit(state.copyWith(sendMessage: OperationResult.failed(e)));
        }
      });

  Future<void> loadMoreMessages() async {
    // if (!state.hasMore) return; // Cursor logic disabled temporarily
    // await loadMessages(loadMore: true);
  }
}
