// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_menu_list200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MerchantMenuList200Response extends MerchantMenuList200Response {
  @override
  final String message;
  @override
  final BuiltList<MerchantMenu> data;

  factory _$MerchantMenuList200Response([
    void Function(MerchantMenuList200ResponseBuilder)? updates,
  ]) => (MerchantMenuList200ResponseBuilder()..update(updates))._build();

  _$MerchantMenuList200Response._({required this.message, required this.data})
    : super._();
  @override
  MerchantMenuList200Response rebuild(
    void Function(MerchantMenuList200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  MerchantMenuList200ResponseBuilder toBuilder() =>
      MerchantMenuList200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MerchantMenuList200Response &&
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
    return (newBuiltValueToStringHelper(r'MerchantMenuList200Response')
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class MerchantMenuList200ResponseBuilder
    implements
        Builder<
          MerchantMenuList200Response,
          MerchantMenuList200ResponseBuilder
        > {
  _$MerchantMenuList200Response? _$v;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  ListBuilder<MerchantMenu>? _data;
  ListBuilder<MerchantMenu> get data =>
      _$this._data ??= ListBuilder<MerchantMenu>();
  set data(ListBuilder<MerchantMenu>? data) => _$this._data = data;

  MerchantMenuList200ResponseBuilder() {
    MerchantMenuList200Response._defaults(this);
  }

  MerchantMenuList200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MerchantMenuList200Response other) {
    _$v = other as _$MerchantMenuList200Response;
  }

  @override
  void update(void Function(MerchantMenuList200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MerchantMenuList200Response build() => _build();

  _$MerchantMenuList200Response _build() {
    _$MerchantMenuList200Response _$result;
    try {
      _$result =
          _$v ??
          _$MerchantMenuList200Response._(
            message: BuiltValueNullFieldError.checkNotNull(
              message,
              r'MerchantMenuList200Response',
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
          r'MerchantMenuList200Response',
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
