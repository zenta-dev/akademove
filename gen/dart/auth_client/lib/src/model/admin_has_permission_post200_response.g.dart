// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_has_permission_post200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AdminHasPermissionPost200Response
    extends AdminHasPermissionPost200Response {
  @override
  final String? error;
  @override
  final bool success;

  factory _$AdminHasPermissionPost200Response([
    void Function(AdminHasPermissionPost200ResponseBuilder)? updates,
  ]) => (AdminHasPermissionPost200ResponseBuilder()..update(updates))._build();

  _$AdminHasPermissionPost200Response._({this.error, required this.success})
    : super._();
  @override
  AdminHasPermissionPost200Response rebuild(
    void Function(AdminHasPermissionPost200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AdminHasPermissionPost200ResponseBuilder toBuilder() =>
      AdminHasPermissionPost200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AdminHasPermissionPost200Response &&
        error == other.error &&
        success == other.success;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, error.hashCode);
    _$hash = $jc(_$hash, success.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AdminHasPermissionPost200Response')
          ..add('error', error)
          ..add('success', success))
        .toString();
  }
}

class AdminHasPermissionPost200ResponseBuilder
    implements
        Builder<
          AdminHasPermissionPost200Response,
          AdminHasPermissionPost200ResponseBuilder
        > {
  _$AdminHasPermissionPost200Response? _$v;

  String? _error;
  String? get error => _$this._error;
  set error(String? error) => _$this._error = error;

  bool? _success;
  bool? get success => _$this._success;
  set success(bool? success) => _$this._success = success;

  AdminHasPermissionPost200ResponseBuilder() {
    AdminHasPermissionPost200Response._defaults(this);
  }

  AdminHasPermissionPost200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _error = $v.error;
      _success = $v.success;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AdminHasPermissionPost200Response other) {
    _$v = other as _$AdminHasPermissionPost200Response;
  }

  @override
  void update(
    void Function(AdminHasPermissionPost200ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  AdminHasPermissionPost200Response build() => _build();

  _$AdminHasPermissionPost200Response _build() {
    final _$result =
        _$v ??
        _$AdminHasPermissionPost200Response._(
          error: error,
          success: BuiltValueNullFieldError.checkNotNull(
            success,
            r'AdminHasPermissionPost200Response',
            'success',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
