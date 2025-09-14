// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_info_post200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AccountInfoPost200Response extends AccountInfoPost200Response {
  @override
  final AccountInfoPost200ResponseUser user;
  @override
  final BuiltMap<String, JsonObject?> data;

  factory _$AccountInfoPost200Response([
    void Function(AccountInfoPost200ResponseBuilder)? updates,
  ]) => (AccountInfoPost200ResponseBuilder()..update(updates))._build();

  _$AccountInfoPost200Response._({required this.user, required this.data})
    : super._();
  @override
  AccountInfoPost200Response rebuild(
    void Function(AccountInfoPost200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AccountInfoPost200ResponseBuilder toBuilder() =>
      AccountInfoPost200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccountInfoPost200Response &&
        user == other.user &&
        data == other.data;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, user.hashCode);
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AccountInfoPost200Response')
          ..add('user', user)
          ..add('data', data))
        .toString();
  }
}

class AccountInfoPost200ResponseBuilder
    implements
        Builder<AccountInfoPost200Response, AccountInfoPost200ResponseBuilder> {
  _$AccountInfoPost200Response? _$v;

  AccountInfoPost200ResponseUserBuilder? _user;
  AccountInfoPost200ResponseUserBuilder get user =>
      _$this._user ??= AccountInfoPost200ResponseUserBuilder();
  set user(AccountInfoPost200ResponseUserBuilder? user) => _$this._user = user;

  MapBuilder<String, JsonObject?>? _data;
  MapBuilder<String, JsonObject?> get data =>
      _$this._data ??= MapBuilder<String, JsonObject?>();
  set data(MapBuilder<String, JsonObject?>? data) => _$this._data = data;

  AccountInfoPost200ResponseBuilder() {
    AccountInfoPost200Response._defaults(this);
  }

  AccountInfoPost200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _user = $v.user.toBuilder();
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AccountInfoPost200Response other) {
    _$v = other as _$AccountInfoPost200Response;
  }

  @override
  void update(void Function(AccountInfoPost200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AccountInfoPost200Response build() => _build();

  _$AccountInfoPost200Response _build() {
    _$AccountInfoPost200Response _$result;
    try {
      _$result =
          _$v ??
          _$AccountInfoPost200Response._(
            user: user.build(),
            data: data.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'user';
        user.build();
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'AccountInfoPost200Response',
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
