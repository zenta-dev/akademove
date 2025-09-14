// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_driver_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateDriverRequest extends CreateDriverRequest {
  @override
  final String studentId;
  @override
  final String licenseNumber;

  factory _$CreateDriverRequest([
    void Function(CreateDriverRequestBuilder)? updates,
  ]) => (CreateDriverRequestBuilder()..update(updates))._build();

  _$CreateDriverRequest._({
    required this.studentId,
    required this.licenseNumber,
  }) : super._();
  @override
  CreateDriverRequest rebuild(
    void Function(CreateDriverRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CreateDriverRequestBuilder toBuilder() =>
      CreateDriverRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateDriverRequest &&
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
    return (newBuiltValueToStringHelper(r'CreateDriverRequest')
          ..add('studentId', studentId)
          ..add('licenseNumber', licenseNumber))
        .toString();
  }
}

class CreateDriverRequestBuilder
    implements Builder<CreateDriverRequest, CreateDriverRequestBuilder> {
  _$CreateDriverRequest? _$v;

  String? _studentId;
  String? get studentId => _$this._studentId;
  set studentId(String? studentId) => _$this._studentId = studentId;

  String? _licenseNumber;
  String? get licenseNumber => _$this._licenseNumber;
  set licenseNumber(String? licenseNumber) =>
      _$this._licenseNumber = licenseNumber;

  CreateDriverRequestBuilder() {
    CreateDriverRequest._defaults(this);
  }

  CreateDriverRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _studentId = $v.studentId;
      _licenseNumber = $v.licenseNumber;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateDriverRequest other) {
    _$v = other as _$CreateDriverRequest;
  }

  @override
  void update(void Function(CreateDriverRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateDriverRequest build() => _build();

  _$CreateDriverRequest _build() {
    final _$result =
        _$v ??
        _$CreateDriverRequest._(
          studentId: BuiltValueNullFieldError.checkNotNull(
            studentId,
            r'CreateDriverRequest',
            'studentId',
          ),
          licenseNumber: BuiltValueNullFieldError.checkNotNull(
            licenseNumber,
            r'CreateDriverRequest',
            'licenseNumber',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
