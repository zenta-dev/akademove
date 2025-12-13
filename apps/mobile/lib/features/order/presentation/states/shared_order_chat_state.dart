part of '_export.dart';

/// Sentinel class for explicitly setting nullable values in copyWith
class _CopyWithSentinel {
  const _CopyWithSentinel();
}

const _sentinel = _CopyWithSentinel();

class SharedOrderChatState extends Equatable {
  const SharedOrderChatState({
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

  SharedOrderChatState copyWith({
    OperationResult<List<OrderChatMessage>>? messages,
    OperationResult<OrderChatMessage>? sendMessage,
    OperationResult<int>? unreadCount,
    Object? nextCursor = _sentinel,
    bool? hasMore,
  }) {
    return SharedOrderChatState(
      messages: messages ?? this.messages,
      sendMessage: sendMessage ?? this.sendMessage,
      unreadCount: unreadCount ?? this.unreadCount,
      nextCursor: nextCursor == _sentinel
          ? this.nextCursor
          : nextCursor as String?,
      hasMore: hasMore ?? this.hasMore,
    );
  }

  @override
  bool get stringify => true;
}
