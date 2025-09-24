// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_get_mine200_response_body.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MerchantGetMine200ResponseBody extends MerchantGetMine200ResponseBody {
  @override
  final String message;
  @override
  final Merchant data;

  factory _$MerchantGetMine200ResponseBody([
    void Function(MerchantGetMine200ResponseBodyBuilder)? updates,
  ]) => (MerchantGetMine200ResponseBodyBuilder()..update(updates))._build();

  _$MerchantGetMine200ResponseBody._({
    required this.message,
    required this.data,
  }) : super._();
  @override
  MerchantGetMine200ResponseBody rebuild(
    void Function(MerchantGetMine200ResponseBodyBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  MerchantGetMine200ResponseBodyBuilder toBuilder() =>
      MerchantGetMine200ResponseBodyBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MerchantGetMine200ResponseBody &&
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
    return (newBuiltValueToStringHelper(r'MerchantGetMine200ResponseBody')
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class MerchantGetMine200ResponseBodyBuilder
    implements
        Builder<
          MerchantGetMine200ResponseBody,
          MerchantGetMine200ResponseBodyBuilder
        > {
  _$MerchantGetMine200ResponseBody? _$v;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  MerchantBuilder? _data;
  MerchantBuilder get data => _$this._data ??= MerchantBuilder();
  set data(MerchantBuilder? data) => _$this._data = data;

  MerchantGetMine200ResponseBodyBuilder() {
    MerchantGetMine200ResponseBody._defaults(this);
  }

  MerchantGetMine200ResponseBodyBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MerchantGetMine200ResponseBody other) {
    _$v = other as _$MerchantGetMine200ResponseBody;
  }

  @override
  void update(void Function(MerchantGetMine200ResponseBodyBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MerchantGetMine200ResponseBody build() => _build();

  _$MerchantGetMine200ResponseBody _build() {
    _$MerchantGetMine200ResponseBody _$result;
    try {
      _$result =
          _$v ??
          _$MerchantGetMine200ResponseBody._(
            message: BuiltValueNullFieldError.checkNotNull(
              message,
              r'MerchantGetMine200ResponseBody',
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
          r'MerchantGetMine200ResponseBody',
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
