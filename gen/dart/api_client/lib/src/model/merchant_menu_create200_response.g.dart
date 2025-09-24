// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_menu_create200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MerchantMenuCreate200Response extends MerchantMenuCreate200Response {
  @override
  final String message;
  @override
  final MerchantMenu data;

  factory _$MerchantMenuCreate200Response([
    void Function(MerchantMenuCreate200ResponseBuilder)? updates,
  ]) => (MerchantMenuCreate200ResponseBuilder()..update(updates))._build();

  _$MerchantMenuCreate200Response._({required this.message, required this.data})
    : super._();
  @override
  MerchantMenuCreate200Response rebuild(
    void Function(MerchantMenuCreate200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  MerchantMenuCreate200ResponseBuilder toBuilder() =>
      MerchantMenuCreate200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MerchantMenuCreate200Response &&
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
    return (newBuiltValueToStringHelper(r'MerchantMenuCreate200Response')
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class MerchantMenuCreate200ResponseBuilder
    implements
        Builder<
          MerchantMenuCreate200Response,
          MerchantMenuCreate200ResponseBuilder
        > {
  _$MerchantMenuCreate200Response? _$v;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  MerchantMenuBuilder? _data;
  MerchantMenuBuilder get data => _$this._data ??= MerchantMenuBuilder();
  set data(MerchantMenuBuilder? data) => _$this._data = data;

  MerchantMenuCreate200ResponseBuilder() {
    MerchantMenuCreate200Response._defaults(this);
  }

  MerchantMenuCreate200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MerchantMenuCreate200Response other) {
    _$v = other as _$MerchantMenuCreate200Response;
  }

  @override
  void update(void Function(MerchantMenuCreate200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MerchantMenuCreate200Response build() => _build();

  _$MerchantMenuCreate200Response _build() {
    _$MerchantMenuCreate200Response _$result;
    try {
      _$result =
          _$v ??
          _$MerchantMenuCreate200Response._(
            message: BuiltValueNullFieldError.checkNotNull(
              message,
              r'MerchantMenuCreate200Response',
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
          r'MerchantMenuCreate200Response',
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
