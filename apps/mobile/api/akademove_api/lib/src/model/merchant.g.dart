// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const MerchantTypeEnum _$merchantTypeEnum_merchant =
    const MerchantTypeEnum._('merchant');
const MerchantTypeEnum _$merchantTypeEnum_tenant =
    const MerchantTypeEnum._('tenant');

MerchantTypeEnum _$merchantTypeEnumValueOf(String name) {
  switch (name) {
    case 'merchant':
      return _$merchantTypeEnum_merchant;
    case 'tenant':
      return _$merchantTypeEnum_tenant;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<MerchantTypeEnum> _$merchantTypeEnumValues =
    BuiltSet<MerchantTypeEnum>(const <MerchantTypeEnum>[
  _$merchantTypeEnum_merchant,
  _$merchantTypeEnum_tenant,
]);

Serializer<MerchantTypeEnum> _$merchantTypeEnumSerializer =
    _$MerchantTypeEnumSerializer();

class _$MerchantTypeEnumSerializer
    implements PrimitiveSerializer<MerchantTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'merchant': 'merchant',
    'tenant': 'tenant',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'merchant': 'merchant',
    'tenant': 'tenant',
  };

  @override
  final Iterable<Type> types = const <Type>[MerchantTypeEnum];
  @override
  final String wireName = 'MerchantTypeEnum';

  @override
  Object serialize(Serializers serializers, MerchantTypeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  MerchantTypeEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      MerchantTypeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Merchant extends Merchant {
  @override
  final String id;
  @override
  final String userId;
  @override
  final MerchantTypeEnum type;
  @override
  final String name;
  @override
  final String address;
  @override
  final Location? location;
  @override
  final num rating;
  @override
  final num createdAt;
  @override
  final num updatedAt;
  @override
  final bool? isActive;

  factory _$Merchant([void Function(MerchantBuilder)? updates]) =>
      (MerchantBuilder()..update(updates))._build();

  _$Merchant._(
      {required this.id,
      required this.userId,
      required this.type,
      required this.name,
      required this.address,
      this.location,
      required this.rating,
      required this.createdAt,
      required this.updatedAt,
      this.isActive})
      : super._();
  @override
  Merchant rebuild(void Function(MerchantBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MerchantBuilder toBuilder() => MerchantBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Merchant &&
        id == other.id &&
        userId == other.userId &&
        type == other.type &&
        name == other.name &&
        address == other.address &&
        location == other.location &&
        rating == other.rating &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        isActive == other.isActive;
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
    _$hash = $jc(_$hash, rating.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, isActive.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Merchant')
          ..add('id', id)
          ..add('userId', userId)
          ..add('type', type)
          ..add('name', name)
          ..add('address', address)
          ..add('location', location)
          ..add('rating', rating)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('isActive', isActive))
        .toString();
  }
}

class MerchantBuilder implements Builder<Merchant, MerchantBuilder> {
  _$Merchant? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  MerchantTypeEnum? _type;
  MerchantTypeEnum? get type => _$this._type;
  set type(MerchantTypeEnum? type) => _$this._type = type;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _address;
  String? get address => _$this._address;
  set address(String? address) => _$this._address = address;

  LocationBuilder? _location;
  LocationBuilder get location => _$this._location ??= LocationBuilder();
  set location(LocationBuilder? location) => _$this._location = location;

  num? _rating;
  num? get rating => _$this._rating;
  set rating(num? rating) => _$this._rating = rating;

  num? _createdAt;
  num? get createdAt => _$this._createdAt;
  set createdAt(num? createdAt) => _$this._createdAt = createdAt;

  num? _updatedAt;
  num? get updatedAt => _$this._updatedAt;
  set updatedAt(num? updatedAt) => _$this._updatedAt = updatedAt;

  bool? _isActive;
  bool? get isActive => _$this._isActive;
  set isActive(bool? isActive) => _$this._isActive = isActive;

  MerchantBuilder() {
    Merchant._defaults(this);
  }

  MerchantBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _userId = $v.userId;
      _type = $v.type;
      _name = $v.name;
      _address = $v.address;
      _location = $v.location?.toBuilder();
      _rating = $v.rating;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _isActive = $v.isActive;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Merchant other) {
    _$v = other as _$Merchant;
  }

  @override
  void update(void Function(MerchantBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Merchant build() => _build();

  _$Merchant _build() {
    _$Merchant _$result;
    try {
      _$result = _$v ??
          _$Merchant._(
            id: BuiltValueNullFieldError.checkNotNull(id, r'Merchant', 'id'),
            userId: BuiltValueNullFieldError.checkNotNull(
                userId, r'Merchant', 'userId'),
            type: BuiltValueNullFieldError.checkNotNull(
                type, r'Merchant', 'type'),
            name: BuiltValueNullFieldError.checkNotNull(
                name, r'Merchant', 'name'),
            address: BuiltValueNullFieldError.checkNotNull(
                address, r'Merchant', 'address'),
            location: _location?.build(),
            rating: BuiltValueNullFieldError.checkNotNull(
                rating, r'Merchant', 'rating'),
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'Merchant', 'createdAt'),
            updatedAt: BuiltValueNullFieldError.checkNotNull(
                updatedAt, r'Merchant', 'updatedAt'),
            isActive: isActive,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'location';
        _location?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'Merchant', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
