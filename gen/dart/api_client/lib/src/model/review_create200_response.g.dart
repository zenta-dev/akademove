// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_create200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ReviewCreate200Response extends ReviewCreate200Response {
  @override
  final String message;
  @override
  final Review data;

  factory _$ReviewCreate200Response([
    void Function(ReviewCreate200ResponseBuilder)? updates,
  ]) => (ReviewCreate200ResponseBuilder()..update(updates))._build();

  _$ReviewCreate200Response._({required this.message, required this.data})
    : super._();
  @override
  ReviewCreate200Response rebuild(
    void Function(ReviewCreate200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ReviewCreate200ResponseBuilder toBuilder() =>
      ReviewCreate200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReviewCreate200Response &&
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
    return (newBuiltValueToStringHelper(r'ReviewCreate200Response')
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class ReviewCreate200ResponseBuilder
    implements
        Builder<ReviewCreate200Response, ReviewCreate200ResponseBuilder> {
  _$ReviewCreate200Response? _$v;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  ReviewBuilder? _data;
  ReviewBuilder get data => _$this._data ??= ReviewBuilder();
  set data(ReviewBuilder? data) => _$this._data = data;

  ReviewCreate200ResponseBuilder() {
    ReviewCreate200Response._defaults(this);
  }

  ReviewCreate200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ReviewCreate200Response other) {
    _$v = other as _$ReviewCreate200Response;
  }

  @override
  void update(void Function(ReviewCreate200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ReviewCreate200Response build() => _build();

  _$ReviewCreate200Response _build() {
    _$ReviewCreate200Response _$result;
    try {
      _$result =
          _$v ??
          _$ReviewCreate200Response._(
            message: BuiltValueNullFieldError.checkNotNull(
              message,
              r'ReviewCreate200Response',
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
          r'ReviewCreate200Response',
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
