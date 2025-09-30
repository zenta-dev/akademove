import 'package:akademove/core/_export.dart';
import 'package:bloc/bloc.dart';

enum CubitState { initial, loading, success, failure }

abstract class BaseState<T> {
  const BaseState({
    this.data,
    this.error,
    this.state = CubitState.initial,
  });

  final T? data;
  final BaseError? error;
  final CubitState state;

  bool get isInitial => state == CubitState.initial;
  bool get isLoading => state == CubitState.loading;
  bool get isSuccess => state == CubitState.success;
  bool get isFailure => state == CubitState.failure;

  bool get hasData => data != null;
}

abstract class BaseCubit<T> extends Cubit<T> {
  BaseCubit(super.initialState);

  Future<void> init();
}
