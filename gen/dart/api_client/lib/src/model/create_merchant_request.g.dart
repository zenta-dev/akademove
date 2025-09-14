// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_merchant_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const CreateMerchantRequestTypeEnum _$createMerchantRequestTypeEnum_merchant =
    const CreateMerchantRequestTypeEnum._('merchant');
const CreateMerchantRequestTypeEnum _$createMerchantRequestTypeEnum_tenant =
    const CreateMerchantRequestTypeEnum._('tenant');

CreateMerchantRequestTypeEnum _$createMerchantRequestTypeEnumValueOf(
  String name,
) {
  switch (name) {
    case 'merchant':
      return _$createMerchantRequestTypeEnum_merchant;
    case 'tenant':
      return _$createMerchantRequestTypeEnum_tenant;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<CreateMerchantRequestTypeEnum>
_$createMerchantRequestTypeEnumValues = BuiltSet<CreateMerchantRequestTypeEnum>(
  const <CreateMerchantRequestTypeEnum>[
    _$createMerchantRequestTypeEnum_merchant,
    _$createMerchantRequestTypeEnum_tenant,
  ],
);

Serializer<CreateMerchantRequestTypeEnum>
_$createMerchantRequestTypeEnumSerializer =
    _$CreateMerchantRequestTypeEnumSerializer();

class _$CreateMerchantRequestTypeEnumSerializer
    implements PrimitiveSerializer<CreateMerchantRequestTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'merchant': 'merchant',
    'tenant': 'tenant',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'merchant': 'merchant',
    'tenant': 'tenant',
  };

  @override
  final Iterable<Type> types = const <Type>[CreateMerchantRequestTypeEnum];
  @override
  final String wireName = 'CreateMerchantRequestTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    CreateMerchantRequestTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  CreateMerchantRequestTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => CreateMerchantRequestTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$CreateMerchantRequest extends CreateMerchantRequest {
  @override
  final CreateMerchantRequestTypeEnum type;
  @override
  final String name;
  @override
  final String address;
  @override
  final Location? location;
  @override
  final bool? isActive;

  factory _$CreateMerchantRequest([
    void Function(CreateMerchantRequestBuilder)? updates,
  ]) => (CreateMerchantRequestBuilder()..update(updates))._build();

  _$CreateMerchantRequest._({
    required this.type,
    required this.name,
    required this.address,
    this.location,
    this.isActive,
  }) : super._();
  @override
  CreateMerchantRequest rebuild(
    void Function(CreateMerchantRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CreateMerchantRequestBuilder toBuilder() =>
      CreateMerchantRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateMerchantRequest &&
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
    return (newBuiltValueToStringHelper(r'CreateMerchantRequest')
          ..add('type', type)
          ..add('name', name)
          ..add('address', address)
          ..add('location', location)
          ..add('isActive', isActive))
        .toString();
  }
}

class CreateMerchantRequestBuilder
    implements Builder<CreateMerchantRequest, CreateMerchantRequestBuilder> {
  _$CreateMerchantRequest? _$v;

  CreateMerchantRequestTypeEnum? _type;
  CreateMerchantRequestTypeEnum? get type => _$this._type;
  set type(CreateMerchantRequestTypeEnum? type) => _$this._type = type;

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

  CreateMerchantRequestBuilder() {
    CreateMerchantRequest._defaults(this);
  }

  CreateMerchantRequestBuilder get _$this {
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
  void replace(CreateMerchantRequest other) {
    _$v = other as _$CreateMerchantRequest;
  }

  @override
  void update(void Function(CreateMerchantRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateMerchantRequest build() => _build();

  _$CreateMerchantRequest _build() {
    _$CreateMerchantRequest _$result;
    try {
      _$result =
          _$v ??
          _$CreateMerchantRequest._(
            type: BuiltValueNullFieldError.checkNotNull(
              type,
              r'CreateMerchantRequest',
              'type',
            ),
            name: BuiltValueNullFieldError.checkNotNull(
              name,
              r'CreateMerchantRequest',
              'name',
            ),
            address: BuiltValueNullFieldError.checkNotNull(
              address,
              r'CreateMerchantRequest',
              'address',
            ),
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
          r'CreateMerchantRequest',
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
