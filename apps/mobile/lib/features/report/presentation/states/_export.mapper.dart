// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of '_export.dart';

class ReportStateMapper extends ClassMapperBase<ReportState> {
  ReportStateMapper._();

  static ReportStateMapper? _instance;
  static ReportStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ReportStateMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ReportState';

  static Report? _$submittedReport(ReportState v) => v.submittedReport;
  static const Field<ReportState, Report> _f$submittedReport = Field(
    'submittedReport',
    _$submittedReport,
    opt: true,
  );
  static List<Report> _$reports(ReportState v) => v.reports;
  static const Field<ReportState, List<Report>> _f$reports = Field(
    'reports',
    _$reports,
    opt: true,
    def: const [],
  );
  static CubitState _$state(ReportState v) => v.state;
  static const Field<ReportState, CubitState> _f$state = Field(
    'state',
    _$state,
    opt: true,
    def: CubitState.initial,
  );
  static String? _$message(ReportState v) => v.message;
  static const Field<ReportState, String> _f$message = Field(
    'message',
    _$message,
    opt: true,
  );
  static BaseError? _$error(ReportState v) => v.error;
  static const Field<ReportState, BaseError> _f$error = Field(
    'error',
    _$error,
    opt: true,
  );

  @override
  final MappableFields<ReportState> fields = const {
    #submittedReport: _f$submittedReport,
    #reports: _f$reports,
    #state: _f$state,
    #message: _f$message,
    #error: _f$error,
  };

  static ReportState _instantiate(DecodingData data) {
    return ReportState(
      submittedReport: data.dec(_f$submittedReport),
      reports: data.dec(_f$reports),
      state: data.dec(_f$state),
      message: data.dec(_f$message),
      error: data.dec(_f$error),
    );
  }

  @override
  final Function instantiate = _instantiate;
}

mixin ReportStateMappable {
  ReportStateCopyWith<ReportState, ReportState, ReportState> get copyWith =>
      _ReportStateCopyWithImpl<ReportState, ReportState>(
        this as ReportState,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ReportStateMapper.ensureInitialized().stringifyValue(
      this as ReportState,
    );
  }

  @override
  bool operator ==(Object other) {
    return ReportStateMapper.ensureInitialized().equalsValue(
      this as ReportState,
      other,
    );
  }

  @override
  int get hashCode {
    return ReportStateMapper.ensureInitialized().hashValue(this as ReportState);
  }
}

extension ReportStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ReportState, $Out> {
  ReportStateCopyWith<$R, ReportState, $Out> get $asReportState =>
      $base.as((v, t, t2) => _ReportStateCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ReportStateCopyWith<$R, $In extends ReportState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Report, ObjectCopyWith<$R, Report, Report>> get reports;
  $R call({
    Report? submittedReport,
    List<Report>? reports,
    CubitState? state,
    String? message,
    BaseError? error,
  });
  ReportStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ReportStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ReportState, $Out>
    implements ReportStateCopyWith<$R, ReportState, $Out> {
  _ReportStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ReportState> $mapper =
      ReportStateMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Report, ObjectCopyWith<$R, Report, Report>> get reports =>
      ListCopyWith(
        $value.reports,
        (v, t) => ObjectCopyWith(v, $identity, t),
        (v) => call(reports: v),
      );
  @override
  $R call({
    Object? submittedReport = $none,
    List<Report>? reports,
    CubitState? state,
    Object? message = $none,
    Object? error = $none,
  }) => $apply(
    FieldCopyWithData({
      if (submittedReport != $none) #submittedReport: submittedReport,
      if (reports != null) #reports: reports,
      if (state != null) #state: state,
      if (message != $none) #message: message,
      if (error != $none) #error: error,
    }),
  );
  @override
  ReportState $make(CopyWithData data) => ReportState(
    submittedReport: data.get(#submittedReport, or: $value.submittedReport),
    reports: data.get(#reports, or: $value.reports),
    state: data.get(#state, or: $value.state),
    message: data.get(#message, or: $value.message),
    error: data.get(#error, or: $value.error),
  );

  @override
  ReportStateCopyWith<$R2, ReportState, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ReportStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

