// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_create_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DriverCreateRequest extends DriverCreateRequest {
  @override
  final String studentId;
  @override
  final String licenseNumber;

  factory _$DriverCreateRequest([
    void Function(DriverCreateRequestBuilder)? updates,
  ]) => (DriverCreateRequestBuilder()..update(updates))._build();

  _$DriverCreateRequest._({
    required this.studentId,
    required this.licenseNumber,
  }) : super._();
  @override
  DriverCreateRequest rebuild(
    void Function(DriverCreateRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  DriverCreateRequestBuilder toBuilder() =>
      DriverCreateRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DriverCreateRequest &&
        studentId == other.studentId &&
        licenseNumber == other.licenseNumber;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, studentId.hashCode);
    _$hash = $jc(_$hash, licenseNumber.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DriverCreateRequest')
          ..add('studentId', studentId)
          ..add('licenseNumber', licenseNumber))
        .toString();
  }
}

class DriverCreateRequestBuilder
    implements Builder<DriverCreateRequest, DriverCreateRequestBuilder> {
  _$DriverCreateRequest? _$v;

  String? _studentId;
  String? get studentId => _$this._studentId;
  set studentId(String? studentId) => _$this._studentId = studentId;

  String? _licenseNumber;
  String? get licenseNumber => _$this._licenseNumber;
  set licenseNumber(String? licenseNumber) =>
      _$this._licenseNumber = licenseNumber;

  DriverCreateRequestBuilder() {
    DriverCreateRequest._defaults(this);
  }

  DriverCreateRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _studentId = $v.studentId;
      _licenseNumber = $v.licenseNumber;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DriverCreateRequest other) {
    _$v = other as _$DriverCreateRequest;
  }

  @override
  void update(void Function(DriverCreateRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DriverCreateRequest build() => _build();

  _$DriverCreateRequest _build() {
    final _$result =
        _$v ??
        _$DriverCreateRequest._(
          studentId: BuiltValueNullFieldError.checkNotNull(
            studentId,
            r'DriverCreateRequest',
            'studentId',
          ),
          licenseNumber: BuiltValueNullFieldError.checkNotNull(
            licenseNumber,
            r'DriverCreateRequest',
            'licenseNumber',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
