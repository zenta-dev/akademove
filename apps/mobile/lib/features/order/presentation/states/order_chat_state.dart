part of '_export.dart';

@MappableClass(
  generateMethods:
      GenerateMethods.stringify | GenerateMethods.equals | GenerateMethods.copy,
)
class OrderChatState extends BaseState2 with OrderChatStateMappable {
  OrderChatState({
    this.messages,
    this.hasMore = false,
    this.nextCursor,
    super.state,
    super.message,
    super.error,
  });

  final List<OrderChatMessage>? messages;
  final bool hasMore;
  final String? nextCursor;

  @override
  OrderChatState toInitial() =>
      copyWith(state: CubitState.initial, message: null, error: null);

  @override
  OrderChatState toLoading() =>
      copyWith(state: CubitState.loading, message: null, error: null);

  @override
  OrderChatState toSuccess({
    List<OrderChatMessage>? messages,
    bool? hasMore,
    String? nextCursor,
    String? message,
  }) => copyWith(
    state: CubitState.success,
    messages: messages ?? this.messages,
    hasMore: hasMore ?? this.hasMore,
    nextCursor: nextCursor ?? this.nextCursor,
    message: message,
    error: null,
  );

  @override
  OrderChatState toFailure(BaseError error, {String? message}) =>
      copyWith(state: CubitState.failure, error: error, message: message);
}
