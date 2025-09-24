// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_list200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ScheduleList200Response extends ScheduleList200Response {
  @override
  final String message;
  @override
  final BuiltList<Schedule> data;

  factory _$ScheduleList200Response([
    void Function(ScheduleList200ResponseBuilder)? updates,
  ]) => (ScheduleList200ResponseBuilder()..update(updates))._build();

  _$ScheduleList200Response._({required this.message, required this.data})
    : super._();
  @override
  ScheduleList200Response rebuild(
    void Function(ScheduleList200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ScheduleList200ResponseBuilder toBuilder() =>
      ScheduleList200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ScheduleList200Response &&
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
    return (newBuiltValueToStringHelper(r'ScheduleList200Response')
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class ScheduleList200ResponseBuilder
    implements
        Builder<ScheduleList200Response, ScheduleList200ResponseBuilder> {
  _$ScheduleList200Response? _$v;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  ListBuilder<Schedule>? _data;
  ListBuilder<Schedule> get data => _$this._data ??= ListBuilder<Schedule>();
  set data(ListBuilder<Schedule>? data) => _$this._data = data;

  ScheduleList200ResponseBuilder() {
    ScheduleList200Response._defaults(this);
  }

  ScheduleList200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ScheduleList200Response other) {
    _$v = other as _$ScheduleList200Response;
  }

  @override
  void update(void Function(ScheduleList200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ScheduleList200Response build() => _build();

  _$ScheduleList200Response _build() {
    _$ScheduleList200Response _$result;
    try {
      _$result =
          _$v ??
          _$ScheduleList200Response._(
            message: BuiltValueNullFieldError.checkNotNull(
              message,
              r'ScheduleList200Response',
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
          r'ScheduleList200Response',
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
