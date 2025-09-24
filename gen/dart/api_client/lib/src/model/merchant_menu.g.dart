// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_menu.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MerchantMenu extends MerchantMenu {
  @override
  final String id;
  @override
  final String merchantId;
  @override
  final String name;
  @override
  final String? category;
  @override
  final num price;
  @override
  final num stock;
  @override
  final num createdAt;
  @override
  final num updatedAt;

  factory _$MerchantMenu([void Function(MerchantMenuBuilder)? updates]) =>
      (MerchantMenuBuilder()..update(updates))._build();

  _$MerchantMenu._({
    required this.id,
    required this.merchantId,
    required this.name,
    this.category,
    required this.price,
    required this.stock,
    required this.createdAt,
    required this.updatedAt,
  }) : super._();
  @override
  MerchantMenu rebuild(void Function(MerchantMenuBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MerchantMenuBuilder toBuilder() => MerchantMenuBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MerchantMenu &&
        id == other.id &&
        merchantId == other.merchantId &&
        name == other.name &&
        category == other.category &&
        price == other.price &&
        stock == other.stock &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, merchantId.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, category.hashCode);
    _$hash = $jc(_$hash, price.hashCode);
    _$hash = $jc(_$hash, stock.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MerchantMenu')
          ..add('id', id)
          ..add('merchantId', merchantId)
          ..add('name', name)
          ..add('category', category)
          ..add('price', price)
          ..add('stock', stock)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class MerchantMenuBuilder
    implements Builder<MerchantMenu, MerchantMenuBuilder> {
  _$MerchantMenu? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _merchantId;
  String? get merchantId => _$this._merchantId;
  set merchantId(String? merchantId) => _$this._merchantId = merchantId;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _category;
  String? get category => _$this._category;
  set category(String? category) => _$this._category = category;

  num? _price;
  num? get price => _$this._price;
  set price(num? price) => _$this._price = price;

  num? _stock;
  num? get stock => _$this._stock;
  set stock(num? stock) => _$this._stock = stock;

  num? _createdAt;
  num? get createdAt => _$this._createdAt;
  set createdAt(num? createdAt) => _$this._createdAt = createdAt;

  num? _updatedAt;
  num? get updatedAt => _$this._updatedAt;
  set updatedAt(num? updatedAt) => _$this._updatedAt = updatedAt;

  MerchantMenuBuilder() {
    MerchantMenu._defaults(this);
  }

  MerchantMenuBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _merchantId = $v.merchantId;
      _name = $v.name;
      _category = $v.category;
      _price = $v.price;
      _stock = $v.stock;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MerchantMenu other) {
    _$v = other as _$MerchantMenu;
  }

  @override
  void update(void Function(MerchantMenuBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MerchantMenu build() => _build();

  _$MerchantMenu _build() {
    final _$result =
        _$v ??
        _$MerchantMenu._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'MerchantMenu', 'id'),
          merchantId: BuiltValueNullFieldError.checkNotNull(
            merchantId,
            r'MerchantMenu',
            'merchantId',
          ),
          name: BuiltValueNullFieldError.checkNotNull(
            name,
            r'MerchantMenu',
            'name',
          ),
          category: category,
          price: BuiltValueNullFieldError.checkNotNull(
            price,
            r'MerchantMenu',
            'price',
          ),
          stock: BuiltValueNullFieldError.checkNotNull(
            stock,
            r'MerchantMenu',
            'stock',
          ),
          createdAt: BuiltValueNullFieldError.checkNotNull(
            createdAt,
            r'MerchantMenu',
            'createdAt',
          ),
          updatedAt: BuiltValueNullFieldError.checkNotNull(
            updatedAt,
            r'MerchantMenu',
            'updatedAt',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
