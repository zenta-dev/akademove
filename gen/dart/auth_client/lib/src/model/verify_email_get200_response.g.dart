// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_email_get200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$VerifyEmailGet200Response extends VerifyEmailGet200Response {
  @override
  final VerifyEmailGet200ResponseUser user;
  @override
  final bool status;

  factory _$VerifyEmailGet200Response([
    void Function(VerifyEmailGet200ResponseBuilder)? updates,
  ]) => (VerifyEmailGet200ResponseBuilder()..update(updates))._build();

  _$VerifyEmailGet200Response._({required this.user, required this.status})
    : super._();
  @override
  VerifyEmailGet200Response rebuild(
    void Function(VerifyEmailGet200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  VerifyEmailGet200ResponseBuilder toBuilder() =>
      VerifyEmailGet200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is VerifyEmailGet200Response &&
        user == other.user &&
        status == other.status;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, user.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'VerifyEmailGet200Response')
          ..add('user', user)
          ..add('status', status))
        .toString();
  }
}

class VerifyEmailGet200ResponseBuilder
    implements
        Builder<VerifyEmailGet200Response, VerifyEmailGet200ResponseBuilder> {
  _$VerifyEmailGet200Response? _$v;

  VerifyEmailGet200ResponseUserBuilder? _user;
  VerifyEmailGet200ResponseUserBuilder get user =>
      _$this._user ??= VerifyEmailGet200ResponseUserBuilder();
  set user(VerifyEmailGet200ResponseUserBuilder? user) => _$this._user = user;

  bool? _status;
  bool? get status => _$this._status;
  set status(bool? status) => _$this._status = status;

  VerifyEmailGet200ResponseBuilder() {
    VerifyEmailGet200Response._defaults(this);
  }

  VerifyEmailGet200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _user = $v.user.toBuilder();
      _status = $v.status;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(VerifyEmailGet200Response other) {
    _$v = other as _$VerifyEmailGet200Response;
  }

  @override
  void update(void Function(VerifyEmailGet200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  VerifyEmailGet200Response build() => _build();

  _$VerifyEmailGet200Response _build() {
    _$VerifyEmailGet200Response _$result;
    try {
      _$result =
          _$v ??
          _$VerifyEmailGet200Response._(
            user: user.build(),
            status: BuiltValueNullFieldError.checkNotNull(
              status,
              r'VerifyEmailGet200Response',
              'status',
            ),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'user';
        user.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'VerifyEmailGet200Response',
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
