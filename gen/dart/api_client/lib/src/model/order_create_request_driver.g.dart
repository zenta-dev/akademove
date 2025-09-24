// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_create_request_driver.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const OrderCreateRequestDriverStatusEnum
_$orderCreateRequestDriverStatusEnum_pending =
    const OrderCreateRequestDriverStatusEnum._('pending');
const OrderCreateRequestDriverStatusEnum
_$orderCreateRequestDriverStatusEnum_approved =
    const OrderCreateRequestDriverStatusEnum._('approved');
const OrderCreateRequestDriverStatusEnum
_$orderCreateRequestDriverStatusEnum_rejected =
    const OrderCreateRequestDriverStatusEnum._('rejected');
const OrderCreateRequestDriverStatusEnum
_$orderCreateRequestDriverStatusEnum_active =
    const OrderCreateRequestDriverStatusEnum._('active');
const OrderCreateRequestDriverStatusEnum
_$orderCreateRequestDriverStatusEnum_inactive =
    const OrderCreateRequestDriverStatusEnum._('inactive');
const OrderCreateRequestDriverStatusEnum
_$orderCreateRequestDriverStatusEnum_suspended =
    const OrderCreateRequestDriverStatusEnum._('suspended');

OrderCreateRequestDriverStatusEnum _$orderCreateRequestDriverStatusEnumValueOf(
  String name,
) {
  switch (name) {
    case 'pending':
      return _$orderCreateRequestDriverStatusEnum_pending;
    case 'approved':
      return _$orderCreateRequestDriverStatusEnum_approved;
    case 'rejected':
      return _$orderCreateRequestDriverStatusEnum_rejected;
    case 'active':
      return _$orderCreateRequestDriverStatusEnum_active;
    case 'inactive':
      return _$orderCreateRequestDriverStatusEnum_inactive;
    case 'suspended':
      return _$orderCreateRequestDriverStatusEnum_suspended;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<OrderCreateRequestDriverStatusEnum>
_$orderCreateRequestDriverStatusEnumValues =
    BuiltSet<OrderCreateRequestDriverStatusEnum>(
      const <OrderCreateRequestDriverStatusEnum>[
        _$orderCreateRequestDriverStatusEnum_pending,
        _$orderCreateRequestDriverStatusEnum_approved,
        _$orderCreateRequestDriverStatusEnum_rejected,
        _$orderCreateRequestDriverStatusEnum_active,
        _$orderCreateRequestDriverStatusEnum_inactive,
        _$orderCreateRequestDriverStatusEnum_suspended,
      ],
    );

Serializer<OrderCreateRequestDriverStatusEnum>
_$orderCreateRequestDriverStatusEnumSerializer =
    _$OrderCreateRequestDriverStatusEnumSerializer();

class _$OrderCreateRequestDriverStatusEnumSerializer
    implements PrimitiveSerializer<OrderCreateRequestDriverStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'pending': 'pending',
    'approved': 'approved',
    'rejected': 'rejected',
    'active': 'active',
    'inactive': 'inactive',
    'suspended': 'suspended',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'pending': 'pending',
    'approved': 'approved',
    'rejected': 'rejected',
    'active': 'active',
    'inactive': 'inactive',
    'suspended': 'suspended',
  };

  @override
  final Iterable<Type> types = const <Type>[OrderCreateRequestDriverStatusEnum];
  @override
  final String wireName = 'OrderCreateRequestDriverStatusEnum';

  @override
  Object serialize(
    Serializers serializers,
    OrderCreateRequestDriverStatusEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  OrderCreateRequestDriverStatusEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => OrderCreateRequestDriverStatusEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$OrderCreateRequestDriver extends OrderCreateRequestDriver {
  @override
  final String? id;
  @override
  final String? userId;
  @override
  final String? studentId;
  @override
  final String? licenseNumber;
  @override
  final OrderCreateRequestDriverStatusEnum? status;
  @override
  final num? rating;
  @override
  final bool? isOnline;
  @override
  final Location? currentLocation;
  @override
  final num? lastLocationUpdate;
  @override
  final num? createdAt;
  @override
  final DriverUpdateRequestUser? user;

  factory _$OrderCreateRequestDriver([
    void Function(OrderCreateRequestDriverBuilder)? updates,
  ]) => (OrderCreateRequestDriverBuilder()..update(updates))._build();

  _$OrderCreateRequestDriver._({
    this.id,
    this.userId,
    this.studentId,
    this.licenseNumber,
    this.status,
    this.rating,
    this.isOnline,
    this.currentLocation,
    this.lastLocationUpdate,
    this.createdAt,
    this.user,
  }) : super._();
  @override
  OrderCreateRequestDriver rebuild(
    void Function(OrderCreateRequestDriverBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  OrderCreateRequestDriverBuilder toBuilder() =>
      OrderCreateRequestDriverBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OrderCreateRequestDriver &&
        id == other.id &&
        userId == other.userId &&
        studentId == other.studentId &&
        licenseNumber == other.licenseNumber &&
        status == other.status &&
        rating == other.rating &&
        isOnline == other.isOnline &&
        currentLocation == other.currentLocation &&
        lastLocationUpdate == other.lastLocationUpdate &&
        createdAt == other.createdAt &&
        user == other.user;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, studentId.hashCode);
    _$hash = $jc(_$hash, licenseNumber.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, rating.hashCode);
    _$hash = $jc(_$hash, isOnline.hashCode);
    _$hash = $jc(_$hash, currentLocation.hashCode);
    _$hash = $jc(_$hash, lastLocationUpdate.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, user.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'OrderCreateRequestDriver')
          ..add('id', id)
          ..add('userId', userId)
          ..add('studentId', studentId)
          ..add('licenseNumber', licenseNumber)
          ..add('status', status)
          ..add('rating', rating)
          ..add('isOnline', isOnline)
          ..add('currentLocation', currentLocation)
          ..add('lastLocationUpdate', lastLocationUpdate)
          ..add('createdAt', createdAt)
          ..add('user', user))
        .toString();
  }
}

class OrderCreateRequestDriverBuilder
    implements
        Builder<OrderCreateRequestDriver, OrderCreateRequestDriverBuilder> {
  _$OrderCreateRequestDriver? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  String? _studentId;
  String? get studentId => _$this._studentId;
  set studentId(String? studentId) => _$this._studentId = studentId;

  String? _licenseNumber;
  String? get licenseNumber => _$this._licenseNumber;
  set licenseNumber(String? licenseNumber) =>
      _$this._licenseNumber = licenseNumber;

  OrderCreateRequestDriverStatusEnum? _status;
  OrderCreateRequestDriverStatusEnum? get status => _$this._status;
  set status(OrderCreateRequestDriverStatusEnum? status) =>
      _$this._status = status;

  num? _rating;
  num? get rating => _$this._rating;
  set rating(num? rating) => _$this._rating = rating;

  bool? _isOnline;
  bool? get isOnline => _$this._isOnline;
  set isOnline(bool? isOnline) => _$this._isOnline = isOnline;

  LocationBuilder? _currentLocation;
  LocationBuilder get currentLocation =>
      _$this._currentLocation ??= LocationBuilder();
  set currentLocation(LocationBuilder? currentLocation) =>
      _$this._currentLocation = currentLocation;

  num? _lastLocationUpdate;
  num? get lastLocationUpdate => _$this._lastLocationUpdate;
  set lastLocationUpdate(num? lastLocationUpdate) =>
      _$this._lastLocationUpdate = lastLocationUpdate;

  num? _createdAt;
  num? get createdAt => _$this._createdAt;
  set createdAt(num? createdAt) => _$this._createdAt = createdAt;

  DriverUpdateRequestUserBuilder? _user;
  DriverUpdateRequestUserBuilder get user =>
      _$this._user ??= DriverUpdateRequestUserBuilder();
  set user(DriverUpdateRequestUserBuilder? user) => _$this._user = user;

  OrderCreateRequestDriverBuilder() {
    OrderCreateRequestDriver._defaults(this);
  }

  OrderCreateRequestDriverBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _userId = $v.userId;
      _studentId = $v.studentId;
      _licenseNumber = $v.licenseNumber;
      _status = $v.status;
      _rating = $v.rating;
      _isOnline = $v.isOnline;
      _currentLocation = $v.currentLocation?.toBuilder();
      _lastLocationUpdate = $v.lastLocationUpdate;
      _createdAt = $v.createdAt;
      _user = $v.user?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OrderCreateRequestDriver other) {
    _$v = other as _$OrderCreateRequestDriver;
  }

  @override
  void update(void Function(OrderCreateRequestDriverBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  OrderCreateRequestDriver build() => _build();

  _$OrderCreateRequestDriver _build() {
    _$OrderCreateRequestDriver _$result;
    try {
      _$result =
          _$v ??
          _$OrderCreateRequestDriver._(
            id: id,
            userId: userId,
            studentId: studentId,
            licenseNumber: licenseNumber,
            status: status,
            rating: rating,
            isOnline: isOnline,
            currentLocation: _currentLocation?.build(),
            lastLocationUpdate: lastLocationUpdate,
            createdAt: createdAt,
            user: _user?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'currentLocation';
        _currentLocation?.build();

        _$failedField = 'user';
        _user?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'OrderCreateRequestDriver',
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
