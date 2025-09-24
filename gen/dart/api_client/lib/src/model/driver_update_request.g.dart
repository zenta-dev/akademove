// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_update_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const DriverUpdateRequestStatusEnum _$driverUpdateRequestStatusEnum_pending =
    const DriverUpdateRequestStatusEnum._('pending');
const DriverUpdateRequestStatusEnum _$driverUpdateRequestStatusEnum_approved =
    const DriverUpdateRequestStatusEnum._('approved');
const DriverUpdateRequestStatusEnum _$driverUpdateRequestStatusEnum_rejected =
    const DriverUpdateRequestStatusEnum._('rejected');
const DriverUpdateRequestStatusEnum _$driverUpdateRequestStatusEnum_active =
    const DriverUpdateRequestStatusEnum._('active');
const DriverUpdateRequestStatusEnum _$driverUpdateRequestStatusEnum_inactive =
    const DriverUpdateRequestStatusEnum._('inactive');
const DriverUpdateRequestStatusEnum _$driverUpdateRequestStatusEnum_suspended =
    const DriverUpdateRequestStatusEnum._('suspended');

DriverUpdateRequestStatusEnum _$driverUpdateRequestStatusEnumValueOf(
  String name,
) {
  switch (name) {
    case 'pending':
      return _$driverUpdateRequestStatusEnum_pending;
    case 'approved':
      return _$driverUpdateRequestStatusEnum_approved;
    case 'rejected':
      return _$driverUpdateRequestStatusEnum_rejected;
    case 'active':
      return _$driverUpdateRequestStatusEnum_active;
    case 'inactive':
      return _$driverUpdateRequestStatusEnum_inactive;
    case 'suspended':
      return _$driverUpdateRequestStatusEnum_suspended;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<DriverUpdateRequestStatusEnum>
_$driverUpdateRequestStatusEnumValues = BuiltSet<DriverUpdateRequestStatusEnum>(
  const <DriverUpdateRequestStatusEnum>[
    _$driverUpdateRequestStatusEnum_pending,
    _$driverUpdateRequestStatusEnum_approved,
    _$driverUpdateRequestStatusEnum_rejected,
    _$driverUpdateRequestStatusEnum_active,
    _$driverUpdateRequestStatusEnum_inactive,
    _$driverUpdateRequestStatusEnum_suspended,
  ],
);

Serializer<DriverUpdateRequestStatusEnum>
_$driverUpdateRequestStatusEnumSerializer =
    _$DriverUpdateRequestStatusEnumSerializer();

class _$DriverUpdateRequestStatusEnumSerializer
    implements PrimitiveSerializer<DriverUpdateRequestStatusEnum> {
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
  final Iterable<Type> types = const <Type>[DriverUpdateRequestStatusEnum];
  @override
  final String wireName = 'DriverUpdateRequestStatusEnum';

  @override
  Object serialize(
    Serializers serializers,
    DriverUpdateRequestStatusEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  DriverUpdateRequestStatusEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => DriverUpdateRequestStatusEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$DriverUpdateRequest extends DriverUpdateRequest {
  @override
  final String? studentId;
  @override
  final String? licenseNumber;
  @override
  final DriverUpdateRequestStatusEnum? status;
  @override
  final bool? isOnline;
  @override
  final Location? currentLocation;
  @override
  final DriverUpdateRequestUser? user;

  factory _$DriverUpdateRequest([
    void Function(DriverUpdateRequestBuilder)? updates,
  ]) => (DriverUpdateRequestBuilder()..update(updates))._build();

  _$DriverUpdateRequest._({
    this.studentId,
    this.licenseNumber,
    this.status,
    this.isOnline,
    this.currentLocation,
    this.user,
  }) : super._();
  @override
  DriverUpdateRequest rebuild(
    void Function(DriverUpdateRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  DriverUpdateRequestBuilder toBuilder() =>
      DriverUpdateRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DriverUpdateRequest &&
        studentId == other.studentId &&
        licenseNumber == other.licenseNumber &&
        status == other.status &&
        isOnline == other.isOnline &&
        currentLocation == other.currentLocation &&
        user == other.user;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, studentId.hashCode);
    _$hash = $jc(_$hash, licenseNumber.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, isOnline.hashCode);
    _$hash = $jc(_$hash, currentLocation.hashCode);
    _$hash = $jc(_$hash, user.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DriverUpdateRequest')
          ..add('studentId', studentId)
          ..add('licenseNumber', licenseNumber)
          ..add('status', status)
          ..add('isOnline', isOnline)
          ..add('currentLocation', currentLocation)
          ..add('user', user))
        .toString();
  }
}

class DriverUpdateRequestBuilder
    implements Builder<DriverUpdateRequest, DriverUpdateRequestBuilder> {
  _$DriverUpdateRequest? _$v;

  String? _studentId;
  String? get studentId => _$this._studentId;
  set studentId(String? studentId) => _$this._studentId = studentId;

  String? _licenseNumber;
  String? get licenseNumber => _$this._licenseNumber;
  set licenseNumber(String? licenseNumber) =>
      _$this._licenseNumber = licenseNumber;

  DriverUpdateRequestStatusEnum? _status;
  DriverUpdateRequestStatusEnum? get status => _$this._status;
  set status(DriverUpdateRequestStatusEnum? status) => _$this._status = status;

  bool? _isOnline;
  bool? get isOnline => _$this._isOnline;
  set isOnline(bool? isOnline) => _$this._isOnline = isOnline;

  LocationBuilder? _currentLocation;
  LocationBuilder get currentLocation =>
      _$this._currentLocation ??= LocationBuilder();
  set currentLocation(LocationBuilder? currentLocation) =>
      _$this._currentLocation = currentLocation;

  DriverUpdateRequestUserBuilder? _user;
  DriverUpdateRequestUserBuilder get user =>
      _$this._user ??= DriverUpdateRequestUserBuilder();
  set user(DriverUpdateRequestUserBuilder? user) => _$this._user = user;

  DriverUpdateRequestBuilder() {
    DriverUpdateRequest._defaults(this);
  }

  DriverUpdateRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _studentId = $v.studentId;
      _licenseNumber = $v.licenseNumber;
      _status = $v.status;
      _isOnline = $v.isOnline;
      _currentLocation = $v.currentLocation?.toBuilder();
      _user = $v.user?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DriverUpdateRequest other) {
    _$v = other as _$DriverUpdateRequest;
  }

  @override
  void update(void Function(DriverUpdateRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DriverUpdateRequest build() => _build();

  _$DriverUpdateRequest _build() {
    _$DriverUpdateRequest _$result;
    try {
      _$result =
          _$v ??
          _$DriverUpdateRequest._(
            studentId: studentId,
            licenseNumber: licenseNumber,
            status: status,
            isOnline: isOnline,
            currentLocation: _currentLocation?.build(),
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
          r'DriverUpdateRequest',
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
