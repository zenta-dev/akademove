// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_update_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const MerchantUpdateRequestTypeEnum _$merchantUpdateRequestTypeEnum_merchant =
    const MerchantUpdateRequestTypeEnum._('merchant');
const MerchantUpdateRequestTypeEnum _$merchantUpdateRequestTypeEnum_tenant =
    const MerchantUpdateRequestTypeEnum._('tenant');

MerchantUpdateRequestTypeEnum _$merchantUpdateRequestTypeEnumValueOf(
  String name,
) {
  switch (name) {
    case 'merchant':
      return _$merchantUpdateRequestTypeEnum_merchant;
    case 'tenant':
      return _$merchantUpdateRequestTypeEnum_tenant;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<MerchantUpdateRequestTypeEnum>
_$merchantUpdateRequestTypeEnumValues = BuiltSet<MerchantUpdateRequestTypeEnum>(
  const <MerchantUpdateRequestTypeEnum>[
    _$merchantUpdateRequestTypeEnum_merchant,
    _$merchantUpdateRequestTypeEnum_tenant,
  ],
);

Serializer<MerchantUpdateRequestTypeEnum>
_$merchantUpdateRequestTypeEnumSerializer =
    _$MerchantUpdateRequestTypeEnumSerializer();

class _$MerchantUpdateRequestTypeEnumSerializer
    implements PrimitiveSerializer<MerchantUpdateRequestTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'merchant': 'merchant',
    'tenant': 'tenant',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'merchant': 'merchant',
    'tenant': 'tenant',
  };

  @override
  final Iterable<Type> types = const <Type>[MerchantUpdateRequestTypeEnum];
  @override
  final String wireName = 'MerchantUpdateRequestTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    MerchantUpdateRequestTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  MerchantUpdateRequestTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => MerchantUpdateRequestTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$MerchantUpdateRequest extends MerchantUpdateRequest {
  @override
  final MerchantUpdateRequestTypeEnum? type;
  @override
  final String? name;
  @override
  final String? address;
  @override
  final Location? location;
  @override
  final bool? isActive;

  factory _$MerchantUpdateRequest([
    void Function(MerchantUpdateRequestBuilder)? updates,
  ]) => (MerchantUpdateRequestBuilder()..update(updates))._build();

  _$MerchantUpdateRequest._({
    this.type,
    this.name,
    this.address,
    this.location,
    this.isActive,
  }) : super._();
  @override
  MerchantUpdateRequest rebuild(
    void Function(MerchantUpdateRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  MerchantUpdateRequestBuilder toBuilder() =>
      MerchantUpdateRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MerchantUpdateRequest &&
        type == other.type &&
        name == other.name &&
        address == other.address &&
        location == other.location &&
        isActive == other.isActive;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, address.hashCode);
    _$hash = $jc(_$hash, location.hashCode);
    _$hash = $jc(_$hash, isActive.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MerchantUpdateRequest')
          ..add('type', type)
          ..add('name', name)
          ..add('address', address)
          ..add('location', location)
          ..add('isActive', isActive))
        .toString();
  }
}

class MerchantUpdateRequestBuilder
    implements Builder<MerchantUpdateRequest, MerchantUpdateRequestBuilder> {
  _$MerchantUpdateRequest? _$v;

  MerchantUpdateRequestTypeEnum? _type;
  MerchantUpdateRequestTypeEnum? get type => _$this._type;
  set type(MerchantUpdateRequestTypeEnum? type) => _$this._type = type;

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

  MerchantUpdateRequestBuilder() {
    MerchantUpdateRequest._defaults(this);
  }

  MerchantUpdateRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _type = $v.type;
      _name = $v.name;
      _address = $v.address;
      _location = $v.location?.toBuilder();
      _isActive = $v.isActive;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MerchantUpdateRequest other) {
    _$v = other as _$MerchantUpdateRequest;
  }

  @override
  void update(void Function(MerchantUpdateRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MerchantUpdateRequest build() => _build();

  _$MerchantUpdateRequest _build() {
    _$MerchantUpdateRequest _$result;
    try {
      _$result =
          _$v ??
          _$MerchantUpdateRequest._(
            type: type,
            name: name,
            address: address,
            location: _location?.build(),
            isActive: isActive,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'location';
        _location?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'MerchantUpdateRequest',
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
