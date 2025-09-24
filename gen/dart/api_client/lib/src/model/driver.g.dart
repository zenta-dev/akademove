// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const DriverStatusEnum _$driverStatusEnum_pending = const DriverStatusEnum._(
  'pending',
);
const DriverStatusEnum _$driverStatusEnum_approved = const DriverStatusEnum._(
  'approved',
);
const DriverStatusEnum _$driverStatusEnum_rejected = const DriverStatusEnum._(
  'rejected',
);
const DriverStatusEnum _$driverStatusEnum_active = const DriverStatusEnum._(
  'active',
);
const DriverStatusEnum _$driverStatusEnum_inactive = const DriverStatusEnum._(
  'inactive',
);
const DriverStatusEnum _$driverStatusEnum_suspended = const DriverStatusEnum._(
  'suspended',
);

DriverStatusEnum _$driverStatusEnumValueOf(String name) {
  switch (name) {
    case 'pending':
      return _$driverStatusEnum_pending;
    case 'approved':
      return _$driverStatusEnum_approved;
    case 'rejected':
      return _$driverStatusEnum_rejected;
    case 'active':
      return _$driverStatusEnum_active;
    case 'inactive':
      return _$driverStatusEnum_inactive;
    case 'suspended':
      return _$driverStatusEnum_suspended;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<DriverStatusEnum> _$driverStatusEnumValues =
    BuiltSet<DriverStatusEnum>(const <DriverStatusEnum>[
      _$driverStatusEnum_pending,
      _$driverStatusEnum_approved,
      _$driverStatusEnum_rejected,
      _$driverStatusEnum_active,
      _$driverStatusEnum_inactive,
      _$driverStatusEnum_suspended,
    ]);

Serializer<DriverStatusEnum> _$driverStatusEnumSerializer =
    _$DriverStatusEnumSerializer();

class _$DriverStatusEnumSerializer
    implements PrimitiveSerializer<DriverStatusEnum> {
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
  final Iterable<Type> types = const <Type>[DriverStatusEnum];
  @override
  final String wireName = 'DriverStatusEnum';

  @override
  Object serialize(
    Serializers serializers,
    DriverStatusEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  DriverStatusEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => DriverStatusEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$Driver extends Driver {
  @override
  final String id;
  @override
  final String userId;
  @override
  final String studentId;
  @override
  final String licenseNumber;
  @override
  final DriverStatusEnum status;
  @override
  final num rating;
  @override
  final bool isOnline;
  @override
  final Location? currentLocation;
  @override
  final num? lastLocationUpdate;
  @override
  final num createdAt;
  @override
  final DriverUpdateRequestUser? user;

  factory _$Driver([void Function(DriverBuilder)? updates]) =>
      (DriverBuilder()..update(updates))._build();

  _$Driver._({
    required this.id,
    required this.userId,
    required this.studentId,
    required this.licenseNumber,
    required this.status,
    required this.rating,
    required this.isOnline,
    this.currentLocation,
    this.lastLocationUpdate,
    required this.createdAt,
    this.user,
  }) : super._();
  @override
  Driver rebuild(void Function(DriverBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DriverBuilder toBuilder() => DriverBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Driver &&
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
    return (newBuiltValueToStringHelper(r'Driver')
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

class DriverBuilder implements Builder<Driver, DriverBuilder> {
  _$Driver? _$v;

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

  DriverStatusEnum? _status;
  DriverStatusEnum? get status => _$this._status;
  set status(DriverStatusEnum? status) => _$this._status = status;

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

  DriverBuilder() {
    Driver._defaults(this);
  }

  DriverBuilder get _$this {
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
  void replace(Driver other) {
    _$v = other as _$Driver;
  }

  @override
  void update(void Function(DriverBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Driver build() => _build();

  _$Driver _build() {
    _$Driver _$result;
    try {
      _$result =
          _$v ??
          _$Driver._(
            id: BuiltValueNullFieldError.checkNotNull(id, r'Driver', 'id'),
            userId: BuiltValueNullFieldError.checkNotNull(
              userId,
              r'Driver',
              'userId',
            ),
            studentId: BuiltValueNullFieldError.checkNotNull(
              studentId,
              r'Driver',
              'studentId',
            ),
            licenseNumber: BuiltValueNullFieldError.checkNotNull(
              licenseNumber,
              r'Driver',
              'licenseNumber',
            ),
            status: BuiltValueNullFieldError.checkNotNull(
              status,
              r'Driver',
              'status',
            ),
            rating: BuiltValueNullFieldError.checkNotNull(
              rating,
              r'Driver',
              'rating',
            ),
            isOnline: BuiltValueNullFieldError.checkNotNull(
              isOnline,
              r'Driver',
              'isOnline',
            ),
            currentLocation: _currentLocation?.build(),
            lastLocationUpdate: lastLocationUpdate,
            createdAt: BuiltValueNullFieldError.checkNotNull(
              createdAt,
              r'Driver',
              'createdAt',
            ),
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
          r'Driver',
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
