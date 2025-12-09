// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of '_export.dart';

class CartStateMapper extends ClassMapperBase<CartState> {
  CartStateMapper._();

  static CartStateMapper? _instance;
  static CartStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CartStateMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'CartState';

  static Cart? _$cart(CartState v) => v.cart;
  static const Field<CartState, Cart> _f$cart = Field(
    'cart',
    _$cart,
    opt: true,
  );
  static CartItem? _$pendingItem(CartState v) => v.pendingItem;
  static const Field<CartState, CartItem> _f$pendingItem = Field(
    'pendingItem',
    _$pendingItem,
    opt: true,
  );
  static String? _$pendingMerchantName(CartState v) => v.pendingMerchantName;
  static const Field<CartState, String> _f$pendingMerchantName = Field(
    'pendingMerchantName',
    _$pendingMerchantName,
    opt: true,
  );
  static bool _$showMerchantConflict(CartState v) => v.showMerchantConflict;
  static const Field<CartState, bool> _f$showMerchantConflict = Field(
    'showMerchantConflict',
    _$showMerchantConflict,
    opt: true,
    def: false,
  );
  static CubitState _$state(CartState v) => v.state;
  static const Field<CartState, CubitState> _f$state = Field(
    'state',
    _$state,
    opt: true,
    def: CubitState.initial,
  );
  static String? _$message(CartState v) => v.message;
  static const Field<CartState, String> _f$message = Field(
    'message',
    _$message,
    opt: true,
  );
  static BaseError? _$error(CartState v) => v.error;
  static const Field<CartState, BaseError> _f$error = Field(
    'error',
    _$error,
    opt: true,
  );

  @override
  final MappableFields<CartState> fields = const {
    #cart: _f$cart,
    #pendingItem: _f$pendingItem,
    #pendingMerchantName: _f$pendingMerchantName,
    #showMerchantConflict: _f$showMerchantConflict,
    #state: _f$state,
    #message: _f$message,
    #error: _f$error,
  };

  static CartState _instantiate(DecodingData data) {
    return CartState(
      cart: data.dec(_f$cart),
      pendingItem: data.dec(_f$pendingItem),
      pendingMerchantName: data.dec(_f$pendingMerchantName),
      showMerchantConflict: data.dec(_f$showMerchantConflict),
      state: data.dec(_f$state),
      message: data.dec(_f$message),
      error: data.dec(_f$error),
    );
  }

  @override
  final Function instantiate = _instantiate;
}

mixin CartStateMappable {
  CartStateCopyWith<CartState, CartState, CartState> get copyWith =>
      _CartStateCopyWithImpl<CartState, CartState>(
        this as CartState,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return CartStateMapper.ensureInitialized().stringifyValue(
      this as CartState,
    );
  }

  @override
  bool operator ==(Object other) {
    return CartStateMapper.ensureInitialized().equalsValue(
      this as CartState,
      other,
    );
  }

  @override
  int get hashCode {
    return CartStateMapper.ensureInitialized().hashValue(this as CartState);
  }
}

extension CartStateValueCopy<$R, $Out> on ObjectCopyWith<$R, CartState, $Out> {
  CartStateCopyWith<$R, CartState, $Out> get $asCartState =>
      $base.as((v, t, t2) => _CartStateCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CartStateCopyWith<$R, $In extends CartState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    Cart? cart,
    CartItem? pendingItem,
    String? pendingMerchantName,
    bool? showMerchantConflict,
    CubitState? state,
    String? message,
    BaseError? error,
  });
  CartStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _CartStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CartState, $Out>
    implements CartStateCopyWith<$R, CartState, $Out> {
  _CartStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CartState> $mapper =
      CartStateMapper.ensureInitialized();
  @override
  $R call({
    Object? cart = $none,
    Object? pendingItem = $none,
    Object? pendingMerchantName = $none,
    bool? showMerchantConflict,
    CubitState? state,
    Object? message = $none,
    Object? error = $none,
  }) => $apply(
    FieldCopyWithData({
      if (cart != $none) #cart: cart,
      if (pendingItem != $none) #pendingItem: pendingItem,
      if (pendingMerchantName != $none)
        #pendingMerchantName: pendingMerchantName,
      if (showMerchantConflict != null)
        #showMerchantConflict: showMerchantConflict,
      if (state != null) #state: state,
      if (message != $none) #message: message,
      if (error != $none) #error: error,
    }),
  );
  @override
  CartState $make(CopyWithData data) => CartState(
    cart: data.get(#cart, or: $value.cart),
    pendingItem: data.get(#pendingItem, or: $value.pendingItem),
    pendingMerchantName: data.get(
      #pendingMerchantName,
      or: $value.pendingMerchantName,
    ),
    showMerchantConflict: data.get(
      #showMerchantConflict,
      or: $value.showMerchantConflict,
    ),
    state: data.get(#state, or: $value.state),
    message: data.get(#message, or: $value.message),
    error: data.get(#error, or: $value.error),
  );

  @override
  CartStateCopyWith<$R2, CartState, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _CartStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

