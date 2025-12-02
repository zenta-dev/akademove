// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'coupon_state.dart';

class CouponStateMapper extends ClassMapperBase<CouponState> {
  CouponStateMapper._();

  static CouponStateMapper? _instance;
  static CouponStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CouponStateMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'CouponState';

  static EligibleCouponsResult? _$data(CouponState v) => v.data;
  static const Field<CouponState, EligibleCouponsResult> _f$data = Field(
    'data',
    _$data,
    opt: true,
  );
  static BaseError? _$error(CouponState v) => v.error;
  static const Field<CouponState, BaseError> _f$error = Field(
    'error',
    _$error,
    opt: true,
  );
  static CubitState _$state(CouponState v) => v.state;
  static const Field<CouponState, CubitState> _f$state = Field(
    'state',
    _$state,
    opt: true,
    def: CubitState.initial,
  );
  static String? _$message(CouponState v) => v.message;
  static const Field<CouponState, String> _f$message = Field(
    'message',
    _$message,
    opt: true,
  );

  @override
  final MappableFields<CouponState> fields = const {
    #data: _f$data,
    #error: _f$error,
    #state: _f$state,
    #message: _f$message,
  };

  static CouponState _instantiate(DecodingData data) {
    return CouponState(
      data: data.dec(_f$data),
      error: data.dec(_f$error),
      state: data.dec(_f$state),
      message: data.dec(_f$message),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static CouponState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CouponState>(map);
  }

  static CouponState fromJson(String json) {
    return ensureInitialized().decodeJson<CouponState>(json);
  }
}

mixin CouponStateMappable {
  String toJson() {
    return CouponStateMapper.ensureInitialized().encodeJson<CouponState>(
      this as CouponState,
    );
  }

  Map<String, dynamic> toMap() {
    return CouponStateMapper.ensureInitialized().encodeMap<CouponState>(
      this as CouponState,
    );
  }

  CouponStateCopyWith<CouponState, CouponState, CouponState> get copyWith =>
      _CouponStateCopyWithImpl<CouponState, CouponState>(
        this as CouponState,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return CouponStateMapper.ensureInitialized().stringifyValue(
      this as CouponState,
    );
  }

  @override
  bool operator ==(Object other) {
    return CouponStateMapper.ensureInitialized().equalsValue(
      this as CouponState,
      other,
    );
  }

  @override
  int get hashCode {
    return CouponStateMapper.ensureInitialized().hashValue(this as CouponState);
  }
}

extension CouponStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CouponState, $Out> {
  CouponStateCopyWith<$R, CouponState, $Out> get $asCouponState =>
      $base.as((v, t, t2) => _CouponStateCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CouponStateCopyWith<$R, $In extends CouponState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    EligibleCouponsResult? data,
    BaseError? error,
    CubitState? state,
    String? message,
  });
  CouponStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _CouponStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CouponState, $Out>
    implements CouponStateCopyWith<$R, CouponState, $Out> {
  _CouponStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CouponState> $mapper =
      CouponStateMapper.ensureInitialized();
  @override
  $R call({
    Object? data = $none,
    Object? error = $none,
    CubitState? state,
    Object? message = $none,
  }) => $apply(
    FieldCopyWithData({
      if (data != $none) #data: data,
      if (error != $none) #error: error,
      if (state != null) #state: state,
      if (message != $none) #message: message,
    }),
  );
  @override
  CouponState $make(CopyWithData data) => CouponState(
    data: data.get(#data, or: $value.data),
    error: data.get(#error, or: $value.error),
    state: data.get(#state, or: $value.state),
    message: data.get(#message, or: $value.message),
  );

  @override
  CouponStateCopyWith<$R2, CouponState, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _CouponStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

