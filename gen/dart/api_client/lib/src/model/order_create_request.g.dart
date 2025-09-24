// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_create_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const OrderCreateRequestTypeEnum _$orderCreateRequestTypeEnum_ride =
    const OrderCreateRequestTypeEnum._('ride');
const OrderCreateRequestTypeEnum _$orderCreateRequestTypeEnum_delivery =
    const OrderCreateRequestTypeEnum._('delivery');
const OrderCreateRequestTypeEnum _$orderCreateRequestTypeEnum_food =
    const OrderCreateRequestTypeEnum._('food');

OrderCreateRequestTypeEnum _$orderCreateRequestTypeEnumValueOf(String name) {
  switch (name) {
    case 'ride':
      return _$orderCreateRequestTypeEnum_ride;
    case 'delivery':
      return _$orderCreateRequestTypeEnum_delivery;
    case 'food':
      return _$orderCreateRequestTypeEnum_food;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<OrderCreateRequestTypeEnum> _$orderCreateRequestTypeEnumValues =
    BuiltSet<OrderCreateRequestTypeEnum>(const <OrderCreateRequestTypeEnum>[
      _$orderCreateRequestTypeEnum_ride,
      _$orderCreateRequestTypeEnum_delivery,
      _$orderCreateRequestTypeEnum_food,
    ]);

const OrderCreateRequestStatusEnum _$orderCreateRequestStatusEnum_requested =
    const OrderCreateRequestStatusEnum._('requested');
const OrderCreateRequestStatusEnum _$orderCreateRequestStatusEnum_matching =
    const OrderCreateRequestStatusEnum._('matching');
const OrderCreateRequestStatusEnum _$orderCreateRequestStatusEnum_accepted =
    const OrderCreateRequestStatusEnum._('accepted');
const OrderCreateRequestStatusEnum _$orderCreateRequestStatusEnum_arriving =
    const OrderCreateRequestStatusEnum._('arriving');
const OrderCreateRequestStatusEnum _$orderCreateRequestStatusEnum_inTrip =
    const OrderCreateRequestStatusEnum._('inTrip');
const OrderCreateRequestStatusEnum _$orderCreateRequestStatusEnum_completed =
    const OrderCreateRequestStatusEnum._('completed');
const OrderCreateRequestStatusEnum
_$orderCreateRequestStatusEnum_cancelledByUser =
    const OrderCreateRequestStatusEnum._('cancelledByUser');
const OrderCreateRequestStatusEnum
_$orderCreateRequestStatusEnum_cancelledByDriver =
    const OrderCreateRequestStatusEnum._('cancelledByDriver');
const OrderCreateRequestStatusEnum
_$orderCreateRequestStatusEnum_cancelledBySystem =
    const OrderCreateRequestStatusEnum._('cancelledBySystem');

OrderCreateRequestStatusEnum _$orderCreateRequestStatusEnumValueOf(
  String name,
) {
  switch (name) {
    case 'requested':
      return _$orderCreateRequestStatusEnum_requested;
    case 'matching':
      return _$orderCreateRequestStatusEnum_matching;
    case 'accepted':
      return _$orderCreateRequestStatusEnum_accepted;
    case 'arriving':
      return _$orderCreateRequestStatusEnum_arriving;
    case 'inTrip':
      return _$orderCreateRequestStatusEnum_inTrip;
    case 'completed':
      return _$orderCreateRequestStatusEnum_completed;
    case 'cancelledByUser':
      return _$orderCreateRequestStatusEnum_cancelledByUser;
    case 'cancelledByDriver':
      return _$orderCreateRequestStatusEnum_cancelledByDriver;
    case 'cancelledBySystem':
      return _$orderCreateRequestStatusEnum_cancelledBySystem;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<OrderCreateRequestStatusEnum>
_$orderCreateRequestStatusEnumValues =
    BuiltSet<OrderCreateRequestStatusEnum>(const <OrderCreateRequestStatusEnum>[
      _$orderCreateRequestStatusEnum_requested,
      _$orderCreateRequestStatusEnum_matching,
      _$orderCreateRequestStatusEnum_accepted,
      _$orderCreateRequestStatusEnum_arriving,
      _$orderCreateRequestStatusEnum_inTrip,
      _$orderCreateRequestStatusEnum_completed,
      _$orderCreateRequestStatusEnum_cancelledByUser,
      _$orderCreateRequestStatusEnum_cancelledByDriver,
      _$orderCreateRequestStatusEnum_cancelledBySystem,
    ]);

Serializer<OrderCreateRequestTypeEnum> _$orderCreateRequestTypeEnumSerializer =
    _$OrderCreateRequestTypeEnumSerializer();
Serializer<OrderCreateRequestStatusEnum>
_$orderCreateRequestStatusEnumSerializer =
    _$OrderCreateRequestStatusEnumSerializer();

class _$OrderCreateRequestTypeEnumSerializer
    implements PrimitiveSerializer<OrderCreateRequestTypeEnum> {
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
  final Iterable<Type> types = const <Type>[OrderCreateRequestTypeEnum];
  @override
  final String wireName = 'OrderCreateRequestTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    OrderCreateRequestTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  OrderCreateRequestTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => OrderCreateRequestTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$OrderCreateRequestStatusEnumSerializer
    implements PrimitiveSerializer<OrderCreateRequestStatusEnum> {
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
  final Iterable<Type> types = const <Type>[OrderCreateRequestStatusEnum];
  @override
  final String wireName = 'OrderCreateRequestStatusEnum';

  @override
  Object serialize(
    Serializers serializers,
    OrderCreateRequestStatusEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  OrderCreateRequestStatusEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => OrderCreateRequestStatusEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$OrderCreateRequest extends OrderCreateRequest {
  @override
  final String userId;
  @override
  final String? driverId;
  @override
  final String? merchantId;
  @override
  final OrderCreateRequestTypeEnum type;
  @override
  final OrderCreateRequestStatusEnum status;
  @override
  final Location pickupLocation;
  @override
  final Location dropoffLocation;
  @override
  final num distanceKm;
  @override
  final num basePrice;
  @override
  final num? tip;
  @override
  final num totalPrice;
  @override
  final OrderCreateRequestNote? note;
  @override
  final DriverUpdateRequestUser? user;
  @override
  final OrderCreateRequestDriver? driver;
  @override
  final OrderCreateRequestMerchant? merchant;

  factory _$OrderCreateRequest([
    void Function(OrderCreateRequestBuilder)? updates,
  ]) => (OrderCreateRequestBuilder()..update(updates))._build();

  _$OrderCreateRequest._({
    required this.userId,
    this.driverId,
    this.merchantId,
    required this.type,
    required this.status,
    required this.pickupLocation,
    required this.dropoffLocation,
    required this.distanceKm,
    required this.basePrice,
    this.tip,
    required this.totalPrice,
    this.note,
    this.user,
    this.driver,
    this.merchant,
  }) : super._();
  @override
  OrderCreateRequest rebuild(
    void Function(OrderCreateRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  OrderCreateRequestBuilder toBuilder() =>
      OrderCreateRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OrderCreateRequest &&
        userId == other.userId &&
        driverId == other.driverId &&
        merchantId == other.merchantId &&
        type == other.type &&
        status == other.status &&
        pickupLocation == other.pickupLocation &&
        dropoffLocation == other.dropoffLocation &&
        distanceKm == other.distanceKm &&
        basePrice == other.basePrice &&
        tip == other.tip &&
        totalPrice == other.totalPrice &&
        note == other.note &&
        user == other.user &&
        driver == other.driver &&
        merchant == other.merchant;
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
    _$hash = $jc(_$hash, tip.hashCode);
    _$hash = $jc(_$hash, totalPrice.hashCode);
    _$hash = $jc(_$hash, note.hashCode);
    _$hash = $jc(_$hash, user.hashCode);
    _$hash = $jc(_$hash, driver.hashCode);
    _$hash = $jc(_$hash, merchant.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'OrderCreateRequest')
          ..add('userId', userId)
          ..add('driverId', driverId)
          ..add('merchantId', merchantId)
          ..add('type', type)
          ..add('status', status)
          ..add('pickupLocation', pickupLocation)
          ..add('dropoffLocation', dropoffLocation)
          ..add('distanceKm', distanceKm)
          ..add('basePrice', basePrice)
          ..add('tip', tip)
          ..add('totalPrice', totalPrice)
          ..add('note', note)
          ..add('user', user)
          ..add('driver', driver)
          ..add('merchant', merchant))
        .toString();
  }
}

class OrderCreateRequestBuilder
    implements Builder<OrderCreateRequest, OrderCreateRequestBuilder> {
  _$OrderCreateRequest? _$v;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  String? _driverId;
  String? get driverId => _$this._driverId;
  set driverId(String? driverId) => _$this._driverId = driverId;

  String? _merchantId;
  String? get merchantId => _$this._merchantId;
  set merchantId(String? merchantId) => _$this._merchantId = merchantId;

  OrderCreateRequestTypeEnum? _type;
  OrderCreateRequestTypeEnum? get type => _$this._type;
  set type(OrderCreateRequestTypeEnum? type) => _$this._type = type;

  OrderCreateRequestStatusEnum? _status;
  OrderCreateRequestStatusEnum? get status => _$this._status;
  set status(OrderCreateRequestStatusEnum? status) => _$this._status = status;

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

  num? _tip;
  num? get tip => _$this._tip;
  set tip(num? tip) => _$this._tip = tip;

  num? _totalPrice;
  num? get totalPrice => _$this._totalPrice;
  set totalPrice(num? totalPrice) => _$this._totalPrice = totalPrice;

  OrderCreateRequestNoteBuilder? _note;
  OrderCreateRequestNoteBuilder get note =>
      _$this._note ??= OrderCreateRequestNoteBuilder();
  set note(OrderCreateRequestNoteBuilder? note) => _$this._note = note;

  DriverUpdateRequestUserBuilder? _user;
  DriverUpdateRequestUserBuilder get user =>
      _$this._user ??= DriverUpdateRequestUserBuilder();
  set user(DriverUpdateRequestUserBuilder? user) => _$this._user = user;

  OrderCreateRequestDriverBuilder? _driver;
  OrderCreateRequestDriverBuilder get driver =>
      _$this._driver ??= OrderCreateRequestDriverBuilder();
  set driver(OrderCreateRequestDriverBuilder? driver) =>
      _$this._driver = driver;

  OrderCreateRequestMerchantBuilder? _merchant;
  OrderCreateRequestMerchantBuilder get merchant =>
      _$this._merchant ??= OrderCreateRequestMerchantBuilder();
  set merchant(OrderCreateRequestMerchantBuilder? merchant) =>
      _$this._merchant = merchant;

  OrderCreateRequestBuilder() {
    OrderCreateRequest._defaults(this);
  }

  OrderCreateRequestBuilder get _$this {
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
      _tip = $v.tip;
      _totalPrice = $v.totalPrice;
      _note = $v.note?.toBuilder();
      _user = $v.user?.toBuilder();
      _driver = $v.driver?.toBuilder();
      _merchant = $v.merchant?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OrderCreateRequest other) {
    _$v = other as _$OrderCreateRequest;
  }

  @override
  void update(void Function(OrderCreateRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  OrderCreateRequest build() => _build();

  _$OrderCreateRequest _build() {
    _$OrderCreateRequest _$result;
    try {
      _$result =
          _$v ??
          _$OrderCreateRequest._(
            userId: BuiltValueNullFieldError.checkNotNull(
              userId,
              r'OrderCreateRequest',
              'userId',
            ),
            driverId: driverId,
            merchantId: merchantId,
            type: BuiltValueNullFieldError.checkNotNull(
              type,
              r'OrderCreateRequest',
              'type',
            ),
            status: BuiltValueNullFieldError.checkNotNull(
              status,
              r'OrderCreateRequest',
              'status',
            ),
            pickupLocation: pickupLocation.build(),
            dropoffLocation: dropoffLocation.build(),
            distanceKm: BuiltValueNullFieldError.checkNotNull(
              distanceKm,
              r'OrderCreateRequest',
              'distanceKm',
            ),
            basePrice: BuiltValueNullFieldError.checkNotNull(
              basePrice,
              r'OrderCreateRequest',
              'basePrice',
            ),
            tip: tip,
            totalPrice: BuiltValueNullFieldError.checkNotNull(
              totalPrice,
              r'OrderCreateRequest',
              'totalPrice',
            ),
            note: _note?.build(),
            user: _user?.build(),
            driver: _driver?.build(),
            merchant: _merchant?.build(),
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
        _$failedField = 'user';
        _user?.build();
        _$failedField = 'driver';
        _driver?.build();
        _$failedField = 'merchant';
        _merchant?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'OrderCreateRequest',
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
