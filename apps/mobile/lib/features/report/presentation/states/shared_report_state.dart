part of '_export.dart';

class SharedReportState extends Equatable {
  const SharedReportState({this.status = const OperationResult.idle()});

  final OperationResult<void> status;

  @override
  List<Object> get props => [status];

  SharedReportState copyWith({OperationResult<void>? status}) {
    return SharedReportState(status: status ?? this.status);
  }

  @override
  bool get stringify => true;
}
