part of '_export.dart';

class OrderChatState extends Equatable {
  const OrderChatState({
    this.messages = const OperationResult.idle(),
    this.sendMessage = const OperationResult.idle(),
  });

  final OperationResult<List<OrderChatMessage>> messages;
  final OperationResult<OrderChatMessage> sendMessage;

  /// Whether there are more messages to load
  bool get hasMore => messages.value != null && messages.value!.isNotEmpty;

  // Compatibility getters
  bool get isInitial => messages.isIdle && sendMessage.isIdle;
  bool get isLoading => messages.isLoading || sendMessage.isLoading;
  bool get isFailure => messages.isFailure || sendMessage.isFailure;
  BaseError? get error => messages.error ?? sendMessage.error;

  @override
  List<Object> get props => [messages, sendMessage];

  OrderChatState copyWith({
    OperationResult<List<OrderChatMessage>>? messages,
    OperationResult<OrderChatMessage>? sendMessage,
  }) {
    return OrderChatState(
      messages: messages ?? this.messages,
      sendMessage: sendMessage ?? this.sendMessage,
    );
  }

  @override
  bool get stringify => true;
}
