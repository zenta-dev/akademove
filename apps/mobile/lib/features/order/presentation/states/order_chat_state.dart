part of '_export.dart';

class OrderChatState extends Equatable {
  const OrderChatState({
    this.messages = const OperationResult.idle(),
    this.sendMessage = const OperationResult.idle(),
  });

  final OperationResult<List<OrderChatMessage>> messages;
  final OperationResult<OrderChatMessage> sendMessage;

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
