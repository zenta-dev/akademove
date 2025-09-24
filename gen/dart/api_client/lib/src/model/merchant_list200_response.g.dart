// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_list200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MerchantList200Response extends MerchantList200Response {
  @override
  final String message;
  @override
  final BuiltList<Merchant> data;

  factory _$MerchantList200Response([
    void Function(MerchantList200ResponseBuilder)? updates,
  ]) => (MerchantList200ResponseBuilder()..update(updates))._build();

  _$MerchantList200Response._({required this.message, required this.data})
    : super._();
  @override
  MerchantList200Response rebuild(
    void Function(MerchantList200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  MerchantList200ResponseBuilder toBuilder() =>
      MerchantList200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MerchantList200Response &&
        message == other.message &&
        data == other.data;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MerchantList200Response')
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class MerchantList200ResponseBuilder
    implements
        Builder<MerchantList200Response, MerchantList200ResponseBuilder> {
  _$MerchantList200Response? _$v;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  ListBuilder<Merchant>? _data;
  ListBuilder<Merchant> get data => _$this._data ??= ListBuilder<Merchant>();
  set data(ListBuilder<Merchant>? data) => _$this._data = data;

  MerchantList200ResponseBuilder() {
    MerchantList200Response._defaults(this);
  }

  MerchantList200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MerchantList200Response other) {
    _$v = other as _$MerchantList200Response;
  }

  @override
  void update(void Function(MerchantList200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MerchantList200Response build() => _build();

  _$MerchantList200Response _build() {
    _$MerchantList200Response _$result;
    try {
      _$result =
          _$v ??
          _$MerchantList200Response._(
            message: BuiltValueNullFieldError.checkNotNull(
              message,
              r'MerchantList200Response',
              'message',
            ),
            data: data.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'MerchantList200Response',
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
