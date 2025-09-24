// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_menu_create_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MerchantMenuCreateRequest extends MerchantMenuCreateRequest {
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

  factory _$MerchantMenuCreateRequest([
    void Function(MerchantMenuCreateRequestBuilder)? updates,
  ]) => (MerchantMenuCreateRequestBuilder()..update(updates))._build();

  _$MerchantMenuCreateRequest._({
    required this.merchantId,
    required this.name,
    this.category,
    required this.price,
    required this.stock,
  }) : super._();
  @override
  MerchantMenuCreateRequest rebuild(
    void Function(MerchantMenuCreateRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  MerchantMenuCreateRequestBuilder toBuilder() =>
      MerchantMenuCreateRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MerchantMenuCreateRequest &&
        merchantId == other.merchantId &&
        name == other.name &&
        category == other.category &&
        price == other.price &&
        stock == other.stock;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, merchantId.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, category.hashCode);
    _$hash = $jc(_$hash, price.hashCode);
    _$hash = $jc(_$hash, stock.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MerchantMenuCreateRequest')
          ..add('merchantId', merchantId)
          ..add('name', name)
          ..add('category', category)
          ..add('price', price)
          ..add('stock', stock))
        .toString();
  }
}

class MerchantMenuCreateRequestBuilder
    implements
        Builder<MerchantMenuCreateRequest, MerchantMenuCreateRequestBuilder> {
  _$MerchantMenuCreateRequest? _$v;

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

  MerchantMenuCreateRequestBuilder() {
    MerchantMenuCreateRequest._defaults(this);
  }

  MerchantMenuCreateRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _merchantId = $v.merchantId;
      _name = $v.name;
      _category = $v.category;
      _price = $v.price;
      _stock = $v.stock;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MerchantMenuCreateRequest other) {
    _$v = other as _$MerchantMenuCreateRequest;
  }

  @override
  void update(void Function(MerchantMenuCreateRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MerchantMenuCreateRequest build() => _build();

  _$MerchantMenuCreateRequest _build() {
    final _$result =
        _$v ??
        _$MerchantMenuCreateRequest._(
          merchantId: BuiltValueNullFieldError.checkNotNull(
            merchantId,
            r'MerchantMenuCreateRequest',
            'merchantId',
          ),
          name: BuiltValueNullFieldError.checkNotNull(
            name,
            r'MerchantMenuCreateRequest',
            'name',
          ),
          category: category,
          price: BuiltValueNullFieldError.checkNotNull(
            price,
            r'MerchantMenuCreateRequest',
            'price',
          ),
          stock: BuiltValueNullFieldError.checkNotNull(
            stock,
            r'MerchantMenuCreateRequest',
            'stock',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
