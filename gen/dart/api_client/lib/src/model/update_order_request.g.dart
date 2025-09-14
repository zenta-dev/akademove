// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_order_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const UpdateOrderRequestTypeEnum _$updateOrderRequestTypeEnum_ride =
    const UpdateOrderRequestTypeEnum._('ride');
const UpdateOrderRequestTypeEnum _$updateOrderRequestTypeEnum_delivery =
    const UpdateOrderRequestTypeEnum._('delivery');
const UpdateOrderRequestTypeEnum _$updateOrderRequestTypeEnum_food =
    const UpdateOrderRequestTypeEnum._('food');

UpdateOrderRequestTypeEnum _$updateOrderRequestTypeEnumValueOf(String name) {
  switch (name) {
    case 'ride':
      return _$updateOrderRequestTypeEnum_ride;
    case 'delivery':
      return _$updateOrderRequestTypeEnum_delivery;
    case 'food':
      return _$updateOrderRequestTypeEnum_food;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<UpdateOrderRequestTypeEnum> _$updateOrderRequestTypeEnumValues =
    BuiltSet<UpdateOrderRequestTypeEnum>(const <UpdateOrderRequestTypeEnum>[
      _$updateOrderRequestTypeEnum_ride,
      _$updateOrderRequestTypeEnum_delivery,
      _$updateOrderRequestTypeEnum_food,
    ]);

const UpdateOrderRequestStatusEnum _$updateOrderRequestStatusEnum_requested =
    const UpdateOrderRequestStatusEnum._('requested');
const UpdateOrderRequestStatusEnum _$updateOrderRequestStatusEnum_matching =
    const UpdateOrderRequestStatusEnum._('matching');
const UpdateOrderRequestStatusEnum _$updateOrderRequestStatusEnum_accepted =
    const UpdateOrderRequestStatusEnum._('accepted');
const UpdateOrderRequestStatusEnum _$updateOrderRequestStatusEnum_arriving =
    const UpdateOrderRequestStatusEnum._('arriving');
const UpdateOrderRequestStatusEnum _$updateOrderRequestStatusEnum_inTrip =
    const UpdateOrderRequestStatusEnum._('inTrip');
const UpdateOrderRequestStatusEnum _$updateOrderRequestStatusEnum_completed =
    const UpdateOrderRequestStatusEnum._('completed');
const UpdateOrderRequestStatusEnum
_$updateOrderRequestStatusEnum_cancelledByUser =
    const UpdateOrderRequestStatusEnum._('cancelledByUser');
const UpdateOrderRequestStatusEnum
_$updateOrderRequestStatusEnum_cancelledByDriver =
    const UpdateOrderRequestStatusEnum._('cancelledByDriver');
const UpdateOrderRequestStatusEnum
_$updateOrderRequestStatusEnum_cancelledBySystem =
    const UpdateOrderRequestStatusEnum._('cancelledBySystem');

UpdateOrderRequestStatusEnum _$updateOrderRequestStatusEnumValueOf(
  String name,
) {
  switch (name) {
    case 'requested':
      return _$updateOrderRequestStatusEnum_requested;
    case 'matching':
      return _$updateOrderRequestStatusEnum_matching;
    case 'accepted':
      return _$updateOrderRequestStatusEnum_accepted;
    case 'arriving':
      return _$updateOrderRequestStatusEnum_arriving;
    case 'inTrip':
      return _$updateOrderRequestStatusEnum_inTrip;
    case 'completed':
      return _$updateOrderRequestStatusEnum_completed;
    case 'cancelledByUser':
      return _$updateOrderRequestStatusEnum_cancelledByUser;
    case 'cancelledByDriver':
      return _$updateOrderRequestStatusEnum_cancelledByDriver;
    case 'cancelledBySystem':
      return _$updateOrderRequestStatusEnum_cancelledBySystem;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<UpdateOrderRequestStatusEnum>
_$updateOrderRequestStatusEnumValues =
    BuiltSet<UpdateOrderRequestStatusEnum>(const <UpdateOrderRequestStatusEnum>[
      _$updateOrderRequestStatusEnum_requested,
      _$updateOrderRequestStatusEnum_matching,
      _$updateOrderRequestStatusEnum_accepted,
      _$updateOrderRequestStatusEnum_arriving,
      _$updateOrderRequestStatusEnum_inTrip,
      _$updateOrderRequestStatusEnum_completed,
      _$updateOrderRequestStatusEnum_cancelledByUser,
      _$updateOrderRequestStatusEnum_cancelledByDriver,
      _$updateOrderRequestStatusEnum_cancelledBySystem,
    ]);

Serializer<UpdateOrderRequestTypeEnum> _$updateOrderRequestTypeEnumSerializer =
    _$UpdateOrderRequestTypeEnumSerializer();
Serializer<UpdateOrderRequestStatusEnum>
_$updateOrderRequestStatusEnumSerializer =
    _$UpdateOrderRequestStatusEnumSerializer();

class _$UpdateOrderRequestTypeEnumSerializer
    implements PrimitiveSerializer<UpdateOrderRequestTypeEnum> {
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
  final Iterable<Type> types = const <Type>[UpdateOrderRequestTypeEnum];
  @override
  final String wireName = 'UpdateOrderRequestTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    UpdateOrderRequestTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  UpdateOrderRequestTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => UpdateOrderRequestTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$UpdateOrderRequestStatusEnumSerializer
    implements PrimitiveSerializer<UpdateOrderRequestStatusEnum> {
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
  final Iterable<Type> types = const <Type>[UpdateOrderRequestStatusEnum];
  @override
  final String wireName = 'UpdateOrderRequestStatusEnum';

  @override
  Object serialize(
    Serializers serializers,
    UpdateOrderRequestStatusEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  UpdateOrderRequestStatusEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => UpdateOrderRequestStatusEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$UpdateOrderRequest extends UpdateOrderRequest {
  @override
  final String? driverId;
  @override
  final String? merchantId;
  @override
  final UpdateOrderRequestTypeEnum type;
  @override
  final UpdateOrderRequestStatusEnum status;
  @override
  final num distanceKm;
  @override
  final num? tip;
  @override
  final num totalPrice;
  @override
  final CreateOrderRequestNote? note;

  factory _$UpdateOrderRequest([
    void Function(UpdateOrderRequestBuilder)? updates,
  ]) => (UpdateOrderRequestBuilder()..update(updates))._build();

  _$UpdateOrderRequest._({
    this.driverId,
    this.merchantId,
    required this.type,
    required this.status,
    required this.distanceKm,
    this.tip,
    required this.totalPrice,
    this.note,
  }) : super._();
  @override
  UpdateOrderRequest rebuild(
    void Function(UpdateOrderRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UpdateOrderRequestBuilder toBuilder() =>
      UpdateOrderRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateOrderRequest &&
        driverId == other.driverId &&
        merchantId == other.merchantId &&
        type == other.type &&
        status == other.status &&
        distanceKm == other.distanceKm &&
        tip == other.tip &&
        totalPrice == other.totalPrice &&
        note == other.note;
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
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateOrderRequest')
          ..add('driverId', driverId)
          ..add('merchantId', merchantId)
          ..add('type', type)
          ..add('status', status)
          ..add('distanceKm', distanceKm)
          ..add('tip', tip)
          ..add('totalPrice', totalPrice)
          ..add('note', note))
        .toString();
  }
}

class UpdateOrderRequestBuilder
    implements Builder<UpdateOrderRequest, UpdateOrderRequestBuilder> {
  _$UpdateOrderRequest? _$v;

  String? _driverId;
  String? get driverId => _$this._driverId;
  set driverId(String? driverId) => _$this._driverId = driverId;

  String? _merchantId;
  String? get merchantId => _$this._merchantId;
  set merchantId(String? merchantId) => _$this._merchantId = merchantId;

  UpdateOrderRequestTypeEnum? _type;
  UpdateOrderRequestTypeEnum? get type => _$this._type;
  set type(UpdateOrderRequestTypeEnum? type) => _$this._type = type;

  UpdateOrderRequestStatusEnum? _status;
  UpdateOrderRequestStatusEnum? get status => _$this._status;
  set status(UpdateOrderRequestStatusEnum? status) => _$this._status = status;

  num? _distanceKm;
  num? get distanceKm => _$this._distanceKm;
  set distanceKm(num? distanceKm) => _$this._distanceKm = distanceKm;

  num? _tip;
  num? get tip => _$this._tip;
  set tip(num? tip) => _$this._tip = tip;

  num? _totalPrice;
  num? get totalPrice => _$this._totalPrice;
  set totalPrice(num? totalPrice) => _$this._totalPrice = totalPrice;

  CreateOrderRequestNoteBuilder? _note;
  CreateOrderRequestNoteBuilder get note =>
      _$this._note ??= CreateOrderRequestNoteBuilder();
  set note(CreateOrderRequestNoteBuilder? note) => _$this._note = note;

  UpdateOrderRequestBuilder() {
    UpdateOrderRequest._defaults(this);
  }

  UpdateOrderRequestBuilder get _$this {
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
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateOrderRequest other) {
    _$v = other as _$UpdateOrderRequest;
  }

  @override
  void update(void Function(UpdateOrderRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateOrderRequest build() => _build();

  _$UpdateOrderRequest _build() {
    _$UpdateOrderRequest _$result;
    try {
      _$result =
          _$v ??
          _$UpdateOrderRequest._(
            driverId: driverId,
            merchantId: merchantId,
            type: BuiltValueNullFieldError.checkNotNull(
              type,
              r'UpdateOrderRequest',
              'type',
            ),
            status: BuiltValueNullFieldError.checkNotNull(
              status,
              r'UpdateOrderRequest',
              'status',
            ),
            distanceKm: BuiltValueNullFieldError.checkNotNull(
              distanceKm,
              r'UpdateOrderRequest',
              'distanceKm',
            ),
            tip: tip,
            totalPrice: BuiltValueNullFieldError.checkNotNull(
              totalPrice,
              r'UpdateOrderRequest',
              'totalPrice',
            ),
            note: _note?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'note';
        _note?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'UpdateOrderRequest',
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
