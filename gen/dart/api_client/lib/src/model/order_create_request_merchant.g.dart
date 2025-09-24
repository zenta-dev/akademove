// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_create_request_merchant.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const OrderCreateRequestMerchantTypeEnum
_$orderCreateRequestMerchantTypeEnum_merchant =
    const OrderCreateRequestMerchantTypeEnum._('merchant');
const OrderCreateRequestMerchantTypeEnum
_$orderCreateRequestMerchantTypeEnum_tenant =
    const OrderCreateRequestMerchantTypeEnum._('tenant');

OrderCreateRequestMerchantTypeEnum _$orderCreateRequestMerchantTypeEnumValueOf(
  String name,
) {
  switch (name) {
    case 'merchant':
      return _$orderCreateRequestMerchantTypeEnum_merchant;
    case 'tenant':
      return _$orderCreateRequestMerchantTypeEnum_tenant;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<OrderCreateRequestMerchantTypeEnum>
_$orderCreateRequestMerchantTypeEnumValues =
    BuiltSet<OrderCreateRequestMerchantTypeEnum>(
      const <OrderCreateRequestMerchantTypeEnum>[
        _$orderCreateRequestMerchantTypeEnum_merchant,
        _$orderCreateRequestMerchantTypeEnum_tenant,
      ],
    );

Serializer<OrderCreateRequestMerchantTypeEnum>
_$orderCreateRequestMerchantTypeEnumSerializer =
    _$OrderCreateRequestMerchantTypeEnumSerializer();

class _$OrderCreateRequestMerchantTypeEnumSerializer
    implements PrimitiveSerializer<OrderCreateRequestMerchantTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'merchant': 'merchant',
    'tenant': 'tenant',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'merchant': 'merchant',
    'tenant': 'tenant',
  };

  @override
  final Iterable<Type> types = const <Type>[OrderCreateRequestMerchantTypeEnum];
  @override
  final String wireName = 'OrderCreateRequestMerchantTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    OrderCreateRequestMerchantTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  OrderCreateRequestMerchantTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => OrderCreateRequestMerchantTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$OrderCreateRequestMerchant extends OrderCreateRequestMerchant {
  @override
  final String? id;
  @override
  final String? userId;
  @override
  final OrderCreateRequestMerchantTypeEnum? type;
  @override
  final String? name;
  @override
  final String? address;
  @override
  final Location? location;
  @override
  final bool? isActive;
  @override
  final num? rating;
  @override
  final num? createdAt;
  @override
  final num? updatedAt;

  factory _$OrderCreateRequestMerchant([
    void Function(OrderCreateRequestMerchantBuilder)? updates,
  ]) => (OrderCreateRequestMerchantBuilder()..update(updates))._build();

  _$OrderCreateRequestMerchant._({
    this.id,
    this.userId,
    this.type,
    this.name,
    this.address,
    this.location,
    this.isActive,
    this.rating,
    this.createdAt,
    this.updatedAt,
  }) : super._();
  @override
  OrderCreateRequestMerchant rebuild(
    void Function(OrderCreateRequestMerchantBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  OrderCreateRequestMerchantBuilder toBuilder() =>
      OrderCreateRequestMerchantBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OrderCreateRequestMerchant &&
        id == other.id &&
        userId == other.userId &&
        type == other.type &&
        name == other.name &&
        address == other.address &&
        location == other.location &&
        isActive == other.isActive &&
        rating == other.rating &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, address.hashCode);
    _$hash = $jc(_$hash, location.hashCode);
    _$hash = $jc(_$hash, isActive.hashCode);
    _$hash = $jc(_$hash, rating.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'OrderCreateRequestMerchant')
          ..add('id', id)
          ..add('userId', userId)
          ..add('type', type)
          ..add('name', name)
          ..add('address', address)
          ..add('location', location)
          ..add('isActive', isActive)
          ..add('rating', rating)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class OrderCreateRequestMerchantBuilder
    implements
        Builder<OrderCreateRequestMerchant, OrderCreateRequestMerchantBuilder> {
  _$OrderCreateRequestMerchant? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  OrderCreateRequestMerchantTypeEnum? _type;
  OrderCreateRequestMerchantTypeEnum? get type => _$this._type;
  set type(OrderCreateRequestMerchantTypeEnum? type) => _$this._type = type;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _address;
  String? get address => _$this._address;
  set address(String? address) => _$this._address = address;

  LocationBuilder? _location;
  LocationBuilder get location => _$this._location ??= LocationBuilder();
  set location(LocationBuilder? location) => _$this._location = location;

  bool? _isActive;
  bool? get isActive => _$this._isActive;
  set isActive(bool? isActive) => _$this._isActive = isActive;

  num? _rating;
  num? get rating => _$this._rating;
  set rating(num? rating) => _$this._rating = rating;

  num? _createdAt;
  num? get createdAt => _$this._createdAt;
  set createdAt(num? createdAt) => _$this._createdAt = createdAt;

  num? _updatedAt;
  num? get updatedAt => _$this._updatedAt;
  set updatedAt(num? updatedAt) => _$this._updatedAt = updatedAt;

  OrderCreateRequestMerchantBuilder() {
    OrderCreateRequestMerchant._defaults(this);
  }

  OrderCreateRequestMerchantBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _userId = $v.userId;
      _type = $v.type;
      _name = $v.name;
      _address = $v.address;
      _location = $v.location?.toBuilder();
      _isActive = $v.isActive;
      _rating = $v.rating;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OrderCreateRequestMerchant other) {
    _$v = other as _$OrderCreateRequestMerchant;
  }

  @override
  void update(void Function(OrderCreateRequestMerchantBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  OrderCreateRequestMerchant build() => _build();

  _$OrderCreateRequestMerchant _build() {
    _$OrderCreateRequestMerchant _$result;
    try {
      _$result =
          _$v ??
          _$OrderCreateRequestMerchant._(
            id: id,
            userId: userId,
            type: type,
            name: name,
            address: address,
            location: _location?.build(),
            isActive: isActive,
            rating: rating,
            createdAt: createdAt,
            updatedAt: updatedAt,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'location';
        _location?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'OrderCreateRequestMerchant',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
