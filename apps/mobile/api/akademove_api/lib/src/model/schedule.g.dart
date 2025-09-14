// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ScheduleDayOfWeekEnum _$scheduleDayOfWeekEnum_sunday =
    const ScheduleDayOfWeekEnum._('sunday');
const ScheduleDayOfWeekEnum _$scheduleDayOfWeekEnum_monday =
    const ScheduleDayOfWeekEnum._('monday');
const ScheduleDayOfWeekEnum _$scheduleDayOfWeekEnum_tuesday =
    const ScheduleDayOfWeekEnum._('tuesday');
const ScheduleDayOfWeekEnum _$scheduleDayOfWeekEnum_wednesday =
    const ScheduleDayOfWeekEnum._('wednesday');
const ScheduleDayOfWeekEnum _$scheduleDayOfWeekEnum_thursday =
    const ScheduleDayOfWeekEnum._('thursday');
const ScheduleDayOfWeekEnum _$scheduleDayOfWeekEnum_friday =
    const ScheduleDayOfWeekEnum._('friday');
const ScheduleDayOfWeekEnum _$scheduleDayOfWeekEnum_saturday =
    const ScheduleDayOfWeekEnum._('saturday');

ScheduleDayOfWeekEnum _$scheduleDayOfWeekEnumValueOf(String name) {
  switch (name) {
    case 'sunday':
      return _$scheduleDayOfWeekEnum_sunday;
    case 'monday':
      return _$scheduleDayOfWeekEnum_monday;
    case 'tuesday':
      return _$scheduleDayOfWeekEnum_tuesday;
    case 'wednesday':
      return _$scheduleDayOfWeekEnum_wednesday;
    case 'thursday':
      return _$scheduleDayOfWeekEnum_thursday;
    case 'friday':
      return _$scheduleDayOfWeekEnum_friday;
    case 'saturday':
      return _$scheduleDayOfWeekEnum_saturday;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<ScheduleDayOfWeekEnum> _$scheduleDayOfWeekEnumValues =
    BuiltSet<ScheduleDayOfWeekEnum>(const <ScheduleDayOfWeekEnum>[
  _$scheduleDayOfWeekEnum_sunday,
  _$scheduleDayOfWeekEnum_monday,
  _$scheduleDayOfWeekEnum_tuesday,
  _$scheduleDayOfWeekEnum_wednesday,
  _$scheduleDayOfWeekEnum_thursday,
  _$scheduleDayOfWeekEnum_friday,
  _$scheduleDayOfWeekEnum_saturday,
]);

Serializer<ScheduleDayOfWeekEnum> _$scheduleDayOfWeekEnumSerializer =
    _$ScheduleDayOfWeekEnumSerializer();

class _$ScheduleDayOfWeekEnumSerializer
    implements PrimitiveSerializer<ScheduleDayOfWeekEnum> {
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
  final Iterable<Type> types = const <Type>[ScheduleDayOfWeekEnum];
  @override
  final String wireName = 'ScheduleDayOfWeekEnum';

  @override
  Object serialize(Serializers serializers, ScheduleDayOfWeekEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  ScheduleDayOfWeekEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ScheduleDayOfWeekEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Schedule extends Schedule {
  @override
  final String id;
  @override
  final String driverId;
  @override
  final ScheduleDayOfWeekEnum dayOfWeek;
  @override
  final Time startTime;
  @override
  final Time endTime;
  @override
  final num? specificDate;
  @override
  final num createdAt;
  @override
  final num updatedAt;
  @override
  final bool? isRecurring;
  @override
  final bool? isActive;

  factory _$Schedule([void Function(ScheduleBuilder)? updates]) =>
      (ScheduleBuilder()..update(updates))._build();

  _$Schedule._(
      {required this.id,
      required this.driverId,
      required this.dayOfWeek,
      required this.startTime,
      required this.endTime,
      this.specificDate,
      required this.createdAt,
      required this.updatedAt,
      this.isRecurring,
      this.isActive})
      : super._();
  @override
  Schedule rebuild(void Function(ScheduleBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ScheduleBuilder toBuilder() => ScheduleBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Schedule &&
        id == other.id &&
        driverId == other.driverId &&
        dayOfWeek == other.dayOfWeek &&
        startTime == other.startTime &&
        endTime == other.endTime &&
        specificDate == other.specificDate &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        isRecurring == other.isRecurring &&
        isActive == other.isActive;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, driverId.hashCode);
    _$hash = $jc(_$hash, dayOfWeek.hashCode);
    _$hash = $jc(_$hash, startTime.hashCode);
    _$hash = $jc(_$hash, endTime.hashCode);
    _$hash = $jc(_$hash, specificDate.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, isRecurring.hashCode);
    _$hash = $jc(_$hash, isActive.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Schedule')
          ..add('id', id)
          ..add('driverId', driverId)
          ..add('dayOfWeek', dayOfWeek)
          ..add('startTime', startTime)
          ..add('endTime', endTime)
          ..add('specificDate', specificDate)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('isRecurring', isRecurring)
          ..add('isActive', isActive))
        .toString();
  }
}

class ScheduleBuilder implements Builder<Schedule, ScheduleBuilder> {
  _$Schedule? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _driverId;
  String? get driverId => _$this._driverId;
  set driverId(String? driverId) => _$this._driverId = driverId;

  ScheduleDayOfWeekEnum? _dayOfWeek;
  ScheduleDayOfWeekEnum? get dayOfWeek => _$this._dayOfWeek;
  set dayOfWeek(ScheduleDayOfWeekEnum? dayOfWeek) =>
      _$this._dayOfWeek = dayOfWeek;

  TimeBuilder? _startTime;
  TimeBuilder get startTime => _$this._startTime ??= TimeBuilder();
  set startTime(TimeBuilder? startTime) => _$this._startTime = startTime;

  TimeBuilder? _endTime;
  TimeBuilder get endTime => _$this._endTime ??= TimeBuilder();
  set endTime(TimeBuilder? endTime) => _$this._endTime = endTime;

  num? _specificDate;
  num? get specificDate => _$this._specificDate;
  set specificDate(num? specificDate) => _$this._specificDate = specificDate;

  num? _createdAt;
  num? get createdAt => _$this._createdAt;
  set createdAt(num? createdAt) => _$this._createdAt = createdAt;

  num? _updatedAt;
  num? get updatedAt => _$this._updatedAt;
  set updatedAt(num? updatedAt) => _$this._updatedAt = updatedAt;

  bool? _isRecurring;
  bool? get isRecurring => _$this._isRecurring;
  set isRecurring(bool? isRecurring) => _$this._isRecurring = isRecurring;

  bool? _isActive;
  bool? get isActive => _$this._isActive;
  set isActive(bool? isActive) => _$this._isActive = isActive;

  ScheduleBuilder() {
    Schedule._defaults(this);
  }

  ScheduleBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _driverId = $v.driverId;
      _dayOfWeek = $v.dayOfWeek;
      _startTime = $v.startTime.toBuilder();
      _endTime = $v.endTime.toBuilder();
      _specificDate = $v.specificDate;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _isRecurring = $v.isRecurring;
      _isActive = $v.isActive;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Schedule other) {
    _$v = other as _$Schedule;
  }

  @override
  void update(void Function(ScheduleBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Schedule build() => _build();

  _$Schedule _build() {
    _$Schedule _$result;
    try {
      _$result = _$v ??
          _$Schedule._(
            id: BuiltValueNullFieldError.checkNotNull(id, r'Schedule', 'id'),
            driverId: BuiltValueNullFieldError.checkNotNull(
                driverId, r'Schedule', 'driverId'),
            dayOfWeek: BuiltValueNullFieldError.checkNotNull(
                dayOfWeek, r'Schedule', 'dayOfWeek'),
            startTime: startTime.build(),
            endTime: endTime.build(),
            specificDate: specificDate,
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'Schedule', 'createdAt'),
            updatedAt: BuiltValueNullFieldError.checkNotNull(
                updatedAt, r'Schedule', 'updatedAt'),
            isRecurring: isRecurring,
            isActive: isActive,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'startTime';
        startTime.build();
        _$failedField = 'endTime';
        endTime.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'Schedule', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
