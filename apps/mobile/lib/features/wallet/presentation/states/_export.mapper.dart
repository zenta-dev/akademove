// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of '_export.dart';

class UserWalletStateMapper extends ClassMapperBase<UserWalletState> {
  UserWalletStateMapper._();

  static UserWalletStateMapper? _instance;
  static UserWalletStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UserWalletStateMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'UserWalletState';

  static Wallet? _$myWallet(UserWalletState v) => v.myWallet;
  static const Field<UserWalletState, Wallet> _f$myWallet = Field(
    'myWallet',
    _$myWallet,
    opt: true,
  );
  static List<WalletTransaction> _$myTransactions(UserWalletState v) =>
      v.myTransactions;
  static const Field<UserWalletState, List<WalletTransaction>>
  _f$myTransactions = Field(
    'myTransactions',
    _$myTransactions,
    opt: true,
    def: const [],
  );
  static WalletMonthlySummaryResponse? _$thisMonthSummary(UserWalletState v) =>
      v.thisMonthSummary;
  static const Field<UserWalletState, WalletMonthlySummaryResponse>
  _f$thisMonthSummary = Field(
    'thisMonthSummary',
    _$thisMonthSummary,
    opt: true,
  );
  static CubitState _$state(UserWalletState v) => v.state;
  static const Field<UserWalletState, CubitState> _f$state = Field(
    'state',
    _$state,
    opt: true,
    def: CubitState.initial,
  );
  static String? _$message(UserWalletState v) => v.message;
  static const Field<UserWalletState, String> _f$message = Field(
    'message',
    _$message,
    opt: true,
  );
  static BaseError? _$error(UserWalletState v) => v.error;
  static const Field<UserWalletState, BaseError> _f$error = Field(
    'error',
    _$error,
    opt: true,
  );

  @override
  final MappableFields<UserWalletState> fields = const {
    #myWallet: _f$myWallet,
    #myTransactions: _f$myTransactions,
    #thisMonthSummary: _f$thisMonthSummary,
    #state: _f$state,
    #message: _f$message,
    #error: _f$error,
  };

  static UserWalletState _instantiate(DecodingData data) {
    return UserWalletState(
      myWallet: data.dec(_f$myWallet),
      myTransactions: data.dec(_f$myTransactions),
      thisMonthSummary: data.dec(_f$thisMonthSummary),
      state: data.dec(_f$state),
      message: data.dec(_f$message),
      error: data.dec(_f$error),
    );
  }

  @override
  final Function instantiate = _instantiate;
}

mixin UserWalletStateMappable {
  UserWalletStateCopyWith<UserWalletState, UserWalletState, UserWalletState>
  get copyWith =>
      _UserWalletStateCopyWithImpl<UserWalletState, UserWalletState>(
        this as UserWalletState,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return UserWalletStateMapper.ensureInitialized().stringifyValue(
      this as UserWalletState,
    );
  }

  @override
  bool operator ==(Object other) {
    return UserWalletStateMapper.ensureInitialized().equalsValue(
      this as UserWalletState,
      other,
    );
  }

  @override
  int get hashCode {
    return UserWalletStateMapper.ensureInitialized().hashValue(
      this as UserWalletState,
    );
  }
}

