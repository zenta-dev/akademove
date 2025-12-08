// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:akademove/core/_export.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

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

  final taskManager = TaskDedupeManager();

  // Future<void> init();
  // void reset();

  @override
  void emit(T state) {
    if (isClosed) return;
    super.emit(state);
  }

  @override
  Future<void> close() {
    taskManager.dispose();
    return super.close();
  }
}

abstract class BaseState2 {
  BaseState2({this.state = CubitState.initial, this.message, this.error});

  final CubitState state;
  final String? message;
  final BaseError? error;
  // List<String> operations = List.from([]);

  bool get isInitial => state == CubitState.initial;
  bool get isLoading => state == CubitState.loading;
  bool get isSuccess => state == CubitState.success;
  bool get isFailure => state == CubitState.failure;

  R when<R>({
    required R Function() initial,
    required R Function() loading,
    required R Function({String? message}) success,
    required R Function({BaseError error}) failure,
  }) {
    switch (state) {
      case CubitState.initial:
        return initial();
      case CubitState.loading:
        return loading();
      case CubitState.success:
        return success(message: message);
      case CubitState.failure:
        final err = error;
        if (err == null) {
          throw StateError('Error is null in failure state');
        }
        return failure(error: err);
    }
  }

  R whenOr<R>({
    required R Function() orElse,
    R Function()? initial,
    R Function()? loading,
    R Function(String? message)? success,
    R Function(BaseError error)? failure,
  }) {
    switch (state) {
      case CubitState.initial:
        return initial?.call() ?? orElse();
      case CubitState.loading:
        return loading?.call() ?? orElse();
      case CubitState.success:
        return success?.call(message) ?? orElse();
      case CubitState.failure:
        final err = error;
        if (err != null && failure != null) {
          return failure(err);
        }
        return orElse();
    }
  }

  BaseState2 toInitial();
  BaseState2 toLoading();
  BaseState2 toSuccess({String? message});
  BaseState2 toFailure(BaseError error, {String? message});
}

class BaseSuccess<T> extends Equatable {
  const BaseSuccess(this.value, this.message);

  final T value;
  final String? message;

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [?value, ?message];
}

enum OperationStatus { idle, loading, success, failed }

class OperationResult<T> extends Equatable {
  const OperationResult._({required this.status, this.data, this.error});
  const OperationResult.idle()
    : status = OperationStatus.idle,
      data = null,
      error = null;

  const OperationResult.loading()
    : status = OperationStatus.loading,
      data = null,
      error = null;

  OperationResult.success(T data, {String? message})
    : status = OperationStatus.success,
      data = BaseSuccess<T>(data, message ?? ''),
      error = null;

  const OperationResult.failed(this.error)
    : status = OperationStatus.failed,
      data = null;

  final OperationStatus status;
  final BaseSuccess<T>? data;
  final BaseError? error;

  bool get isIdle => status == OperationStatus.idle;
  bool get isLoading => status == OperationStatus.loading;
  bool get isSuccess => status == OperationStatus.success;
  bool get isFailed => status == OperationStatus.failed;
  bool get isFailure => isFailed;
  bool get hasData => data != null;

  String? get message => data?.message ?? error?.message;
  T? get value => data?.value;

  @override
  List<Object?> get props => [status, data, error];

  @override
  bool get stringify => true;

  OperationResult<T> copyWith({
    OperationStatus? status,
    BaseSuccess<T>? data,
    BaseError? error,
  }) {
    return OperationResult<T>._(
      status: status ?? this.status,
      data: data ?? this.data,
      error: error ?? this.error,
    );
  }

  R whenOr<R>({
    required R Function() orElse,
    R Function()? idle,
    R Function()? loading,
    R Function(T value, String? message)? success,
    R Function(BaseError error)? failure,
  }) {
    switch (status) {
      case OperationStatus.idle:
        return idle?.call() ?? orElse();
      case OperationStatus.loading:
        return loading?.call() ?? orElse();
      case OperationStatus.success:
        final val = data;
        if (val != null && success != null) {
          return success(val.value, val.message);
        }
        return orElse();
      case OperationStatus.failed:
        final err = error;
        if (err != null && failure != null) {
          return failure(err);
        }
        return orElse();
    }
  }
}
