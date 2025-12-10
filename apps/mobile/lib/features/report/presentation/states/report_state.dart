part of '_export.dart';

class ReportState extends Equatable {
  const ReportState({this.status = const OperationResult.idle()});

  final OperationResult<void> status;

  @override
  List<Object> get props => [status];

  ReportState copyWith({OperationResult<void>? status}) {
    return ReportState(status: status ?? this.status);
  }

  @override
  bool get stringify => true;
}
