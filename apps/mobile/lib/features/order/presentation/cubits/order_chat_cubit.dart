import 'dart:async';

import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';

class OrderChatCubit extends BaseCubit<OrderChatState> {
  OrderChatCubit({
    required OrderChatRepository orderChatRepository,
    required WebSocketService webSocketService,
  }) : _orderChatRepository = orderChatRepository,
       _webSocketService = webSocketService,
       super(const OrderChatState());

  final OrderChatRepository _orderChatRepository;
  final WebSocketService _webSocketService;
  String? _currentOrderId;
  StreamSubscription<Object?>? _wsSubscription;

  Future<void> init(String orderId) async {
    _currentOrderId = orderId;
    reset();
    await loadMessages();
    _subscribeToWebSocket(orderId);
  }

  void _subscribeToWebSocket(String orderId) {
    // Listen for messages from the WebSocket stream
    // The WebSocket is already connected by the UserOrderCubit/DriverOrderCubit
    // We just need to listen to it
    final stream = _webSocketService.stream(orderId);
    if (stream == null) {
      logger.d(
        '[OrderChatCubit] No WebSocket stream for order $orderId, '
        'messages will update via HTTP only',
      );
      return;
    }

    _wsSubscription?.cancel();
    _wsSubscription = stream.listen(
      (data) {
        if (data is String) {
          _handleWebSocketMessage(data);
        }
      },
      onError: (Object error) {
        logger.e('[OrderChatCubit] WebSocket error', error: error);
      },
    );
    logger.d('[OrderChatCubit] Subscribed to WebSocket for order $orderId');
  }

  void _handleWebSocketMessage(String data) {
    try {
      final json = data.parseJson();
      if (json is! Map<String, dynamic>) return;

      final envelope = OrderEnvelope.fromJson(json);
      if (envelope.e != OrderEnvelopeEvent.CHAT_MESSAGE) return;

      final messagePayload = envelope.p.message;
      if (messagePayload == null) return;

      logger.d(
        '[OrderChatCubit] Received chat message via WebSocket: '
        '${messagePayload.id}',
      );

      // Convert WebSocket message to OrderChatMessage
      final newMessage = OrderChatMessage(
        id: messagePayload.id,
        orderId: messagePayload.orderId,
        senderId: messagePayload.senderId,
        message: messagePayload.message,
        sentAt: messagePayload.sentAt,
        createdAt: messagePayload.sentAt,
        updatedAt: messagePayload.sentAt,
        sender: OrderChatMessageSender(
          name: messagePayload.senderName,
          role: _convertSenderRole(messagePayload.senderRole),
        ),
      );

      // Add message to state if not already present (avoid duplicates)
      final existingMessages = state.messages.value ?? [];
      final isDuplicate = existingMessages.any((m) => m.id == newMessage.id);
      if (!isDuplicate) {
        final updatedMessages = [newMessage, ...existingMessages];
        emit(
          state.copyWith(messages: OperationResult.success(updatedMessages)),
        );
      }
    } catch (e, st) {
      logger.e(
        '[OrderChatCubit] Error parsing WebSocket message',
        error: e,
        stackTrace: st,
      );
    }
  }

  /// Converts WebSocket sender role enum to ChatSenderRole
  ChatSenderRole _convertSenderRole(
    OrderEnvelopePayloadMessageSenderRoleEnum role,
  ) {
    switch (role) {
      case OrderEnvelopePayloadMessageSenderRoleEnum.USER:
        return ChatSenderRole.USER;
      case OrderEnvelopePayloadMessageSenderRoleEnum.DRIVER:
        return ChatSenderRole.DRIVER;
      case OrderEnvelopePayloadMessageSenderRoleEnum.MERCHANT:
        return ChatSenderRole.MERCHANT;
    }
  }

  void reset() {
    _wsSubscription?.cancel();
    _wsSubscription = null;
    emit(const OrderChatState());
  }

  @override
  Future<void> close() async {
    _wsSubscription?.cancel();
    _wsSubscription = null;
    return super.close();
  }

  Future<void> loadMessages({bool loadMore = false}) async =>
      await taskManager.execute('ORC-lM-$loadMore', () async {
        if (_currentOrderId == null) return;

        try {
          if (!loadMore) {
            emit(state.copyWith(messages: const OperationResult.loading()));
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
              ? (state.messages.value ?? [])
              : <OrderChatMessage>[];
          final newMessages = [...existingMessages, ...res.data.rows];

          emit(
            state.copyWith(
              messages: OperationResult.success(newMessages),
              nextCursor: res.data.nextCursor,
              hasMore: res.data.nextCursor != null,
            ),
          );
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
    if (!state.hasMore) return;
    await loadMessages(loadMore: true);
  }
}
