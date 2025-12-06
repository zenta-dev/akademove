// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'email_verification_state.dart';

class EmailVerificationStateMapper
    extends ClassMapperBase<EmailVerificationState> {
  EmailVerificationStateMapper._();

  static EmailVerificationStateMapper? _instance;
  static EmailVerificationStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = EmailVerificationStateMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'EmailVerificationState';

  static bool? _$data(EmailVerificationState v) => v.data;
  static const Field<EmailVerificationState, bool> _f$data = Field(
    'data',
    _$data,
    opt: true,
  );
  static BaseError? _$error(EmailVerificationState v) => v.error;
  static const Field<EmailVerificationState, BaseError> _f$error = Field(
    'error',
    _$error,
    opt: true,
  );
  static CubitState _$state(EmailVerificationState v) => v.state;
  static const Field<EmailVerificationState, CubitState> _f$state = Field(
    'state',
    _$state,
    opt: true,
    def: CubitState.initial,
  );
  static String? _$message(EmailVerificationState v) => v.message;
  static const Field<EmailVerificationState, String> _f$message = Field(
    'message',
    _$message,
    opt: true,
  );
  static String? _$email(EmailVerificationState v) => v.email;
  static const Field<EmailVerificationState, String> _f$email = Field(
    'email',
    _$email,
    opt: true,
  );

  @override
  final MappableFields<EmailVerificationState> fields = const {
    #data: _f$data,
    #error: _f$error,
    #state: _f$state,
    #message: _f$message,
    #email: _f$email,
  };

  static EmailVerificationState _instantiate(DecodingData data) {
    return EmailVerificationState(
      data: data.dec(_f$data),
      error: data.dec(_f$error),
      state: data.dec(_f$state),
      message: data.dec(_f$message),
      email: data.dec(_f$email),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static EmailVerificationState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<EmailVerificationState>(map);
  }

  static EmailVerificationState fromJson(String json) {
    return ensureInitialized().decodeJson<EmailVerificationState>(json);
  }
}

mixin EmailVerificationStateMappable {
  String toJson() {
    return EmailVerificationStateMapper.ensureInitialized()
        .encodeJson<EmailVerificationState>(this as EmailVerificationState);
  }

  Map<String, dynamic> toMap() {
    return EmailVerificationStateMapper.ensureInitialized()
        .encodeMap<EmailVerificationState>(this as EmailVerificationState);
  }

  EmailVerificationStateCopyWith<
    EmailVerificationState,
    EmailVerificationState,
    EmailVerificationState
  >
  get copyWith =>
      _EmailVerificationStateCopyWithImpl<
        EmailVerificationState,
        EmailVerificationState
      >(this as EmailVerificationState, $identity, $identity);
  @override
  String toString() {
    return EmailVerificationStateMapper.ensureInitialized().stringifyValue(
      this as EmailVerificationState,
    );
  }

  @override
  bool operator ==(Object other) {
    return EmailVerificationStateMapper.ensureInitialized().equalsValue(
      this as EmailVerificationState,
      other,
    );
  }

  @override
  int get hashCode {
    return EmailVerificationStateMapper.ensureInitialized().hashValue(
      this as EmailVerificationState,
    );
  }
}

extension EmailVerificationStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, EmailVerificationState, $Out> {
  EmailVerificationStateCopyWith<$R, EmailVerificationState, $Out>
  get $asEmailVerificationState => $base.as(
    (v, t, t2) => _EmailVerificationStateCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class EmailVerificationStateCopyWith<
  $R,
  $In extends EmailVerificationState,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    bool? data,
    BaseError? error,
    CubitState? state,
    String? message,
    String? email,
  });
  EmailVerificationStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _EmailVerificationStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, EmailVerificationState, $Out>
    implements
        EmailVerificationStateCopyWith<$R, EmailVerificationState, $Out> {
  _EmailVerificationStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<EmailVerificationState> $mapper =
      EmailVerificationStateMapper.ensureInitialized();
  @override
  $R call({
    Object? data = $none,
    Object? error = $none,
    CubitState? state,
    Object? message = $none,
    Object? email = $none,
  }) => $apply(
    FieldCopyWithData({
      if (data != $none) #data: data,
      if (error != $none) #error: error,
      if (state != null) #state: state,
      if (message != $none) #message: message,
      if (email != $none) #email: email,
    }),
  );
  @override
  EmailVerificationState $make(CopyWithData data) => EmailVerificationState(
    data: data.get(#data, or: $value.data),
    error: data.get(#error, or: $value.error),
    state: data.get(#state, or: $value.state),
    message: data.get(#message, or: $value.message),
    email: data.get(#email, or: $value.email),
  );

  @override
  EmailVerificationStateCopyWith<$R2, EmailVerificationState, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _EmailVerificationStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

