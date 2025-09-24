// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_get_mine200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MerchantGetMine200Response extends MerchantGetMine200Response {
  @override
  final JsonObject? status;
  @override
  final MerchantGetMine200ResponseBody body;

  factory _$MerchantGetMine200Response([
    void Function(MerchantGetMine200ResponseBuilder)? updates,
  ]) => (MerchantGetMine200ResponseBuilder()..update(updates))._build();

  _$MerchantGetMine200Response._({this.status, required this.body}) : super._();
  @override
  MerchantGetMine200Response rebuild(
    void Function(MerchantGetMine200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  MerchantGetMine200ResponseBuilder toBuilder() =>
      MerchantGetMine200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MerchantGetMine200Response &&
        status == other.status &&
        body == other.body;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, body.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MerchantGetMine200Response')
          ..add('status', status)
          ..add('body', body))
        .toString();
  }
}

class MerchantGetMine200ResponseBuilder
    implements
        Builder<MerchantGetMine200Response, MerchantGetMine200ResponseBuilder> {
  _$MerchantGetMine200Response? _$v;

  JsonObject? _status;
  JsonObject? get status => _$this._status;
  set status(JsonObject? status) => _$this._status = status;

  MerchantGetMine200ResponseBodyBuilder? _body;
  MerchantGetMine200ResponseBodyBuilder get body =>
      _$this._body ??= MerchantGetMine200ResponseBodyBuilder();
  set body(MerchantGetMine200ResponseBodyBuilder? body) => _$this._body = body;

  MerchantGetMine200ResponseBuilder() {
    MerchantGetMine200Response._defaults(this);
  }

  MerchantGetMine200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _body = $v.body.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MerchantGetMine200Response other) {
    _$v = other as _$MerchantGetMine200Response;
  }

  @override
  void update(void Function(MerchantGetMine200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MerchantGetMine200Response build() => _build();

  _$MerchantGetMine200Response _build() {
    _$MerchantGetMine200Response _$result;
    try {
      _$result =
          _$v ??
          _$MerchantGetMine200Response._(status: status, body: body.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'body';
        body.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'MerchantGetMine200Response',
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
