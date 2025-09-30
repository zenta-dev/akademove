// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_create_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const MerchantCreateRequestTypeEnum _$merchantCreateRequestTypeEnum_merchant =
    const MerchantCreateRequestTypeEnum._('merchant');
const MerchantCreateRequestTypeEnum _$merchantCreateRequestTypeEnum_tenant =
    const MerchantCreateRequestTypeEnum._('tenant');

MerchantCreateRequestTypeEnum _$merchantCreateRequestTypeEnumValueOf(
  String name,
) {
  switch (name) {
    case 'merchant':
      return _$merchantCreateRequestTypeEnum_merchant;
    case 'tenant':
      return _$merchantCreateRequestTypeEnum_tenant;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<MerchantCreateRequestTypeEnum>
_$merchantCreateRequestTypeEnumValues = BuiltSet<MerchantCreateRequestTypeEnum>(
  const <MerchantCreateRequestTypeEnum>[
    _$merchantCreateRequestTypeEnum_merchant,
    _$merchantCreateRequestTypeEnum_tenant,
  ],
);

Serializer<MerchantCreateRequestTypeEnum>
_$merchantCreateRequestTypeEnumSerializer =
    _$MerchantCreateRequestTypeEnumSerializer();

class _$MerchantCreateRequestTypeEnumSerializer
    implements PrimitiveSerializer<MerchantCreateRequestTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'merchant': 'merchant',
    'tenant': 'tenant',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'merchant': 'merchant',
    'tenant': 'tenant',
  };

  @override
  final Iterable<Type> types = const <Type>[MerchantCreateRequestTypeEnum];
  @override
  final String wireName = 'MerchantCreateRequestTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    MerchantCreateRequestTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  MerchantCreateRequestTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => MerchantCreateRequestTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$MerchantCreateRequest extends MerchantCreateRequest {
  @override
  final MerchantCreateRequestTypeEnum? type;
  @override
  final String name;
  @override
  final String address;
  @override
  final Location? location;
  @override
  final bool isActive;

  factory _$MerchantCreateRequest([
    void Function(MerchantCreateRequestBuilder)? updates,
  ]) => (MerchantCreateRequestBuilder()..update(updates))._build();

  _$MerchantCreateRequest._({
    this.type,
    required this.name,
    required this.address,
    this.location,
    required this.isActive,
  }) : super._();
  @override
  MerchantCreateRequest rebuild(
    void Function(MerchantCreateRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  MerchantCreateRequestBuilder toBuilder() =>
      MerchantCreateRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MerchantCreateRequest &&
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
    return (newBuiltValueToStringHelper(r'MerchantCreateRequest')
          ..add('type', type)
          ..add('name', name)
          ..add('address', address)
          ..add('location', location)
          ..add('isActive', isActive))
        .toString();
  }
}

class MerchantCreateRequestBuilder
    implements Builder<MerchantCreateRequest, MerchantCreateRequestBuilder> {
  _$MerchantCreateRequest? _$v;

  MerchantCreateRequestTypeEnum? _type;
  MerchantCreateRequestTypeEnum? get type => _$this._type;
  set type(MerchantCreateRequestTypeEnum? type) => _$this._type = type;

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

  MerchantCreateRequestBuilder() {
    MerchantCreateRequest._defaults(this);
  }

  MerchantCreateRequestBuilder get _$this {
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
  void replace(MerchantCreateRequest other) {
    _$v = other as _$MerchantCreateRequest;
  }

  @override
  void update(void Function(MerchantCreateRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MerchantCreateRequest build() => _build();

  _$MerchantCreateRequest _build() {
    _$MerchantCreateRequest _$result;
    try {
      _$result =
          _$v ??
          _$MerchantCreateRequest._(
            type: type,
            name: BuiltValueNullFieldError.checkNotNull(
              name,
              r'MerchantCreateRequest',
              'name',
            ),
            address: BuiltValueNullFieldError.checkNotNull(
              address,
              r'MerchantCreateRequest',
              'address',
            ),
            location: _location?.build(),
            isActive: BuiltValueNullFieldError.checkNotNull(
              isActive,
              r'MerchantCreateRequest',
              'isActive',
            ),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'location';
        _location?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'MerchantCreateRequest',
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
