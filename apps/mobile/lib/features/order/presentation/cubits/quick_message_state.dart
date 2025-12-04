import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';

class QuickMessageState extends BaseState2 {
  QuickMessageState({
    this.templates,
    super.error,
    super.message,
    super.state = CubitState.initial,
  });

  final List<QuickMessageTemplate>? templates;

  QuickMessageState copyWith({
    List<QuickMessageTemplate>? templates,
    BaseError? error,
    String? message,
    CubitState? state,
  }) {
    return QuickMessageState(
      templates: templates ?? this.templates,
      error: error,
      message: message,
      state: state ?? this.state,
    );
  }

  @override
  QuickMessageState toInitial() => QuickMessageState();

  @override
  QuickMessageState toLoading() => copyWith(state: CubitState.loading);

  @override
  QuickMessageState toSuccess({String? message}) =>
      copyWith(message: message, state: CubitState.success);

  QuickMessageState toSuccessWithTemplates({
    List<QuickMessageTemplate>? templates,
    String? message,
  }) => copyWith(
    templates: templates,
    message: message,
    state: CubitState.success,
  );

  @override
  QuickMessageState toFailure(BaseError error, {String? message}) =>
      copyWith(error: error, message: message, state: CubitState.failure);
}
