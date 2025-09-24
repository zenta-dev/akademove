// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'revoke_user_session_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RevokeUserSessionRequest extends RevokeUserSessionRequest {
  @override
  final String sessionToken;

  factory _$RevokeUserSessionRequest([
    void Function(RevokeUserSessionRequestBuilder)? updates,
  ]) => (RevokeUserSessionRequestBuilder()..update(updates))._build();

  _$RevokeUserSessionRequest._({required this.sessionToken}) : super._();
  @override
  RevokeUserSessionRequest rebuild(
    void Function(RevokeUserSessionRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  RevokeUserSessionRequestBuilder toBuilder() =>
      RevokeUserSessionRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RevokeUserSessionRequest &&
        sessionToken == other.sessionToken;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, sessionToken.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'RevokeUserSessionRequest',
    )..add('sessionToken', sessionToken)).toString();
  }
}

class RevokeUserSessionRequestBuilder
    implements
        Builder<RevokeUserSessionRequest, RevokeUserSessionRequestBuilder> {
  _$RevokeUserSessionRequest? _$v;

  String? _sessionToken;
  String? get sessionToken => _$this._sessionToken;
  set sessionToken(String? sessionToken) => _$this._sessionToken = sessionToken;

  RevokeUserSessionRequestBuilder() {
    RevokeUserSessionRequest._defaults(this);
  }

  RevokeUserSessionRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _sessionToken = $v.sessionToken;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RevokeUserSessionRequest other) {
    _$v = other as _$RevokeUserSessionRequest;
  }

  @override
  void update(void Function(RevokeUserSessionRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RevokeUserSessionRequest build() => _build();

  _$RevokeUserSessionRequest _build() {
    final _$result =
        _$v ??
        _$RevokeUserSessionRequest._(
          sessionToken: BuiltValueNullFieldError.checkNotNull(
            sessionToken,
            r'RevokeUserSessionRequest',
            'sessionToken',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
