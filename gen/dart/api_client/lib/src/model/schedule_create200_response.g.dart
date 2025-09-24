// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_create200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ScheduleCreate200Response extends ScheduleCreate200Response {
  @override
  final String message;
  @override
  final Schedule data;

  factory _$ScheduleCreate200Response([
    void Function(ScheduleCreate200ResponseBuilder)? updates,
  ]) => (ScheduleCreate200ResponseBuilder()..update(updates))._build();

  _$ScheduleCreate200Response._({required this.message, required this.data})
    : super._();
  @override
  ScheduleCreate200Response rebuild(
    void Function(ScheduleCreate200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ScheduleCreate200ResponseBuilder toBuilder() =>
      ScheduleCreate200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ScheduleCreate200Response &&
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
    return (newBuiltValueToStringHelper(r'ScheduleCreate200Response')
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class ScheduleCreate200ResponseBuilder
    implements
        Builder<ScheduleCreate200Response, ScheduleCreate200ResponseBuilder> {
  _$ScheduleCreate200Response? _$v;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  ScheduleBuilder? _data;
  ScheduleBuilder get data => _$this._data ??= ScheduleBuilder();
  set data(ScheduleBuilder? data) => _$this._data = data;

  ScheduleCreate200ResponseBuilder() {
    ScheduleCreate200Response._defaults(this);
  }

  ScheduleCreate200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ScheduleCreate200Response other) {
    _$v = other as _$ScheduleCreate200Response;
  }

  @override
  void update(void Function(ScheduleCreate200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ScheduleCreate200Response build() => _build();

  _$ScheduleCreate200Response _build() {
    _$ScheduleCreate200Response _$result;
    try {
      _$result =
          _$v ??
          _$ScheduleCreate200Response._(
            message: BuiltValueNullFieldError.checkNotNull(
              message,
              r'ScheduleCreate200Response',
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
          r'ScheduleCreate200Response',
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
