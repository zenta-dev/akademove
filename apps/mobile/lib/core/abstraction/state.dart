import 'package:akademove/core/_export.dart';
import 'package:akademove/core/utils/operation.dart';
import 'package:bloc/bloc.dart';

enum CubitState { initial, loading, success, failure }

abstract class BaseState<T> {
  const BaseState({
    this.data,
    this.message,
    this.error,
    this.state = CubitState.initial,
  });

  final T? data;
  final String? message;
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

  // Future<void> init();
  // void reset();
}

abstract class BaseState2 {
  BaseState2({
    this.state = CubitState.initial,
    this.message,
    this.error,
  });

  final CubitState state;
  final String? message;
  final BaseError? error;
  List<String> operations = List.from([]);

  bool get isInitial => state == CubitState.initial;
  bool get isLoading => state == CubitState.loading;
  bool get isSuccess => state == CubitState.success;
  bool get isFailure => state == CubitState.failure;

  R when<R>({
    required R Function() initial,
    required R Function() loading,
    required R Function({String? message}) success,
    required R Function({BaseError error, String? message}) failure,
  }) {
    switch (state) {
      case CubitState.initial:
        return initial();
      case CubitState.loading:
        return loading();
      case CubitState.success:
        return success(message: message);
      case CubitState.failure:
        return failure(error: error!, message: message);
    }
  }

  R whenOr<R>({
    required R Function() orElse,
    R Function()? initial,
    R Function()? loading,
    R Function(String? message)? success,
    R Function(BaseError error, String? message)? failure,
  }) {
    switch (state) {
      case CubitState.initial:
        return initial?.call() ?? orElse();
      case CubitState.loading:
        return loading?.call() ?? orElse();
      case CubitState.success:
        return success?.call(message) ?? orElse();
      case CubitState.failure:
        return failure?.call(error!, message) ?? orElse();
    }
  }

  bool _isInOperationAndLoading(String name) {
    try {
      final find = operations.where((val) => val == name);
      if (find.isNotEmpty && isLoading) return true;
      return false;
    } catch (e) {
      return false;
    }
  }

  bool checkAndAssignOperation(String name) {
    final ok = _isInOperationAndLoading(name);
    if (!ok) assignOperation(name);
    return ok;
  }

  void unAssignOperation(String name) =>
      safeSync(() => operations.removeWhere((val) => val == name));

  void assignOperation(String name) => safeSync(() => operations.add(name));

  BaseState2 toInitial();
  BaseState2 toLoading();
  BaseState2 toSuccess({String? message});
  BaseState2 toFailure(BaseError error, {String? message});
}

abstract class BaseState3<T> {
  const BaseState3({
    this.state = CubitState.initial,
    this.message,
    this.error,
    this.selected,
    this.list = const [],
  });

  final CubitState state;
  final String? message;
  final BaseError? error;
  final T? selected;
  final List<T> list;

  bool get isInitial => state == CubitState.initial;
  bool get isLoading => state == CubitState.loading;
  bool get isSuccess => state == CubitState.success;
  bool get isFailure => state == CubitState.failure;

  bool get hasData => selected != null || list.isNotEmpty;
  R when<R>({
    required R Function() initial,
    required R Function() loading,
    required R Function({List<T>? list, T? selected, String? message}) success,
    required R Function({BaseError error, String? message}) failure,
  }) {
    switch (state) {
      case CubitState.initial:
        return initial();
      case CubitState.loading:
        return loading();
      case CubitState.success:
        return success(list: list, selected: selected, message: message);
      case CubitState.failure:
        return failure(error: error!, message: message);
    }
  }

  R whenOr<R>({
    required R Function() orElse,
    R Function()? initial,
    R Function()? loading,
    R Function(List<T>? list, T? selected, String? message)? success,
    R Function(BaseError error, String? message)? failure,
  }) {
    switch (state) {
      case CubitState.initial:
        return initial?.call() ?? orElse();
      case CubitState.loading:
        return loading?.call() ?? orElse();
      case CubitState.success:
        return success?.call(list, selected, message) ?? orElse();
      case CubitState.failure:
        return failure?.call(error!, message) ?? orElse();
    }
  }
}
