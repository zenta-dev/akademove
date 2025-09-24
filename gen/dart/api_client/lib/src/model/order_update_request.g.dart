// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_update_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const OrderUpdateRequestTypeEnum _$orderUpdateRequestTypeEnum_ride =
    const OrderUpdateRequestTypeEnum._('ride');
const OrderUpdateRequestTypeEnum _$orderUpdateRequestTypeEnum_delivery =
    const OrderUpdateRequestTypeEnum._('delivery');
const OrderUpdateRequestTypeEnum _$orderUpdateRequestTypeEnum_food =
    const OrderUpdateRequestTypeEnum._('food');

OrderUpdateRequestTypeEnum _$orderUpdateRequestTypeEnumValueOf(String name) {
  switch (name) {
    case 'ride':
      return _$orderUpdateRequestTypeEnum_ride;
    case 'delivery':
      return _$orderUpdateRequestTypeEnum_delivery;
    case 'food':
      return _$orderUpdateRequestTypeEnum_food;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<OrderUpdateRequestTypeEnum> _$orderUpdateRequestTypeEnumValues =
    BuiltSet<OrderUpdateRequestTypeEnum>(const <OrderUpdateRequestTypeEnum>[
      _$orderUpdateRequestTypeEnum_ride,
      _$orderUpdateRequestTypeEnum_delivery,
      _$orderUpdateRequestTypeEnum_food,
    ]);

const OrderUpdateRequestStatusEnum _$orderUpdateRequestStatusEnum_requested =
    const OrderUpdateRequestStatusEnum._('requested');
const OrderUpdateRequestStatusEnum _$orderUpdateRequestStatusEnum_matching =
    const OrderUpdateRequestStatusEnum._('matching');
const OrderUpdateRequestStatusEnum _$orderUpdateRequestStatusEnum_accepted =
    const OrderUpdateRequestStatusEnum._('accepted');
const OrderUpdateRequestStatusEnum _$orderUpdateRequestStatusEnum_arriving =
    const OrderUpdateRequestStatusEnum._('arriving');
const OrderUpdateRequestStatusEnum _$orderUpdateRequestStatusEnum_inTrip =
    const OrderUpdateRequestStatusEnum._('inTrip');
const OrderUpdateRequestStatusEnum _$orderUpdateRequestStatusEnum_completed =
    const OrderUpdateRequestStatusEnum._('completed');
const OrderUpdateRequestStatusEnum
_$orderUpdateRequestStatusEnum_cancelledByUser =
    const OrderUpdateRequestStatusEnum._('cancelledByUser');
const OrderUpdateRequestStatusEnum
_$orderUpdateRequestStatusEnum_cancelledByDriver =
    const OrderUpdateRequestStatusEnum._('cancelledByDriver');
const OrderUpdateRequestStatusEnum
_$orderUpdateRequestStatusEnum_cancelledBySystem =
    const OrderUpdateRequestStatusEnum._('cancelledBySystem');

OrderUpdateRequestStatusEnum _$orderUpdateRequestStatusEnumValueOf(
  String name,
) {
  switch (name) {
    case 'requested':
      return _$orderUpdateRequestStatusEnum_requested;
    case 'matching':
      return _$orderUpdateRequestStatusEnum_matching;
    case 'accepted':
      return _$orderUpdateRequestStatusEnum_accepted;
    case 'arriving':
      return _$orderUpdateRequestStatusEnum_arriving;
    case 'inTrip':
      return _$orderUpdateRequestStatusEnum_inTrip;
    case 'completed':
      return _$orderUpdateRequestStatusEnum_completed;
    case 'cancelledByUser':
      return _$orderUpdateRequestStatusEnum_cancelledByUser;
    case 'cancelledByDriver':
      return _$orderUpdateRequestStatusEnum_cancelledByDriver;
    case 'cancelledBySystem':
      return _$orderUpdateRequestStatusEnum_cancelledBySystem;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<OrderUpdateRequestStatusEnum>
_$orderUpdateRequestStatusEnumValues =
    BuiltSet<OrderUpdateRequestStatusEnum>(const <OrderUpdateRequestStatusEnum>[
      _$orderUpdateRequestStatusEnum_requested,
      _$orderUpdateRequestStatusEnum_matching,
      _$orderUpdateRequestStatusEnum_accepted,
      _$orderUpdateRequestStatusEnum_arriving,
      _$orderUpdateRequestStatusEnum_inTrip,
      _$orderUpdateRequestStatusEnum_completed,
      _$orderUpdateRequestStatusEnum_cancelledByUser,
      _$orderUpdateRequestStatusEnum_cancelledByDriver,
      _$orderUpdateRequestStatusEnum_cancelledBySystem,
    ]);

Serializer<OrderUpdateRequestTypeEnum> _$orderUpdateRequestTypeEnumSerializer =
    _$OrderUpdateRequestTypeEnumSerializer();
Serializer<OrderUpdateRequestStatusEnum>
_$orderUpdateRequestStatusEnumSerializer =
    _$OrderUpdateRequestStatusEnumSerializer();

class _$OrderUpdateRequestTypeEnumSerializer
    implements PrimitiveSerializer<OrderUpdateRequestTypeEnum> {
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
  final Iterable<Type> types = const <Type>[OrderUpdateRequestTypeEnum];
  @override
  final String wireName = 'OrderUpdateRequestTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    OrderUpdateRequestTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  OrderUpdateRequestTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => OrderUpdateRequestTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$OrderUpdateRequestStatusEnumSerializer
    implements PrimitiveSerializer<OrderUpdateRequestStatusEnum> {
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
  final Iterable<Type> types = const <Type>[OrderUpdateRequestStatusEnum];
  @override
  final String wireName = 'OrderUpdateRequestStatusEnum';

  @override
  Object serialize(
    Serializers serializers,
    OrderUpdateRequestStatusEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  OrderUpdateRequestStatusEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => OrderUpdateRequestStatusEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$OrderUpdateRequest extends OrderUpdateRequest {
  @override
  final String? driverId;
  @override
  final String? merchantId;
  @override
  final OrderUpdateRequestTypeEnum? type;
  @override
  final OrderUpdateRequestStatusEnum? status;
  @override
  final num? distanceKm;
  @override
  final num? tip;
  @override
  final num? totalPrice;
  @override
  final OrderCreateRequestNote? note;
  @override
  final DriverUpdateRequestUser? user;
  @override
  final OrderCreateRequestDriver? driver;
  @override
  final OrderCreateRequestMerchant? merchant;

  factory _$OrderUpdateRequest([
    void Function(OrderUpdateRequestBuilder)? updates,
  ]) => (OrderUpdateRequestBuilder()..update(updates))._build();

  _$OrderUpdateRequest._({
    this.driverId,
    this.merchantId,
    this.type,
    this.status,
    this.distanceKm,
    this.tip,
    this.totalPrice,
    this.note,
    this.user,
    this.driver,
    this.merchant,
  }) : super._();
  @override
  OrderUpdateRequest rebuild(
    void Function(OrderUpdateRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  OrderUpdateRequestBuilder toBuilder() =>
      OrderUpdateRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OrderUpdateRequest &&
        driverId == other.driverId &&
        merchantId == other.merchantId &&
        type == other.type &&
        status == other.status &&
        distanceKm == other.distanceKm &&
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
    _$hash = $jc(_$hash, driverId.hashCode);
    _$hash = $jc(_$hash, merchantId.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, distanceKm.hashCode);
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
    return (newBuiltValueToStringHelper(r'OrderUpdateRequest')
          ..add('driverId', driverId)
          ..add('merchantId', merchantId)
          ..add('type', type)
          ..add('status', status)
          ..add('distanceKm', distanceKm)
          ..add('tip', tip)
          ..add('totalPrice', totalPrice)
          ..add('note', note)
          ..add('user', user)
          ..add('driver', driver)
          ..add('merchant', merchant))
        .toString();
  }
}

class OrderUpdateRequestBuilder
    implements Builder<OrderUpdateRequest, OrderUpdateRequestBuilder> {
  _$OrderUpdateRequest? _$v;

  String? _driverId;
  String? get driverId => _$this._driverId;
  set driverId(String? driverId) => _$this._driverId = driverId;

  String? _merchantId;
  String? get merchantId => _$this._merchantId;
  set merchantId(String? merchantId) => _$this._merchantId = merchantId;

  OrderUpdateRequestTypeEnum? _type;
  OrderUpdateRequestTypeEnum? get type => _$this._type;
  set type(OrderUpdateRequestTypeEnum? type) => _$this._type = type;

  OrderUpdateRequestStatusEnum? _status;
  OrderUpdateRequestStatusEnum? get status => _$this._status;
  set status(OrderUpdateRequestStatusEnum? status) => _$this._status = status;

  num? _distanceKm;
  num? get distanceKm => _$this._distanceKm;
  set distanceKm(num? distanceKm) => _$this._distanceKm = distanceKm;

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

  OrderUpdateRequestBuilder() {
    OrderUpdateRequest._defaults(this);
  }

  OrderUpdateRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _driverId = $v.driverId;
      _merchantId = $v.merchantId;
      _type = $v.type;
      _status = $v.status;
      _distanceKm = $v.distanceKm;
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
  void replace(OrderUpdateRequest other) {
    _$v = other as _$OrderUpdateRequest;
  }

  @override
  void update(void Function(OrderUpdateRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  OrderUpdateRequest build() => _build();

  _$OrderUpdateRequest _build() {
    _$OrderUpdateRequest _$result;
    try {
      _$result =
          _$v ??
          _$OrderUpdateRequest._(
            driverId: driverId,
            merchantId: merchantId,
            type: type,
            status: status,
            distanceKm: distanceKm,
            tip: tip,
            totalPrice: totalPrice,
            note: _note?.build(),
            user: _user?.build(),
            driver: _driver?.build(),
            merchant: _merchant?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
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
          r'OrderUpdateRequest',
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
