// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'merchant_state.dart';

class MerchantStateMapper extends ClassMapperBase<MerchantState> {
  MerchantStateMapper._();

  static MerchantStateMapper? _instance;
  static MerchantStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MerchantStateMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'MerchantState';

  static Merchant? _$mine(MerchantState v) => v.mine;
  static const Field<MerchantState, Merchant> _f$mine = Field(
    'mine',
    _$mine,
    opt: true,
  );
  static CubitState _$state(MerchantState v) => v.state;
  static const Field<MerchantState, CubitState> _f$state = Field(
    'state',
    _$state,
    opt: true,
    def: CubitState.initial,
  );
  static String? _$message(MerchantState v) => v.message;
  static const Field<MerchantState, String> _f$message = Field(
    'message',
    _$message,
    opt: true,
  );
  static BaseError? _$error(MerchantState v) => v.error;
  static const Field<MerchantState, BaseError> _f$error = Field(
    'error',
    _$error,
    opt: true,
  );

  @override
  final MappableFields<MerchantState> fields = const {
    #mine: _f$mine,
    #state: _f$state,
    #message: _f$message,
    #error: _f$error,
  };

  static MerchantState _instantiate(DecodingData data) {
    return MerchantState(
      mine: data.dec(_f$mine),
      state: data.dec(_f$state),
      message: data.dec(_f$message),
      error: data.dec(_f$error),
    );
  }

  @override
  final Function instantiate = _instantiate;
}

mixin MerchantStateMappable {
  MerchantStateCopyWith<MerchantState, MerchantState, MerchantState>
  get copyWith => _MerchantStateCopyWithImpl<MerchantState, MerchantState>(
    this as MerchantState,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return MerchantStateMapper.ensureInitialized().stringifyValue(
      this as MerchantState,
    );
  }

  @override
  bool operator ==(Object other) {
    return MerchantStateMapper.ensureInitialized().equalsValue(
      this as MerchantState,
      other,
    );
  }

  @override
  int get hashCode {
    return MerchantStateMapper.ensureInitialized().hashValue(
      this as MerchantState,
    );
  }
}

extension MerchantStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, MerchantState, $Out> {
  MerchantStateCopyWith<$R, MerchantState, $Out> get $asMerchantState =>
      $base.as((v, t, t2) => _MerchantStateCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class MerchantStateCopyWith<$R, $In extends MerchantState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    Merchant? mine,
    CubitState? state,
    String? message,
    BaseError? error,
  });
  MerchantStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _MerchantStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MerchantState, $Out>
    implements MerchantStateCopyWith<$R, MerchantState, $Out> {
  _MerchantStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MerchantState> $mapper =
      MerchantStateMapper.ensureInitialized();
  @override
  $R call({
    Object? mine = $none,
    CubitState? state,
    Object? message = $none,
    Object? error = $none,
  }) => $apply(
    FieldCopyWithData({
      if (mine != $none) #mine: mine,
      if (state != null) #state: state,
      if (message != $none) #message: message,
      if (error != $none) #error: error,
    }),
  );
  @override
  MerchantState $make(CopyWithData data) => MerchantState(
    mine: data.get(#mine, or: $value.mine),
    state: data.get(#state, or: $value.state),
    message: data.get(#message, or: $value.message),
    error: data.get(#error, or: $value.error),
  );

  @override
  MerchantStateCopyWith<$R2, MerchantState, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _MerchantStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

