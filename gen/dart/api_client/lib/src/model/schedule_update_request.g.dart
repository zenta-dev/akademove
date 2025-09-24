// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_update_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ScheduleUpdateRequestDayOfWeekEnum
_$scheduleUpdateRequestDayOfWeekEnum_sunday =
    const ScheduleUpdateRequestDayOfWeekEnum._('sunday');
const ScheduleUpdateRequestDayOfWeekEnum
_$scheduleUpdateRequestDayOfWeekEnum_monday =
    const ScheduleUpdateRequestDayOfWeekEnum._('monday');
const ScheduleUpdateRequestDayOfWeekEnum
_$scheduleUpdateRequestDayOfWeekEnum_tuesday =
    const ScheduleUpdateRequestDayOfWeekEnum._('tuesday');
const ScheduleUpdateRequestDayOfWeekEnum
_$scheduleUpdateRequestDayOfWeekEnum_wednesday =
    const ScheduleUpdateRequestDayOfWeekEnum._('wednesday');
const ScheduleUpdateRequestDayOfWeekEnum
_$scheduleUpdateRequestDayOfWeekEnum_thursday =
    const ScheduleUpdateRequestDayOfWeekEnum._('thursday');
const ScheduleUpdateRequestDayOfWeekEnum
_$scheduleUpdateRequestDayOfWeekEnum_friday =
    const ScheduleUpdateRequestDayOfWeekEnum._('friday');
const ScheduleUpdateRequestDayOfWeekEnum
_$scheduleUpdateRequestDayOfWeekEnum_saturday =
    const ScheduleUpdateRequestDayOfWeekEnum._('saturday');

