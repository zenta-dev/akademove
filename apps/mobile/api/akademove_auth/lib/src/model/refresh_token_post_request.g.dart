// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refresh_token_post_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RefreshTokenPostRequest extends RefreshTokenPostRequest {
  @override
  final String providerId;
  @override
  final String? accountId;
  @override
  final String? userId;

  factory _$RefreshTokenPostRequest(
          [void Function(RefreshTokenPostRequestBuilder)? updates]) =>
      (RefreshTokenPostRequestBuilder()..update(updates))._build();

  _$RefreshTokenPostRequest._(
      {required this.providerId, this.accountId, this.userId})
      : super._();
  @override
  RefreshTokenPostRequest rebuild(
          void Function(RefreshTokenPostRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RefreshTokenPostRequestBuilder toBuilder() =>
      RefreshTokenPostRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RefreshTokenPostRequest &&
        providerId == other.providerId &&
        accountId == other.accountId &&
        userId == other.userId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, providerId.hashCode);
    _$hash = $jc(_$hash, accountId.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RefreshTokenPostRequest')
          ..add('providerId', providerId)
          ..add('accountId', accountId)
          ..add('userId', userId))
        .toString();
  }
}

class RefreshTokenPostRequestBuilder
    implements
        Builder<RefreshTokenPostRequest, RefreshTokenPostRequestBuilder> {
  _$RefreshTokenPostRequest? _$v;

  String? _providerId;
  String? get providerId => _$this._providerId;
  set providerId(String? providerId) => _$this._providerId = providerId;

  String? _accountId;
  String? get accountId => _$this._accountId;
  set accountId(String? accountId) => _$this._accountId = accountId;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  RefreshTokenPostRequestBuilder() {
    RefreshTokenPostRequest._defaults(this);
  }

  RefreshTokenPostRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _providerId = $v.providerId;
      _accountId = $v.accountId;
      _userId = $v.userId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RefreshTokenPostRequest other) {
    _$v = other as _$RefreshTokenPostRequest;
  }

  @override
  void update(void Function(RefreshTokenPostRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RefreshTokenPostRequest build() => _build();

  _$RefreshTokenPostRequest _build() {
    final _$result = _$v ??
        _$RefreshTokenPostRequest._(
          providerId: BuiltValueNullFieldError.checkNotNull(
              providerId, r'RefreshTokenPostRequest', 'providerId'),
          accountId: accountId,
          userId: userId,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
