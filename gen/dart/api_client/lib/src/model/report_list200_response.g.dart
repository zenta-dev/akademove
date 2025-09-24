// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_list200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ReportList200Response extends ReportList200Response {
  @override
  final String message;
  @override
  final BuiltList<Report> data;

  factory _$ReportList200Response([
    void Function(ReportList200ResponseBuilder)? updates,
  ]) => (ReportList200ResponseBuilder()..update(updates))._build();

  _$ReportList200Response._({required this.message, required this.data})
    : super._();
  @override
  ReportList200Response rebuild(
    void Function(ReportList200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ReportList200ResponseBuilder toBuilder() =>
      ReportList200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReportList200Response &&
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
    return (newBuiltValueToStringHelper(r'ReportList200Response')
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class ReportList200ResponseBuilder
    implements Builder<ReportList200Response, ReportList200ResponseBuilder> {
  _$ReportList200Response? _$v;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  ListBuilder<Report>? _data;
  ListBuilder<Report> get data => _$this._data ??= ListBuilder<Report>();
  set data(ListBuilder<Report>? data) => _$this._data = data;

  ReportList200ResponseBuilder() {
    ReportList200Response._defaults(this);
  }

  ReportList200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ReportList200Response other) {
    _$v = other as _$ReportList200Response;
  }

  @override
  void update(void Function(ReportList200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ReportList200Response build() => _build();

  _$ReportList200Response _build() {
    _$ReportList200Response _$result;
    try {
      _$result =
          _$v ??
          _$ReportList200Response._(
            message: BuiltValueNullFieldError.checkNotNull(
              message,
              r'ReportList200Response',
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
          r'ReportList200Response',
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
