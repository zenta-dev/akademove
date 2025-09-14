// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_driver_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const UpdateDriverRequestStatusEnum _$updateDriverRequestStatusEnum_pending =
    const UpdateDriverRequestStatusEnum._('pending');
const UpdateDriverRequestStatusEnum _$updateDriverRequestStatusEnum_approved =
    const UpdateDriverRequestStatusEnum._('approved');
const UpdateDriverRequestStatusEnum _$updateDriverRequestStatusEnum_rejected =
    const UpdateDriverRequestStatusEnum._('rejected');
const UpdateDriverRequestStatusEnum _$updateDriverRequestStatusEnum_active =
    const UpdateDriverRequestStatusEnum._('active');
const UpdateDriverRequestStatusEnum _$updateDriverRequestStatusEnum_inactive =
    const UpdateDriverRequestStatusEnum._('inactive');
const UpdateDriverRequestStatusEnum _$updateDriverRequestStatusEnum_suspended =
    const UpdateDriverRequestStatusEnum._('suspended');

UpdateDriverRequestStatusEnum _$updateDriverRequestStatusEnumValueOf(
    String name) {
  switch (name) {
    case 'pending':
      return _$updateDriverRequestStatusEnum_pending;
    case 'approved':
      return _$updateDriverRequestStatusEnum_approved;
    case 'rejected':
      return _$updateDriverRequestStatusEnum_rejected;
    case 'active':
      return _$updateDriverRequestStatusEnum_active;
    case 'inactive':
      return _$updateDriverRequestStatusEnum_inactive;
    case 'suspended':
      return _$updateDriverRequestStatusEnum_suspended;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<UpdateDriverRequestStatusEnum>
    _$updateDriverRequestStatusEnumValues = BuiltSet<
        UpdateDriverRequestStatusEnum>(const <UpdateDriverRequestStatusEnum>[
  _$updateDriverRequestStatusEnum_pending,
  _$updateDriverRequestStatusEnum_approved,
  _$updateDriverRequestStatusEnum_rejected,
  _$updateDriverRequestStatusEnum_active,
  _$updateDriverRequestStatusEnum_inactive,
  _$updateDriverRequestStatusEnum_suspended,
]);

Serializer<UpdateDriverRequestStatusEnum>
    _$updateDriverRequestStatusEnumSerializer =
    _$UpdateDriverRequestStatusEnumSerializer();

class _$UpdateDriverRequestStatusEnumSerializer
    implements PrimitiveSerializer<UpdateDriverRequestStatusEnum> {
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
  final Iterable<Type> types = const <Type>[UpdateDriverRequestStatusEnum];
  @override
  final String wireName = 'UpdateDriverRequestStatusEnum';

  @override
  Object serialize(
          Serializers serializers, UpdateDriverRequestStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  UpdateDriverRequestStatusEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      UpdateDriverRequestStatusEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$UpdateDriverRequest extends UpdateDriverRequest {
  @override
  final String? studentId;
  @override
  final String? licenseNumber;
  @override
  final UpdateDriverRequestStatusEnum? status;
  @override
  final bool? isOnline;
  @override
  final Location? currentLocation;

  factory _$UpdateDriverRequest(
          [void Function(UpdateDriverRequestBuilder)? updates]) =>
      (UpdateDriverRequestBuilder()..update(updates))._build();

  _$UpdateDriverRequest._(
      {this.studentId,
      this.licenseNumber,
      this.status,
      this.isOnline,
      this.currentLocation})
      : super._();
  @override
  UpdateDriverRequest rebuild(
          void Function(UpdateDriverRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UpdateDriverRequestBuilder toBuilder() =>
      UpdateDriverRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateDriverRequest &&
        studentId == other.studentId &&
        licenseNumber == other.licenseNumber &&
        status == other.status &&
        isOnline == other.isOnline &&
        currentLocation == other.currentLocation;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, studentId.hashCode);
    _$hash = $jc(_$hash, licenseNumber.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, isOnline.hashCode);
    _$hash = $jc(_$hash, currentLocation.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateDriverRequest')
          ..add('studentId', studentId)
          ..add('licenseNumber', licenseNumber)
          ..add('status', status)
          ..add('isOnline', isOnline)
          ..add('currentLocation', currentLocation))
        .toString();
  }
}

class UpdateDriverRequestBuilder
    implements Builder<UpdateDriverRequest, UpdateDriverRequestBuilder> {
  _$UpdateDriverRequest? _$v;

  String? _studentId;
  String? get studentId => _$this._studentId;
  set studentId(String? studentId) => _$this._studentId = studentId;

  String? _licenseNumber;
  String? get licenseNumber => _$this._licenseNumber;
  set licenseNumber(String? licenseNumber) =>
      _$this._licenseNumber = licenseNumber;

  UpdateDriverRequestStatusEnum? _status;
  UpdateDriverRequestStatusEnum? get status => _$this._status;
  set status(UpdateDriverRequestStatusEnum? status) => _$this._status = status;

  bool? _isOnline;
  bool? get isOnline => _$this._isOnline;
  set isOnline(bool? isOnline) => _$this._isOnline = isOnline;

  LocationBuilder? _currentLocation;
  LocationBuilder get currentLocation =>
      _$this._currentLocation ??= LocationBuilder();
  set currentLocation(LocationBuilder? currentLocation) =>
      _$this._currentLocation = currentLocation;

  UpdateDriverRequestBuilder() {
    UpdateDriverRequest._defaults(this);
  }

  UpdateDriverRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _studentId = $v.studentId;
      _licenseNumber = $v.licenseNumber;
      _status = $v.status;
      _isOnline = $v.isOnline;
      _currentLocation = $v.currentLocation?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateDriverRequest other) {
    _$v = other as _$UpdateDriverRequest;
  }

  @override
  void update(void Function(UpdateDriverRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateDriverRequest build() => _build();

  _$UpdateDriverRequest _build() {
    _$UpdateDriverRequest _$result;
    try {
      _$result = _$v ??
          _$UpdateDriverRequest._(
            studentId: studentId,
            licenseNumber: licenseNumber,
            status: status,
            isOnline: isOnline,
            currentLocation: _currentLocation?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'currentLocation';
        _currentLocation?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'UpdateDriverRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
