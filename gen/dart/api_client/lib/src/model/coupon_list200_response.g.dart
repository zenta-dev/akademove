// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon_list200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CouponList200Response extends CouponList200Response {
  @override
  final String message;
  @override
  final BuiltList<Coupon> data;

  factory _$CouponList200Response([
    void Function(CouponList200ResponseBuilder)? updates,
  ]) => (CouponList200ResponseBuilder()..update(updates))._build();

  _$CouponList200Response._({required this.message, required this.data})
    : super._();
  @override
  CouponList200Response rebuild(
    void Function(CouponList200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CouponList200ResponseBuilder toBuilder() =>
      CouponList200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CouponList200Response &&
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
    return (newBuiltValueToStringHelper(r'CouponList200Response')
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class CouponList200ResponseBuilder
    implements Builder<CouponList200Response, CouponList200ResponseBuilder> {
  _$CouponList200Response? _$v;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  ListBuilder<Coupon>? _data;
  ListBuilder<Coupon> get data => _$this._data ??= ListBuilder<Coupon>();
  set data(ListBuilder<Coupon>? data) => _$this._data = data;

  CouponList200ResponseBuilder() {
    CouponList200Response._defaults(this);
  }

  CouponList200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CouponList200Response other) {
    _$v = other as _$CouponList200Response;
  }

  @override
  void update(void Function(CouponList200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CouponList200Response build() => _build();

  _$CouponList200Response _build() {
    _$CouponList200Response _$result;
    try {
      _$result =
          _$v ??
          _$CouponList200Response._(
            message: BuiltValueNullFieldError.checkNotNull(
              message,
              r'CouponList200Response',
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
          r'CouponList200Response',
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
