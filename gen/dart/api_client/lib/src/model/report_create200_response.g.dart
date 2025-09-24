// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_create200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ReportCreate200Response extends ReportCreate200Response {
  @override
  final String message;
  @override
  final Report data;

  factory _$ReportCreate200Response([
    void Function(ReportCreate200ResponseBuilder)? updates,
  ]) => (ReportCreate200ResponseBuilder()..update(updates))._build();

  _$ReportCreate200Response._({required this.message, required this.data})
    : super._();
  @override
  ReportCreate200Response rebuild(
    void Function(ReportCreate200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ReportCreate200ResponseBuilder toBuilder() =>
      ReportCreate200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReportCreate200Response &&
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
    return (newBuiltValueToStringHelper(r'ReportCreate200Response')
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class ReportCreate200ResponseBuilder
    implements
        Builder<ReportCreate200Response, ReportCreate200ResponseBuilder> {
  _$ReportCreate200Response? _$v;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  ReportBuilder? _data;
  ReportBuilder get data => _$this._data ??= ReportBuilder();
  set data(ReportBuilder? data) => _$this._data = data;

  ReportCreate200ResponseBuilder() {
    ReportCreate200Response._defaults(this);
  }

  ReportCreate200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ReportCreate200Response other) {
    _$v = other as _$ReportCreate200Response;
  }

  @override
  void update(void Function(ReportCreate200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ReportCreate200Response build() => _build();

  _$ReportCreate200Response _build() {
    _$ReportCreate200Response _$result;
    try {
      _$result =
          _$v ??
          _$ReportCreate200Response._(
            message: BuiltValueNullFieldError.checkNotNull(
              message,
              r'ReportCreate200Response',
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
          r'ReportCreate200Response',
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
