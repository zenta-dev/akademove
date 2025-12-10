// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of '_export.dart';

class BestSellerItemMapper extends ClassMapperBase<BestSellerItem> {
  BestSellerItemMapper._();

  static BestSellerItemMapper? _instance;
  static BestSellerItemMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BestSellerItemMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'BestSellerItem';

  static MerchantMenu _$menu(BestSellerItem v) => v.menu;
  static const Field<BestSellerItem, MerchantMenu> _f$menu = Field(
    'menu',
    _$menu,
  );
  static String _$merchantName(BestSellerItem v) => v.merchantName;
  static const Field<BestSellerItem, String> _f$merchantName = Field(
    'merchantName',
    _$merchantName,
  );

  @override
  final MappableFields<BestSellerItem> fields = const {
    #menu: _f$menu,
    #merchantName: _f$merchantName,
  };

  static BestSellerItem _instantiate(DecodingData data) {
    return BestSellerItem(
      menu: data.dec(_f$menu),
      merchantName: data.dec(_f$merchantName),
    );
  }

  @override
  final Function instantiate = _instantiate;
}

mixin BestSellerItemMappable {
  BestSellerItemCopyWith<BestSellerItem, BestSellerItem, BestSellerItem>
  get copyWith => _BestSellerItemCopyWithImpl<BestSellerItem, BestSellerItem>(
    this as BestSellerItem,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return BestSellerItemMapper.ensureInitialized().stringifyValue(
      this as BestSellerItem,
    );
  }

  @override
  bool operator ==(Object other) {
    return BestSellerItemMapper.ensureInitialized().equalsValue(
      this as BestSellerItem,
      other,
    );
  }

  @override
  int get hashCode {
    return BestSellerItemMapper.ensureInitialized().hashValue(
      this as BestSellerItem,
    );
  }
}

extension BestSellerItemValueCopy<$R, $Out>
    on ObjectCopyWith<$R, BestSellerItem, $Out> {
  BestSellerItemCopyWith<$R, BestSellerItem, $Out> get $asBestSellerItem =>
      $base.as((v, t, t2) => _BestSellerItemCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class BestSellerItemCopyWith<$R, $In extends BestSellerItem, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({MerchantMenu? menu, String? merchantName});
  BestSellerItemCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _BestSellerItemCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BestSellerItem, $Out>
    implements BestSellerItemCopyWith<$R, BestSellerItem, $Out> {
  _BestSellerItemCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BestSellerItem> $mapper =
      BestSellerItemMapper.ensureInitialized();
  @override
  $R call({MerchantMenu? menu, String? merchantName}) => $apply(
    FieldCopyWithData({
      if (menu != null) #menu: menu,
      if (merchantName != null) #merchantName: merchantName,
    }),
  );
  @override
  BestSellerItem $make(CopyWithData data) => BestSellerItem(
    menu: data.get(#menu, or: $value.menu),
    merchantName: data.get(#merchantName, or: $value.merchantName),
  );

  @override
  BestSellerItemCopyWith<$R2, BestSellerItem, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _BestSellerItemCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

