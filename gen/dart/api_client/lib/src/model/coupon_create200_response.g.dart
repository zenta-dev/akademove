// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon_create200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CouponCreate200Response extends CouponCreate200Response {
  @override
  final String message;
  @override
  final Coupon data;

  factory _$CouponCreate200Response([
    void Function(CouponCreate200ResponseBuilder)? updates,
  ]) => (CouponCreate200ResponseBuilder()..update(updates))._build();

  _$CouponCreate200Response._({required this.message, required this.data})
    : super._();
  @override
  CouponCreate200Response rebuild(
    void Function(CouponCreate200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CouponCreate200ResponseBuilder toBuilder() =>
      CouponCreate200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CouponCreate200Response &&
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
    return (newBuiltValueToStringHelper(r'CouponCreate200Response')
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class CouponCreate200ResponseBuilder
    implements
        Builder<CouponCreate200Response, CouponCreate200ResponseBuilder> {
  _$CouponCreate200Response? _$v;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  CouponBuilder? _data;
  CouponBuilder get data => _$this._data ??= CouponBuilder();
  set data(CouponBuilder? data) => _$this._data = data;

  CouponCreate200ResponseBuilder() {
    CouponCreate200Response._defaults(this);
  }

  CouponCreate200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CouponCreate200Response other) {
    _$v = other as _$CouponCreate200Response;
  }

  @override
  void update(void Function(CouponCreate200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CouponCreate200Response build() => _build();

  _$CouponCreate200Response _build() {
    _$CouponCreate200Response _$result;
    try {
      _$result =
          _$v ??
          _$CouponCreate200Response._(
            message: BuiltValueNullFieldError.checkNotNull(
              message,
              r'CouponCreate200Response',
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
          r'CouponCreate200Response',
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
