import 'dart:async';

import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';

class SharedOrderChatCubit extends BaseCubit<SharedOrderChatState> {
  SharedOrderChatCubit({
    required OrderChatRepository orderChatRepository,
    required WebSocketService webSocketService,
  }) : _orderChatRepository = orderChatRepository,
       _webSocketService = webSocketService,
       super(const SharedOrderChatState());

  final OrderChatRepository _orderChatRepository;
  final WebSocketService _webSocketService;
  String? _currentOrderId;
  StreamSubscription<Object?>? _wsSubscription;

  Future<void> init(String orderId) async {
    _currentOrderId = orderId;
    reset();
    await loadMessages();
    _subscribeToWebSocket(orderId);
    // Mark messages as read when chat is opened
    await markAsRead();
  }

  /// Initialize only for unread count tracking (without loading messages)
  /// Use this when you just want to show the badge on the chat button
  Future<void> initUnreadCountOnly(String orderId) async {
    _currentOrderId = orderId;
    await getUnreadCount();
    _subscribeToWebSocket(orderId);
  }

  void _subscribeToWebSocket(String orderId) {
    // Listen for messages from the WebSocket stream
    // The WebSocket is already connected by the UserOrderCubit/DriverOrderCubit
    // We just need to listen to it
    final stream = _webSocketService.stream(orderId);
    if (stream == null) {
      logger.d(
        '[SharedOrderChatCubit] No WebSocket stream for order $orderId, '
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
        logger.e('[SharedOrderChatCubit] WebSocket error', error: error);
      },
    );
    logger.d(
      '[SharedOrderChatCubit] Subscribed to WebSocket for order $orderId',
    );
  }

  void _handleWebSocketMessage(String data) {
    try {
      final json = data.parseJson();
      if (json is! Map<String, dynamic>) return;

      final envelope = OrderEnvelope.fromJson(json);

      // Handle chat message event
      if (envelope.e == OrderEnvelopeEvent.CHAT_MESSAGE) {
        _handleChatMessageEvent(envelope);
      }

      // Handle unread count update event
      if (envelope.e == OrderEnvelopeEvent.CHAT_UNREAD_COUNT) {
        _handleUnreadCountEvent(envelope);
      }
    } catch (e, st) {
      logger.e(
        '[SharedOrderChatCubit] Error parsing WebSocket message',
        error: e,
        stackTrace: st,
      );
    }
  }

  void _handleChatMessageEvent(OrderEnvelope envelope) {
    final messagePayload = envelope.p.message;
    if (messagePayload == null) return;

    logger.d(
      '[SharedOrderChatCubit] Received chat message via WebSocket: '
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
      emit(state.copyWith(messages: OperationResult.success(updatedMessages)));
    }
  }

  void _handleUnreadCountEvent(OrderEnvelope envelope) {
    final unreadPayload = envelope.p.chatUnreadCount;
    if (unreadPayload == null) return;

    // Only update if this is for our current order
    if (unreadPayload.orderId != _currentOrderId) return;

    logger.d(
      '[SharedOrderChatCubit] Received unread count update via WebSocket: '
      '${unreadPayload.unreadCount}',
    );

    emit(
      state.copyWith(
        unreadCount: OperationResult.success(unreadPayload.unreadCount),
      ),
    );
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
    emit(const SharedOrderChatState());
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
            '[SharedOrderChatCubit] - Error loading messages: ${e.message}',
            error: e,
            stackTrace: st,
          );
          emit(state.copyWith(messages: OperationResult.failed(e)));
        } catch (e, st) {
          logger.e(
            '[SharedOrderChatCubit] - Unexpected error loading messages',
            error: e,
            stackTrace: st,
          );
          emit(
            state.copyWith(
              messages: OperationResult.failed(
                RepositoryError(e.toString(), code: ErrorCode.unknown),
              ),
            ),
          );
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
            '[SharedOrderChatCubit] - Error sending message: ${e.message}',
            error: e,
            stackTrace: st,
          );
          emit(state.copyWith(sendMessage: OperationResult.failed(e)));
        } catch (e, st) {
          logger.e(
            '[SharedOrderChatCubit] - Unexpected error sending message',
            error: e,
            stackTrace: st,
          );
          emit(
            state.copyWith(
              sendMessage: OperationResult.failed(
                RepositoryError(e.toString(), code: ErrorCode.unknown),
              ),
            ),
          );
        }
      });

  Future<void> loadMoreMessages() async {
    if (!state.hasMore) return;
    await loadMessages(loadMore: true);
  }

  Future<void> getUnreadCount() async =>
      await taskManager.execute('ORC-gUC', () async {
        final orderId = _currentOrderId;
        if (orderId == null) return;

        try {
          emit(state.copyWith(unreadCount: const OperationResult.loading()));

          final res = await _orderChatRepository.getUnreadCount(orderId);

          emit(state.copyWith(unreadCount: OperationResult.success(res.data)));
        } on BaseError catch (e, st) {
          logger.e(
            '[SharedOrderChatCubit] - Error getting unread count: ${e.message}',
            error: e,
            stackTrace: st,
          );
          emit(state.copyWith(unreadCount: OperationResult.failed(e)));
        } catch (e, st) {
          logger.e(
            '[SharedOrderChatCubit] - Unexpected error getting unread count',
            error: e,
            stackTrace: st,
          );
          emit(
            state.copyWith(
              unreadCount: OperationResult.failed(
                RepositoryError(e.toString(), code: ErrorCode.unknown),
              ),
            ),
          );
        }
      });

  Future<void> markAsRead() async =>
      await taskManager.execute('ORC-mAR', () async {
        final orderId = _currentOrderId;
        if (orderId == null) return;

        try {
          await _orderChatRepository.markAsRead(
            MarkChatAsReadRequest(orderId: orderId),
          );

          // Reset unread count to 0 after marking as read
          emit(state.copyWith(unreadCount: OperationResult.success(0)));
        } on BaseError catch (e, st) {
          logger.e(
            '[SharedOrderChatCubit] - Error marking as read: ${e.message}',
            error: e,
            stackTrace: st,
          );
          // Don't emit failure - this is a non-critical operation
        }
      });
}