ScheduleUpdateRequestDayOfWeekEnum _$scheduleUpdateRequestDayOfWeekEnumValueOf(
  String name,
) {
  switch (name) {
    case 'sunday':
      return _$scheduleUpdateRequestDayOfWeekEnum_sunday;
    case 'monday':
      return _$scheduleUpdateRequestDayOfWeekEnum_monday;
    case 'tuesday':
      return _$scheduleUpdateRequestDayOfWeekEnum_tuesday;
    case 'wednesday':
      return _$scheduleUpdateRequestDayOfWeekEnum_wednesday;
    case 'thursday':
      return _$scheduleUpdateRequestDayOfWeekEnum_thursday;
    case 'friday':
      return _$scheduleUpdateRequestDayOfWeekEnum_friday;
    case 'saturday':
      return _$scheduleUpdateRequestDayOfWeekEnum_saturday;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<ScheduleUpdateRequestDayOfWeekEnum>
_$scheduleUpdateRequestDayOfWeekEnumValues =
    BuiltSet<ScheduleUpdateRequestDayOfWeekEnum>(
      const <ScheduleUpdateRequestDayOfWeekEnum>[
        _$scheduleUpdateRequestDayOfWeekEnum_sunday,
        _$scheduleUpdateRequestDayOfWeekEnum_monday,
        _$scheduleUpdateRequestDayOfWeekEnum_tuesday,
        _$scheduleUpdateRequestDayOfWeekEnum_wednesday,
        _$scheduleUpdateRequestDayOfWeekEnum_thursday,
        _$scheduleUpdateRequestDayOfWeekEnum_friday,
        _$scheduleUpdateRequestDayOfWeekEnum_saturday,
      ],
    );

Serializer<ScheduleUpdateRequestDayOfWeekEnum>
_$scheduleUpdateRequestDayOfWeekEnumSerializer =
    _$ScheduleUpdateRequestDayOfWeekEnumSerializer();

class _$ScheduleUpdateRequestDayOfWeekEnumSerializer
    implements PrimitiveSerializer<ScheduleUpdateRequestDayOfWeekEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'sunday': 'sunday',
    'monday': 'monday',
    'tuesday': 'tuesday',
    'wednesday': 'wednesday',
    'thursday': 'thursday',
    'friday': 'friday',
    'saturday': 'saturday',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'sunday': 'sunday',
    'monday': 'monday',
    'tuesday': 'tuesday',
    'wednesday': 'wednesday',
    'thursday': 'thursday',
    'friday': 'friday',
    'saturday': 'saturday',
  };

  @override
  final Iterable<Type> types = const <Type>[ScheduleUpdateRequestDayOfWeekEnum];
  @override
  final String wireName = 'ScheduleUpdateRequestDayOfWeekEnum';

  @override
  Object serialize(
    Serializers serializers,
    ScheduleUpdateRequestDayOfWeekEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  ScheduleUpdateRequestDayOfWeekEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => ScheduleUpdateRequestDayOfWeekEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$ScheduleUpdateRequest extends ScheduleUpdateRequest {
  @override
  final ScheduleUpdateRequestDayOfWeekEnum? dayOfWeek;
  @override
  final Time? startTime;
  @override
  final Time? endTime;
  @override
  final bool? isRecurring;
  @override
  final num? specificDate;
  @override
  final bool? isActive;

  factory _$ScheduleUpdateRequest([
    void Function(ScheduleUpdateRequestBuilder)? updates,
  ]) => (ScheduleUpdateRequestBuilder()..update(updates))._build();

  _$ScheduleUpdateRequest._({
    this.dayOfWeek,
    this.startTime,
    this.endTime,
    this.isRecurring,
    this.specificDate,
    this.isActive,
  }) : super._();
  @override
  ScheduleUpdateRequest rebuild(
    void Function(ScheduleUpdateRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ScheduleUpdateRequestBuilder toBuilder() =>
      ScheduleUpdateRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ScheduleUpdateRequest &&
        dayOfWeek == other.dayOfWeek &&
        startTime == other.startTime &&
        endTime == other.endTime &&
        isRecurring == other.isRecurring &&
        specificDate == other.specificDate &&
        isActive == other.isActive;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, dayOfWeek.hashCode);
    _$hash = $jc(_$hash, startTime.hashCode);
    _$hash = $jc(_$hash, endTime.hashCode);
    _$hash = $jc(_$hash, isRecurring.hashCode);
    _$hash = $jc(_$hash, specificDate.hashCode);
    _$hash = $jc(_$hash, isActive.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ScheduleUpdateRequest')
          ..add('dayOfWeek', dayOfWeek)
          ..add('startTime', startTime)
          ..add('endTime', endTime)
          ..add('isRecurring', isRecurring)
          ..add('specificDate', specificDate)
          ..add('isActive', isActive))
        .toString();
  }
}

class ScheduleUpdateRequestBuilder
    implements Builder<ScheduleUpdateRequest, ScheduleUpdateRequestBuilder> {
  _$ScheduleUpdateRequest? _$v;

  ScheduleUpdateRequestDayOfWeekEnum? _dayOfWeek;
  ScheduleUpdateRequestDayOfWeekEnum? get dayOfWeek => _$this._dayOfWeek;
  set dayOfWeek(ScheduleUpdateRequestDayOfWeekEnum? dayOfWeek) =>
      _$this._dayOfWeek = dayOfWeek;

  TimeBuilder? _startTime;
  TimeBuilder get startTime => _$this._startTime ??= TimeBuilder();
  set startTime(TimeBuilder? startTime) => _$this._startTime = startTime;

  TimeBuilder? _endTime;
  TimeBuilder get endTime => _$this._endTime ??= TimeBuilder();
  set endTime(TimeBuilder? endTime) => _$this._endTime = endTime;

  bool? _isRecurring;
  bool? get isRecurring => _$this._isRecurring;
  set isRecurring(bool? isRecurring) => _$this._isRecurring = isRecurring;

  num? _specificDate;
  num? get specificDate => _$this._specificDate;
  set specificDate(num? specificDate) => _$this._specificDate = specificDate;

  bool? _isActive;
  bool? get isActive => _$this._isActive;
  set isActive(bool? isActive) => _$this._isActive = isActive;

  ScheduleUpdateRequestBuilder() {
    ScheduleUpdateRequest._defaults(this);
  }

  ScheduleUpdateRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _dayOfWeek = $v.dayOfWeek;
      _startTime = $v.startTime?.toBuilder();
      _endTime = $v.endTime?.toBuilder();
      _isRecurring = $v.isRecurring;
      _specificDate = $v.specificDate;
      _isActive = $v.isActive;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ScheduleUpdateRequest other) {
    _$v = other as _$ScheduleUpdateRequest;
  }

  @override
  void update(void Function(ScheduleUpdateRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ScheduleUpdateRequest build() => _build();

  _$ScheduleUpdateRequest _build() {
    _$ScheduleUpdateRequest _$result;
    try {
      _$result =
          _$v ??
          _$ScheduleUpdateRequest._(
            dayOfWeek: dayOfWeek,
            startTime: _startTime?.build(),
            endTime: _endTime?.build(),
            isRecurring: isRecurring,
            specificDate: specificDate,
            isActive: isActive,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'startTime';
        _startTime?.build();
        _$failedField = 'endTime';
        _endTime?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ScheduleUpdateRequest',
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
