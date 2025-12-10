// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:akademove/core/_export.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

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
      data = null,
      assert(error != null);

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
