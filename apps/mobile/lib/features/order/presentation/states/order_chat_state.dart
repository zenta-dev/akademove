part of '_export.dart';

class OrderChatState extends Equatable {
  const OrderChatState({
    this.messages = const OperationResult.idle(),
    this.sendMessage = const OperationResult.idle(),
    this.unreadCount = const OperationResult.idle(),
    this.nextCursor,
    this.hasMore = true,
  });

  final OperationResult<List<OrderChatMessage>> messages;
  final OperationResult<OrderChatMessage> sendMessage;
  final OperationResult<int> unreadCount;
  final String? nextCursor;
  final bool hasMore;

  @override
  List<Object?> get props => [
    messages,
    sendMessage,
    unreadCount,
    nextCursor,
    hasMore,
  ];

  OrderChatState copyWith({
    OperationResult<List<OrderChatMessage>>? messages,
    OperationResult<OrderChatMessage>? sendMessage,
    OperationResult<int>? unreadCount,
    String? nextCursor,
    bool? hasMore,
  }) {
    return OrderChatState(
      messages: messages ?? this.messages,
      sendMessage: sendMessage ?? this.sendMessage,
      unreadCount: unreadCount ?? this.unreadCount,
      nextCursor: nextCursor ?? this.nextCursor,
      hasMore: hasMore ?? this.hasMore,
    );
  }

  @override
  bool get stringify => true;
}
