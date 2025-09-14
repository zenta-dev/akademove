// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_info_post_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AccountInfoPostRequest extends AccountInfoPostRequest {
  @override
  final String accountId;

  factory _$AccountInfoPostRequest(
          [void Function(AccountInfoPostRequestBuilder)? updates]) =>
      (AccountInfoPostRequestBuilder()..update(updates))._build();

  _$AccountInfoPostRequest._({required this.accountId}) : super._();
  @override
  AccountInfoPostRequest rebuild(
          void Function(AccountInfoPostRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AccountInfoPostRequestBuilder toBuilder() =>
      AccountInfoPostRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccountInfoPostRequest && accountId == other.accountId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, accountId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AccountInfoPostRequest')
          ..add('accountId', accountId))
        .toString();
  }
}

class AccountInfoPostRequestBuilder
    implements Builder<AccountInfoPostRequest, AccountInfoPostRequestBuilder> {
  _$AccountInfoPostRequest? _$v;

  String? _accountId;
  String? get accountId => _$this._accountId;
  set accountId(String? accountId) => _$this._accountId = accountId;

  AccountInfoPostRequestBuilder() {
    AccountInfoPostRequest._defaults(this);
  }

  AccountInfoPostRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _accountId = $v.accountId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AccountInfoPostRequest other) {
    _$v = other as _$AccountInfoPostRequest;
  }

  @override
  void update(void Function(AccountInfoPostRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AccountInfoPostRequest build() => _build();

  _$AccountInfoPostRequest _build() {
    final _$result = _$v ??
        _$AccountInfoPostRequest._(
          accountId: BuiltValueNullFieldError.checkNotNull(
              accountId, r'AccountInfoPostRequest', 'accountId'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
