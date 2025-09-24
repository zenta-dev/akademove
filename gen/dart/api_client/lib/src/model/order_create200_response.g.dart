// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_create200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$OrderCreate200Response extends OrderCreate200Response {
  @override
  final String message;
  @override
  final Order data;

  factory _$OrderCreate200Response([
    void Function(OrderCreate200ResponseBuilder)? updates,
  ]) => (OrderCreate200ResponseBuilder()..update(updates))._build();

  _$OrderCreate200Response._({required this.message, required this.data})
    : super._();
  @override
  OrderCreate200Response rebuild(
    void Function(OrderCreate200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  OrderCreate200ResponseBuilder toBuilder() =>
      OrderCreate200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OrderCreate200Response &&
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
    return (newBuiltValueToStringHelper(r'OrderCreate200Response')
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class OrderCreate200ResponseBuilder
    implements Builder<OrderCreate200Response, OrderCreate200ResponseBuilder> {
  _$OrderCreate200Response? _$v;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  OrderBuilder? _data;
  OrderBuilder get data => _$this._data ??= OrderBuilder();
  set data(OrderBuilder? data) => _$this._data = data;

  OrderCreate200ResponseBuilder() {
    OrderCreate200Response._defaults(this);
  }

  OrderCreate200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OrderCreate200Response other) {
    _$v = other as _$OrderCreate200Response;
  }

  @override
  void update(void Function(OrderCreate200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  OrderCreate200Response build() => _build();

  _$OrderCreate200Response _build() {
    _$OrderCreate200Response _$result;
    try {
      _$result =
          _$v ??
          _$OrderCreate200Response._(
            message: BuiltValueNullFieldError.checkNotNull(
              message,
              r'OrderCreate200Response',
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
          r'OrderCreate200Response',
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
