// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_order_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const CreateOrderRequestTypeEnum _$createOrderRequestTypeEnum_ride =
    const CreateOrderRequestTypeEnum._('ride');
const CreateOrderRequestTypeEnum _$createOrderRequestTypeEnum_delivery =
    const CreateOrderRequestTypeEnum._('delivery');
const CreateOrderRequestTypeEnum _$createOrderRequestTypeEnum_food =
    const CreateOrderRequestTypeEnum._('food');

CreateOrderRequestTypeEnum _$createOrderRequestTypeEnumValueOf(String name) {
  switch (name) {
    case 'ride':
      return _$createOrderRequestTypeEnum_ride;
    case 'delivery':
      return _$createOrderRequestTypeEnum_delivery;
    case 'food':
      return _$createOrderRequestTypeEnum_food;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<CreateOrderRequestTypeEnum> _$createOrderRequestTypeEnumValues =
    BuiltSet<CreateOrderRequestTypeEnum>(const <CreateOrderRequestTypeEnum>[
  _$createOrderRequestTypeEnum_ride,
  _$createOrderRequestTypeEnum_delivery,
  _$createOrderRequestTypeEnum_food,
]);

const CreateOrderRequestStatusEnum _$createOrderRequestStatusEnum_requested =
    const CreateOrderRequestStatusEnum._('requested');
const CreateOrderRequestStatusEnum _$createOrderRequestStatusEnum_matching =
    const CreateOrderRequestStatusEnum._('matching');
const CreateOrderRequestStatusEnum _$createOrderRequestStatusEnum_accepted =
    const CreateOrderRequestStatusEnum._('accepted');
const CreateOrderRequestStatusEnum _$createOrderRequestStatusEnum_arriving =
    const CreateOrderRequestStatusEnum._('arriving');
const CreateOrderRequestStatusEnum _$createOrderRequestStatusEnum_inTrip =
    const CreateOrderRequestStatusEnum._('inTrip');
const CreateOrderRequestStatusEnum _$createOrderRequestStatusEnum_completed =
    const CreateOrderRequestStatusEnum._('completed');
const CreateOrderRequestStatusEnum
    _$createOrderRequestStatusEnum_cancelledByUser =
    const CreateOrderRequestStatusEnum._('cancelledByUser');
const CreateOrderRequestStatusEnum
    _$createOrderRequestStatusEnum_cancelledByDriver =
    const CreateOrderRequestStatusEnum._('cancelledByDriver');
const CreateOrderRequestStatusEnum
    _$createOrderRequestStatusEnum_cancelledBySystem =
    const CreateOrderRequestStatusEnum._('cancelledBySystem');

CreateOrderRequestStatusEnum _$createOrderRequestStatusEnumValueOf(
    String name) {
  switch (name) {
    case 'requested':
      return _$createOrderRequestStatusEnum_requested;
    case 'matching':
      return _$createOrderRequestStatusEnum_matching;
    case 'accepted':
      return _$createOrderRequestStatusEnum_accepted;
    case 'arriving':
      return _$createOrderRequestStatusEnum_arriving;
    case 'inTrip':
      return _$createOrderRequestStatusEnum_inTrip;
    case 'completed':
      return _$createOrderRequestStatusEnum_completed;
    case 'cancelledByUser':
      return _$createOrderRequestStatusEnum_cancelledByUser;
    case 'cancelledByDriver':
      return _$createOrderRequestStatusEnum_cancelledByDriver;
    case 'cancelledBySystem':
      return _$createOrderRequestStatusEnum_cancelledBySystem;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<CreateOrderRequestStatusEnum>
    _$createOrderRequestStatusEnumValues =
    BuiltSet<CreateOrderRequestStatusEnum>(const <CreateOrderRequestStatusEnum>[
  _$createOrderRequestStatusEnum_requested,
  _$createOrderRequestStatusEnum_matching,
  _$createOrderRequestStatusEnum_accepted,
  _$createOrderRequestStatusEnum_arriving,
  _$createOrderRequestStatusEnum_inTrip,
  _$createOrderRequestStatusEnum_completed,
  _$createOrderRequestStatusEnum_cancelledByUser,
  _$createOrderRequestStatusEnum_cancelledByDriver,
  _$createOrderRequestStatusEnum_cancelledBySystem,
]);

Serializer<CreateOrderRequestTypeEnum> _$createOrderRequestTypeEnumSerializer =
    _$CreateOrderRequestTypeEnumSerializer();
Serializer<CreateOrderRequestStatusEnum>
    _$createOrderRequestStatusEnumSerializer =
    _$CreateOrderRequestStatusEnumSerializer();

class _$CreateOrderRequestTypeEnumSerializer
    implements PrimitiveSerializer<CreateOrderRequestTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'ride': 'ride',
    'delivery': 'delivery',
    'food': 'food',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'ride': 'ride',
    'delivery': 'delivery',
    'food': 'food',
  };

  @override
  final Iterable<Type> types = const <Type>[CreateOrderRequestTypeEnum];
  @override
  final String wireName = 'CreateOrderRequestTypeEnum';

  @override
  Object serialize(Serializers serializers, CreateOrderRequestTypeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  CreateOrderRequestTypeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      CreateOrderRequestTypeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$CreateOrderRequestStatusEnumSerializer
    implements PrimitiveSerializer<CreateOrderRequestStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'requested': 'requested',
    'matching': 'matching',
    'accepted': 'accepted',
    'arriving': 'arriving',
    'inTrip': 'in_trip',
    'completed': 'completed',
    'cancelledByUser': 'cancelled_by_user',
    'cancelledByDriver': 'cancelled_by_driver',
    'cancelledBySystem': 'cancelled_by_system',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'requested': 'requested',
    'matching': 'matching',
    'accepted': 'accepted',
    'arriving': 'arriving',
    'in_trip': 'inTrip',
    'completed': 'completed',
    'cancelled_by_user': 'cancelledByUser',
    'cancelled_by_driver': 'cancelledByDriver',
    'cancelled_by_system': 'cancelledBySystem',
  };

  @override
  final Iterable<Type> types = const <Type>[CreateOrderRequestStatusEnum];
  @override
  final String wireName = 'CreateOrderRequestStatusEnum';

  @override
  Object serialize(Serializers serializers, CreateOrderRequestStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  CreateOrderRequestStatusEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      CreateOrderRequestStatusEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$CreateOrderRequest extends CreateOrderRequest {
  @override
  final String userId;
  @override
  final String? driverId;
  @override
  final String? merchantId;
  @override
  final CreateOrderRequestTypeEnum type;
  @override
  final CreateOrderRequestStatusEnum status;
  @override
  final Location pickupLocation;
  @override
  final Location dropoffLocation;
  @override
  final num distanceKm;
  @override
  final num basePrice;
  @override
  final num totalPrice;
  @override
  final CreateOrderRequestNote? note;
  @override
  final num? tip;

  factory _$CreateOrderRequest(
          [void Function(CreateOrderRequestBuilder)? updates]) =>
      (CreateOrderRequestBuilder()..update(updates))._build();

  _$CreateOrderRequest._(
      {required this.userId,
      this.driverId,
      this.merchantId,
      required this.type,
      required this.status,
      required this.pickupLocation,
      required this.dropoffLocation,
      required this.distanceKm,
      required this.basePrice,
      required this.totalPrice,
      this.note,
      this.tip})
      : super._();
  @override
  CreateOrderRequest rebuild(
          void Function(CreateOrderRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateOrderRequestBuilder toBuilder() =>
      CreateOrderRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateOrderRequest &&
        userId == other.userId &&
        driverId == other.driverId &&
        merchantId == other.merchantId &&
        type == other.type &&
        status == other.status &&
        pickupLocation == other.pickupLocation &&
        dropoffLocation == other.dropoffLocation &&
        distanceKm == other.distanceKm &&
        basePrice == other.basePrice &&
        totalPrice == other.totalPrice &&
        note == other.note &&
        tip == other.tip;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, driverId.hashCode);
    _$hash = $jc(_$hash, merchantId.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, pickupLocation.hashCode);
    _$hash = $jc(_$hash, dropoffLocation.hashCode);
    _$hash = $jc(_$hash, distanceKm.hashCode);
    _$hash = $jc(_$hash, basePrice.hashCode);
    _$hash = $jc(_$hash, totalPrice.hashCode);
    _$hash = $jc(_$hash, note.hashCode);
    _$hash = $jc(_$hash, tip.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateOrderRequest')
          ..add('userId', userId)
          ..add('driverId', driverId)
          ..add('merchantId', merchantId)
          ..add('type', type)
          ..add('status', status)
          ..add('pickupLocation', pickupLocation)
          ..add('dropoffLocation', dropoffLocation)
          ..add('distanceKm', distanceKm)
          ..add('basePrice', basePrice)
          ..add('totalPrice', totalPrice)
          ..add('note', note)
          ..add('tip', tip))
        .toString();
  }
}

class CreateOrderRequestBuilder
    implements Builder<CreateOrderRequest, CreateOrderRequestBuilder> {
  _$CreateOrderRequest? _$v;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  String? _driverId;
  String? get driverId => _$this._driverId;
  set driverId(String? driverId) => _$this._driverId = driverId;

  String? _merchantId;
  String? get merchantId => _$this._merchantId;
  set merchantId(String? merchantId) => _$this._merchantId = merchantId;

  CreateOrderRequestTypeEnum? _type;
  CreateOrderRequestTypeEnum? get type => _$this._type;
  set type(CreateOrderRequestTypeEnum? type) => _$this._type = type;

  CreateOrderRequestStatusEnum? _status;
  CreateOrderRequestStatusEnum? get status => _$this._status;
  set status(CreateOrderRequestStatusEnum? status) => _$this._status = status;

  LocationBuilder? _pickupLocation;
  LocationBuilder get pickupLocation =>
      _$this._pickupLocation ??= LocationBuilder();
  set pickupLocation(LocationBuilder? pickupLocation) =>
      _$this._pickupLocation = pickupLocation;

  LocationBuilder? _dropoffLocation;
  LocationBuilder get dropoffLocation =>
      _$this._dropoffLocation ??= LocationBuilder();
  set dropoffLocation(LocationBuilder? dropoffLocation) =>
      _$this._dropoffLocation = dropoffLocation;

  num? _distanceKm;
  num? get distanceKm => _$this._distanceKm;
  set distanceKm(num? distanceKm) => _$this._distanceKm = distanceKm;

  num? _basePrice;
  num? get basePrice => _$this._basePrice;
  set basePrice(num? basePrice) => _$this._basePrice = basePrice;

  num? _totalPrice;
  num? get totalPrice => _$this._totalPrice;
  set totalPrice(num? totalPrice) => _$this._totalPrice = totalPrice;

  CreateOrderRequestNoteBuilder? _note;
  CreateOrderRequestNoteBuilder get note =>
      _$this._note ??= CreateOrderRequestNoteBuilder();
  set note(CreateOrderRequestNoteBuilder? note) => _$this._note = note;

  num? _tip;
  num? get tip => _$this._tip;
  set tip(num? tip) => _$this._tip = tip;

  CreateOrderRequestBuilder() {
    CreateOrderRequest._defaults(this);
  }

  CreateOrderRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userId = $v.userId;
      _driverId = $v.driverId;
      _merchantId = $v.merchantId;
      _type = $v.type;
      _status = $v.status;
      _pickupLocation = $v.pickupLocation.toBuilder();
      _dropoffLocation = $v.dropoffLocation.toBuilder();
      _distanceKm = $v.distanceKm;
      _basePrice = $v.basePrice;
      _totalPrice = $v.totalPrice;
      _note = $v.note?.toBuilder();
      _tip = $v.tip;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateOrderRequest other) {
    _$v = other as _$CreateOrderRequest;
  }

  @override
  void update(void Function(CreateOrderRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateOrderRequest build() => _build();

  _$CreateOrderRequest _build() {
    _$CreateOrderRequest _$result;
    try {
      _$result = _$v ??
          _$CreateOrderRequest._(
            userId: BuiltValueNullFieldError.checkNotNull(
                userId, r'CreateOrderRequest', 'userId'),
            driverId: driverId,
            merchantId: merchantId,
            type: BuiltValueNullFieldError.checkNotNull(
                type, r'CreateOrderRequest', 'type'),
            status: BuiltValueNullFieldError.checkNotNull(
                status, r'CreateOrderRequest', 'status'),
            pickupLocation: pickupLocation.build(),
            dropoffLocation: dropoffLocation.build(),
            distanceKm: BuiltValueNullFieldError.checkNotNull(
                distanceKm, r'CreateOrderRequest', 'distanceKm'),
            basePrice: BuiltValueNullFieldError.checkNotNull(
                basePrice, r'CreateOrderRequest', 'basePrice'),
            totalPrice: BuiltValueNullFieldError.checkNotNull(
                totalPrice, r'CreateOrderRequest', 'totalPrice'),
            note: _note?.build(),
            tip: tip,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'pickupLocation';
        pickupLocation.build();
        _$failedField = 'dropoffLocation';
        dropoffLocation.build();

        _$failedField = 'note';
        _note?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'CreateOrderRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
