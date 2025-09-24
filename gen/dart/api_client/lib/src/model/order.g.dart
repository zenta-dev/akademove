// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const OrderTypeEnum _$orderTypeEnum_ride = const OrderTypeEnum._('ride');
const OrderTypeEnum _$orderTypeEnum_delivery = const OrderTypeEnum._(
  'delivery',
);
const OrderTypeEnum _$orderTypeEnum_food = const OrderTypeEnum._('food');

OrderTypeEnum _$orderTypeEnumValueOf(String name) {
  switch (name) {
    case 'ride':
      return _$orderTypeEnum_ride;
    case 'delivery':
      return _$orderTypeEnum_delivery;
    case 'food':
      return _$orderTypeEnum_food;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<OrderTypeEnum> _$orderTypeEnumValues = BuiltSet<OrderTypeEnum>(
  const <OrderTypeEnum>[
    _$orderTypeEnum_ride,
    _$orderTypeEnum_delivery,
    _$orderTypeEnum_food,
  ],
);

const OrderStatusEnum _$orderStatusEnum_requested = const OrderStatusEnum._(
  'requested',
);
const OrderStatusEnum _$orderStatusEnum_matching = const OrderStatusEnum._(
  'matching',
);
const OrderStatusEnum _$orderStatusEnum_accepted = const OrderStatusEnum._(
  'accepted',
);
const OrderStatusEnum _$orderStatusEnum_arriving = const OrderStatusEnum._(
  'arriving',
);
const OrderStatusEnum _$orderStatusEnum_inTrip = const OrderStatusEnum._(
  'inTrip',
);
const OrderStatusEnum _$orderStatusEnum_completed = const OrderStatusEnum._(
  'completed',
);
const OrderStatusEnum _$orderStatusEnum_cancelledByUser =
    const OrderStatusEnum._('cancelledByUser');
const OrderStatusEnum _$orderStatusEnum_cancelledByDriver =
    const OrderStatusEnum._('cancelledByDriver');
const OrderStatusEnum _$orderStatusEnum_cancelledBySystem =
    const OrderStatusEnum._('cancelledBySystem');

OrderStatusEnum _$orderStatusEnumValueOf(String name) {
  switch (name) {
    case 'requested':
      return _$orderStatusEnum_requested;
    case 'matching':
      return _$orderStatusEnum_matching;
    case 'accepted':
      return _$orderStatusEnum_accepted;
    case 'arriving':
      return _$orderStatusEnum_arriving;
    case 'inTrip':
      return _$orderStatusEnum_inTrip;
    case 'completed':
      return _$orderStatusEnum_completed;
    case 'cancelledByUser':
      return _$orderStatusEnum_cancelledByUser;
    case 'cancelledByDriver':
      return _$orderStatusEnum_cancelledByDriver;
    case 'cancelledBySystem':
      return _$orderStatusEnum_cancelledBySystem;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<OrderStatusEnum> _$orderStatusEnumValues =
    BuiltSet<OrderStatusEnum>(const <OrderStatusEnum>[
      _$orderStatusEnum_requested,
      _$orderStatusEnum_matching,
      _$orderStatusEnum_accepted,
      _$orderStatusEnum_arriving,
      _$orderStatusEnum_inTrip,
      _$orderStatusEnum_completed,
      _$orderStatusEnum_cancelledByUser,
      _$orderStatusEnum_cancelledByDriver,
      _$orderStatusEnum_cancelledBySystem,
    ]);

Serializer<OrderTypeEnum> _$orderTypeEnumSerializer =
    _$OrderTypeEnumSerializer();
Serializer<OrderStatusEnum> _$orderStatusEnumSerializer =
    _$OrderStatusEnumSerializer();

class _$OrderTypeEnumSerializer implements PrimitiveSerializer<OrderTypeEnum> {
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
  final Iterable<Type> types = const <Type>[OrderTypeEnum];
  @override
  final String wireName = 'OrderTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    OrderTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  OrderTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => OrderTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$OrderStatusEnumSerializer
    implements PrimitiveSerializer<OrderStatusEnum> {
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
  final Iterable<Type> types = const <Type>[OrderStatusEnum];
  @override
  final String wireName = 'OrderStatusEnum';

  @override
  Object serialize(
    Serializers serializers,
    OrderStatusEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  OrderStatusEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => OrderStatusEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$Order extends Order {
  @override
  final String id;
  @override
  final String userId;
  @override
  final String? driverId;
  @override
  final String? merchantId;
  @override
  final OrderTypeEnum type;
  @override
  final OrderStatusEnum status;
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
  final num requestedAt;
  @override
  final num? acceptedAt;
  @override
  final num? arrivedAt;
  @override
  final num createdAt;
  @override
  final num updatedAt;
  @override
  final DriverUpdateRequestUser? user;
  @override
  final OrderCreateRequestDriver? driver;
  @override
  final OrderCreateRequestMerchant? merchant;

  factory _$Order([void Function(OrderBuilder)? updates]) =>
      (OrderBuilder()..update(updates))._build();

  _$Order._({
    required this.id,
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
    required this.requestedAt,
    this.acceptedAt,
    this.arrivedAt,
    required this.createdAt,
    required this.updatedAt,
    this.user,
    this.driver,
    this.merchant,
  }) : super._();
  @override
  Order rebuild(void Function(OrderBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OrderBuilder toBuilder() => OrderBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Order &&
        id == other.id &&
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
        requestedAt == other.requestedAt &&
        acceptedAt == other.acceptedAt &&
        arrivedAt == other.arrivedAt &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        user == other.user &&
        driver == other.driver &&
        merchant == other.merchant;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
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
    _$hash = $jc(_$hash, requestedAt.hashCode);
    _$hash = $jc(_$hash, acceptedAt.hashCode);
    _$hash = $jc(_$hash, arrivedAt.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, user.hashCode);
    _$hash = $jc(_$hash, driver.hashCode);
    _$hash = $jc(_$hash, merchant.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Order')
          ..add('id', id)
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
          ..add('requestedAt', requestedAt)
          ..add('acceptedAt', acceptedAt)
          ..add('arrivedAt', arrivedAt)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('user', user)
          ..add('driver', driver)
          ..add('merchant', merchant))
        .toString();
  }
}

class OrderBuilder implements Builder<Order, OrderBuilder> {
  _$Order? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  String? _driverId;
  String? get driverId => _$this._driverId;
  set driverId(String? driverId) => _$this._driverId = driverId;

  String? _merchantId;
  String? get merchantId => _$this._merchantId;
  set merchantId(String? merchantId) => _$this._merchantId = merchantId;

  OrderTypeEnum? _type;
  OrderTypeEnum? get type => _$this._type;
  set type(OrderTypeEnum? type) => _$this._type = type;

  OrderStatusEnum? _status;
  OrderStatusEnum? get status => _$this._status;
  set status(OrderStatusEnum? status) => _$this._status = status;

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

  num? _requestedAt;
  num? get requestedAt => _$this._requestedAt;
  set requestedAt(num? requestedAt) => _$this._requestedAt = requestedAt;

  num? _acceptedAt;
  num? get acceptedAt => _$this._acceptedAt;
  set acceptedAt(num? acceptedAt) => _$this._acceptedAt = acceptedAt;

  num? _arrivedAt;
  num? get arrivedAt => _$this._arrivedAt;
  set arrivedAt(num? arrivedAt) => _$this._arrivedAt = arrivedAt;

  num? _createdAt;
  num? get createdAt => _$this._createdAt;
  set createdAt(num? createdAt) => _$this._createdAt = createdAt;

  num? _updatedAt;
  num? get updatedAt => _$this._updatedAt;
  set updatedAt(num? updatedAt) => _$this._updatedAt = updatedAt;

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

  OrderBuilder() {
    Order._defaults(this);
  }

  OrderBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
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
      _requestedAt = $v.requestedAt;
      _acceptedAt = $v.acceptedAt;
      _arrivedAt = $v.arrivedAt;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _user = $v.user?.toBuilder();
      _driver = $v.driver?.toBuilder();
      _merchant = $v.merchant?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Order other) {
    _$v = other as _$Order;
  }

  @override
  void update(void Function(OrderBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Order build() => _build();

  _$Order _build() {
    _$Order _$result;
    try {
      _$result =
          _$v ??
          _$Order._(
            id: BuiltValueNullFieldError.checkNotNull(id, r'Order', 'id'),
            userId: BuiltValueNullFieldError.checkNotNull(
              userId,
              r'Order',
              'userId',
            ),
            driverId: driverId,
            merchantId: merchantId,
            type: BuiltValueNullFieldError.checkNotNull(type, r'Order', 'type'),
            status: BuiltValueNullFieldError.checkNotNull(
              status,
              r'Order',
              'status',
            ),
            pickupLocation: pickupLocation.build(),
            dropoffLocation: dropoffLocation.build(),
            distanceKm: BuiltValueNullFieldError.checkNotNull(
              distanceKm,
              r'Order',
              'distanceKm',
            ),
            basePrice: BuiltValueNullFieldError.checkNotNull(
              basePrice,
              r'Order',
              'basePrice',
            ),
            tip: tip,
            totalPrice: BuiltValueNullFieldError.checkNotNull(
              totalPrice,
              r'Order',
              'totalPrice',
            ),
            note: _note?.build(),
            requestedAt: BuiltValueNullFieldError.checkNotNull(
              requestedAt,
              r'Order',
              'requestedAt',
            ),
            acceptedAt: acceptedAt,
            arrivedAt: arrivedAt,
            createdAt: BuiltValueNullFieldError.checkNotNull(
              createdAt,
              r'Order',
              'createdAt',
            ),
            updatedAt: BuiltValueNullFieldError.checkNotNull(
              updatedAt,
              r'Order',
              'updatedAt',
            ),
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
        throw BuiltValueNestedFieldError(r'Order', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
