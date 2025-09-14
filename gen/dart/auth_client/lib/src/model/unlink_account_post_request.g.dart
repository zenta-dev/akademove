// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unlink_account_post_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UnlinkAccountPostRequest extends UnlinkAccountPostRequest {
  @override
  final String providerId;
  @override
  final String? accountId;

  factory _$UnlinkAccountPostRequest([
    void Function(UnlinkAccountPostRequestBuilder)? updates,
  ]) => (UnlinkAccountPostRequestBuilder()..update(updates))._build();

  _$UnlinkAccountPostRequest._({required this.providerId, this.accountId})
    : super._();
  @override
  UnlinkAccountPostRequest rebuild(
    void Function(UnlinkAccountPostRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UnlinkAccountPostRequestBuilder toBuilder() =>
      UnlinkAccountPostRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UnlinkAccountPostRequest &&
        providerId == other.providerId &&
        accountId == other.accountId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, providerId.hashCode);
    _$hash = $jc(_$hash, accountId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UnlinkAccountPostRequest')
          ..add('providerId', providerId)
          ..add('accountId', accountId))
        .toString();
  }
}

class UnlinkAccountPostRequestBuilder
    implements
        Builder<UnlinkAccountPostRequest, UnlinkAccountPostRequestBuilder> {
  _$UnlinkAccountPostRequest? _$v;

  String? _providerId;
  String? get providerId => _$this._providerId;
  set providerId(String? providerId) => _$this._providerId = providerId;

  String? _accountId;
  String? get accountId => _$this._accountId;
  set accountId(String? accountId) => _$this._accountId = accountId;

  UnlinkAccountPostRequestBuilder() {
    UnlinkAccountPostRequest._defaults(this);
  }

  UnlinkAccountPostRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _providerId = $v.providerId;
      _accountId = $v.accountId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UnlinkAccountPostRequest other) {
    _$v = other as _$UnlinkAccountPostRequest;
  }

  @override
  void update(void Function(UnlinkAccountPostRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UnlinkAccountPostRequest build() => _build();

  _$UnlinkAccountPostRequest _build() {
    final _$result =
        _$v ??
        _$UnlinkAccountPostRequest._(
          providerId: BuiltValueNullFieldError.checkNotNull(
            providerId,
            r'UnlinkAccountPostRequest',
            'providerId',
          ),
          accountId: accountId,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
