// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_menu_update_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MerchantMenuUpdateRequest extends MerchantMenuUpdateRequest {
  @override
  final String? merchantId;
  @override
  final String? name;
  @override
  final String? category;
  @override
  final num? price;
  @override
  final num? stock;

  factory _$MerchantMenuUpdateRequest([
    void Function(MerchantMenuUpdateRequestBuilder)? updates,
  ]) => (MerchantMenuUpdateRequestBuilder()..update(updates))._build();

  _$MerchantMenuUpdateRequest._({
    this.merchantId,
    this.name,
    this.category,
    this.price,
    this.stock,
  }) : super._();
  @override
  MerchantMenuUpdateRequest rebuild(
    void Function(MerchantMenuUpdateRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  MerchantMenuUpdateRequestBuilder toBuilder() =>
      MerchantMenuUpdateRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MerchantMenuUpdateRequest &&
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
    return (newBuiltValueToStringHelper(r'MerchantMenuUpdateRequest')
          ..add('merchantId', merchantId)
          ..add('name', name)
          ..add('category', category)
          ..add('price', price)
          ..add('stock', stock))
        .toString();
  }
}

class MerchantMenuUpdateRequestBuilder
    implements
        Builder<MerchantMenuUpdateRequest, MerchantMenuUpdateRequestBuilder> {
  _$MerchantMenuUpdateRequest? _$v;

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

  MerchantMenuUpdateRequestBuilder() {
    MerchantMenuUpdateRequest._defaults(this);
  }

  MerchantMenuUpdateRequestBuilder get _$this {
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
  void replace(MerchantMenuUpdateRequest other) {
    _$v = other as _$MerchantMenuUpdateRequest;
  }

  @override
  void update(void Function(MerchantMenuUpdateRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MerchantMenuUpdateRequest build() => _build();

  _$MerchantMenuUpdateRequest _build() {
    final _$result =
        _$v ??
        _$MerchantMenuUpdateRequest._(
          merchantId: merchantId,
          name: name,
          category: category,
          price: price,
          stock: stock,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