extension UserWalletStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, UserWalletState, $Out> {
  UserWalletStateCopyWith<$R, UserWalletState, $Out> get $asUserWalletState =>
      $base.as((v, t, t2) => _UserWalletStateCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class UserWalletStateCopyWith<$R, $In extends UserWalletState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    WalletTransaction,
    ObjectCopyWith<$R, WalletTransaction, WalletTransaction>
  >
  get myTransactions;
  $R call({
    Wallet? myWallet,
    List<WalletTransaction>? myTransactions,
    WalletMonthlySummaryResponse? thisMonthSummary,
    CubitState? state,
    String? message,
    BaseError? error,
  });
  UserWalletStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _UserWalletStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, UserWalletState, $Out>
    implements UserWalletStateCopyWith<$R, UserWalletState, $Out> {
  _UserWalletStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<UserWalletState> $mapper =
      UserWalletStateMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    WalletTransaction,
    ObjectCopyWith<$R, WalletTransaction, WalletTransaction>
  >
  get myTransactions => ListCopyWith(
    $value.myTransactions,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(myTransactions: v),
  );
  @override
  $R call({
    Object? myWallet = $none,
    List<WalletTransaction>? myTransactions,
    Object? thisMonthSummary = $none,
    CubitState? state,
    Object? message = $none,
    Object? error = $none,
  }) => $apply(
    FieldCopyWithData({
      if (myWallet != $none) #myWallet: myWallet,
      if (myTransactions != null) #myTransactions: myTransactions,
      if (thisMonthSummary != $none) #thisMonthSummary: thisMonthSummary,
      if (state != null) #state: state,
      if (message != $none) #message: message,
      if (error != $none) #error: error,
    }),
  );
  @override
  UserWalletState $make(CopyWithData data) => UserWalletState(
    myWallet: data.get(#myWallet, or: $value.myWallet),
    myTransactions: data.get(#myTransactions, or: $value.myTransactions),
    thisMonthSummary: data.get(#thisMonthSummary, or: $value.thisMonthSummary),
    state: data.get(#state, or: $value.state),
    message: data.get(#message, or: $value.message),
    error: data.get(#error, or: $value.error),
  );

  @override
  UserWalletStateCopyWith<$R2, UserWalletState, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _UserWalletStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class UserWalletTopUpStateMapper extends ClassMapperBase<UserWalletTopUpState> {
  UserWalletTopUpStateMapper._();

  static UserWalletTopUpStateMapper? _instance;
  static UserWalletTopUpStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UserWalletTopUpStateMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'UserWalletTopUpState';

  static Payment? _$paymentResult(UserWalletTopUpState v) => v.paymentResult;
  static const Field<UserWalletTopUpState, Payment> _f$paymentResult = Field(
    'paymentResult',
    _$paymentResult,
    opt: true,
  );
  static WalletTransaction? _$transactionResult(UserWalletTopUpState v) =>
      v.transactionResult;
  static const Field<UserWalletTopUpState, WalletTransaction>
  _f$transactionResult = Field(
    'transactionResult',
    _$transactionResult,
    opt: true,
  );
  static CubitState _$state(UserWalletTopUpState v) => v.state;
  static const Field<UserWalletTopUpState, CubitState> _f$state = Field(
    'state',
    _$state,
    opt: true,
    def: CubitState.initial,
  );
  static String? _$message(UserWalletTopUpState v) => v.message;
  static const Field<UserWalletTopUpState, String> _f$message = Field(
    'message',
    _$message,
    opt: true,
  );
  static BaseError? _$error(UserWalletTopUpState v) => v.error;
  static const Field<UserWalletTopUpState, BaseError> _f$error = Field(
    'error',
    _$error,
    opt: true,
  );

  @override
  final MappableFields<UserWalletTopUpState> fields = const {
    #paymentResult: _f$paymentResult,
    #transactionResult: _f$transactionResult,
    #state: _f$state,
    #message: _f$message,
    #error: _f$error,
  };

  static UserWalletTopUpState _instantiate(DecodingData data) {
    return UserWalletTopUpState(
      paymentResult: data.dec(_f$paymentResult),
      transactionResult: data.dec(_f$transactionResult),
      state: data.dec(_f$state),
      message: data.dec(_f$message),
      error: data.dec(_f$error),
    );
  }

  @override
  final Function instantiate = _instantiate;
}

mixin UserWalletTopUpStateMappable {
  UserWalletTopUpStateCopyWith<
    UserWalletTopUpState,
    UserWalletTopUpState,
    UserWalletTopUpState
  >
  get copyWith =>
      _UserWalletTopUpStateCopyWithImpl<
        UserWalletTopUpState,
        UserWalletTopUpState
      >(this as UserWalletTopUpState, $identity, $identity);
  @override
  String toString() {
    return UserWalletTopUpStateMapper.ensureInitialized().stringifyValue(
      this as UserWalletTopUpState,
    );
  }

  @override
  bool operator ==(Object other) {
    return UserWalletTopUpStateMapper.ensureInitialized().equalsValue(
      this as UserWalletTopUpState,
      other,
    );
  }

  @override
  int get hashCode {
    return UserWalletTopUpStateMapper.ensureInitialized().hashValue(
      this as UserWalletTopUpState,
    );
  }
}

extension UserWalletTopUpStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, UserWalletTopUpState, $Out> {
  UserWalletTopUpStateCopyWith<$R, UserWalletTopUpState, $Out>
  get $asUserWalletTopUpState => $base.as(
    (v, t, t2) => _UserWalletTopUpStateCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class UserWalletTopUpStateCopyWith<
  $R,
  $In extends UserWalletTopUpState,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    Payment? paymentResult,
    WalletTransaction? transactionResult,
    CubitState? state,
    String? message,
    BaseError? error,
  });
  UserWalletTopUpStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _UserWalletTopUpStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, UserWalletTopUpState, $Out>
    implements UserWalletTopUpStateCopyWith<$R, UserWalletTopUpState, $Out> {
  _UserWalletTopUpStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<UserWalletTopUpState> $mapper =
      UserWalletTopUpStateMapper.ensureInitialized();
  @override
  $R call({
    Object? paymentResult = $none,
    Object? transactionResult = $none,
    CubitState? state,
    Object? message = $none,
    Object? error = $none,
  }) => $apply(
    FieldCopyWithData({
      if (paymentResult != $none) #paymentResult: paymentResult,
      if (transactionResult != $none) #transactionResult: transactionResult,
      if (state != null) #state: state,
      if (message != $none) #message: message,
      if (error != $none) #error: error,
    }),
  );
  @override
  UserWalletTopUpState $make(CopyWithData data) => UserWalletTopUpState(
    paymentResult: data.get(#paymentResult, or: $value.paymentResult),
    transactionResult: data.get(
      #transactionResult,
      or: $value.transactionResult,
    ),
    state: data.get(#state, or: $value.state),
    message: data.get(#message, or: $value.message),
    error: data.get(#error, or: $value.error),
  );

  @override
  UserWalletTopUpStateCopyWith<$R2, UserWalletTopUpState, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _UserWalletTopUpStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

