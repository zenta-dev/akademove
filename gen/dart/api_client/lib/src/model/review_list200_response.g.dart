// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_list200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ReviewList200Response extends ReviewList200Response {
  @override
  final String message;
  @override
  final BuiltList<Review> data;

  factory _$ReviewList200Response([
    void Function(ReviewList200ResponseBuilder)? updates,
  ]) => (ReviewList200ResponseBuilder()..update(updates))._build();

  _$ReviewList200Response._({required this.message, required this.data})
    : super._();
  @override
  ReviewList200Response rebuild(
    void Function(ReviewList200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ReviewList200ResponseBuilder toBuilder() =>
      ReviewList200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReviewList200Response &&
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
    return (newBuiltValueToStringHelper(r'ReviewList200Response')
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class ReviewList200ResponseBuilder
    implements Builder<ReviewList200Response, ReviewList200ResponseBuilder> {
  _$ReviewList200Response? _$v;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  ListBuilder<Review>? _data;
  ListBuilder<Review> get data => _$this._data ??= ListBuilder<Review>();
  set data(ListBuilder<Review>? data) => _$this._data = data;

  ReviewList200ResponseBuilder() {
    ReviewList200Response._defaults(this);
  }

  ReviewList200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ReviewList200Response other) {
    _$v = other as _$ReviewList200Response;
  }

  @override
  void update(void Function(ReviewList200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ReviewList200Response build() => _build();

  _$ReviewList200Response _build() {
    _$ReviewList200Response _$result;
    try {
      _$result =
          _$v ??
          _$ReviewList200Response._(
            message: BuiltValueNullFieldError.checkNotNull(
              message,
              r'ReviewList200Response',
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
          r'ReviewList200Response',
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
