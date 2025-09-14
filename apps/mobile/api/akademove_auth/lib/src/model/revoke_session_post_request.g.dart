// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'revoke_session_post_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RevokeSessionPostRequest extends RevokeSessionPostRequest {
  @override
  final String token;

  factory _$RevokeSessionPostRequest(
          [void Function(RevokeSessionPostRequestBuilder)? updates]) =>
      (RevokeSessionPostRequestBuilder()..update(updates))._build();

  _$RevokeSessionPostRequest._({required this.token}) : super._();
  @override
  RevokeSessionPostRequest rebuild(
          void Function(RevokeSessionPostRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RevokeSessionPostRequestBuilder toBuilder() =>
      RevokeSessionPostRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RevokeSessionPostRequest && token == other.token;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, token.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RevokeSessionPostRequest')
          ..add('token', token))
        .toString();
  }
}

class RevokeSessionPostRequestBuilder
    implements
        Builder<RevokeSessionPostRequest, RevokeSessionPostRequestBuilder> {
  _$RevokeSessionPostRequest? _$v;

  String? _token;
  String? get token => _$this._token;
  set token(String? token) => _$this._token = token;

  RevokeSessionPostRequestBuilder() {
    RevokeSessionPostRequest._defaults(this);
  }

  RevokeSessionPostRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _token = $v.token;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RevokeSessionPostRequest other) {
    _$v = other as _$RevokeSessionPostRequest;
  }

  @override
  void update(void Function(RevokeSessionPostRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RevokeSessionPostRequest build() => _build();

  _$RevokeSessionPostRequest _build() {
    final _$result = _$v ??
        _$RevokeSessionPostRequest._(
          token: BuiltValueNullFieldError.checkNotNull(
              token, r'RevokeSessionPostRequest', 'token'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
