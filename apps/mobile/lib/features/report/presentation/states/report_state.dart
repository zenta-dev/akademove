part of '_export.dart';

@MappableClass(
  generateMethods:
      GenerateMethods.stringify | GenerateMethods.equals | GenerateMethods.copy,
)
class ReportState extends BaseState2 with ReportStateMappable {
  ReportState({
    this.submittedReport,
    this.reports = const [],
    super.state,
    super.message,
    super.error,
  });

  final Report? submittedReport;
  final List<Report> reports;

  @override
  ReportState toInitial() => ReportState(state: CubitState.initial);

  @override
  ReportState toLoading() => copyWith(state: CubitState.loading);

  @override
  ReportState toSuccess({
    Report? submittedReport,
    List<Report>? reports,
    String? message,
  }) => copyWith(
    state: CubitState.success,
    submittedReport: submittedReport ?? this.submittedReport,
    reports: reports ?? this.reports,
    message: message,
    error: null,
  );

  @override
  ReportState toFailure(BaseError error, {String? message}) =>
      copyWith(state: CubitState.failure, error: error, message: message);
}
