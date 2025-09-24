// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_list200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$OrderList200Response extends OrderList200Response {
  @override
  final String message;
  @override
  final BuiltList<Order> data;

  factory _$OrderList200Response([
    void Function(OrderList200ResponseBuilder)? updates,
  ]) => (OrderList200ResponseBuilder()..update(updates))._build();

  _$OrderList200Response._({required this.message, required this.data})
    : super._();
  @override
  OrderList200Response rebuild(
    void Function(OrderList200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  OrderList200ResponseBuilder toBuilder() =>
      OrderList200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OrderList200Response &&
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
    return (newBuiltValueToStringHelper(r'OrderList200Response')
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class OrderList200ResponseBuilder
    implements Builder<OrderList200Response, OrderList200ResponseBuilder> {
  _$OrderList200Response? _$v;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  ListBuilder<Order>? _data;
  ListBuilder<Order> get data => _$this._data ??= ListBuilder<Order>();
  set data(ListBuilder<Order>? data) => _$this._data = data;

  OrderList200ResponseBuilder() {
    OrderList200Response._defaults(this);
  }

  OrderList200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OrderList200Response other) {
    _$v = other as _$OrderList200Response;
  }

  @override
  void update(void Function(OrderList200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  OrderList200Response build() => _build();

  _$OrderList200Response _build() {
    _$OrderList200Response _$result;
    try {
      _$result =
          _$v ??
          _$OrderList200Response._(
            message: BuiltValueNullFieldError.checkNotNull(
              message,
              r'OrderList200Response',
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
          r'OrderList200Response',
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
