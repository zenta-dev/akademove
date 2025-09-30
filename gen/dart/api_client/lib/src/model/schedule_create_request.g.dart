// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_create_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ScheduleCreateRequestDayOfWeekEnum
_$scheduleCreateRequestDayOfWeekEnum_sunday =
    const ScheduleCreateRequestDayOfWeekEnum._('sunday');
const ScheduleCreateRequestDayOfWeekEnum
_$scheduleCreateRequestDayOfWeekEnum_monday =
    const ScheduleCreateRequestDayOfWeekEnum._('monday');
const ScheduleCreateRequestDayOfWeekEnum
_$scheduleCreateRequestDayOfWeekEnum_tuesday =
    const ScheduleCreateRequestDayOfWeekEnum._('tuesday');
const ScheduleCreateRequestDayOfWeekEnum
_$scheduleCreateRequestDayOfWeekEnum_wednesday =
    const ScheduleCreateRequestDayOfWeekEnum._('wednesday');
const ScheduleCreateRequestDayOfWeekEnum
_$scheduleCreateRequestDayOfWeekEnum_thursday =
    const ScheduleCreateRequestDayOfWeekEnum._('thursday');
const ScheduleCreateRequestDayOfWeekEnum
_$scheduleCreateRequestDayOfWeekEnum_friday =
    const ScheduleCreateRequestDayOfWeekEnum._('friday');
const ScheduleCreateRequestDayOfWeekEnum
_$scheduleCreateRequestDayOfWeekEnum_saturday =
    const ScheduleCreateRequestDayOfWeekEnum._('saturday');

ScheduleCreateRequestDayOfWeekEnum _$scheduleCreateRequestDayOfWeekEnumValueOf(
  String name,
) {
  switch (name) {
    case 'sunday':
      return _$scheduleCreateRequestDayOfWeekEnum_sunday;
    case 'monday':
      return _$scheduleCreateRequestDayOfWeekEnum_monday;
    case 'tuesday':
      return _$scheduleCreateRequestDayOfWeekEnum_tuesday;
    case 'wednesday':
      return _$scheduleCreateRequestDayOfWeekEnum_wednesday;
    case 'thursday':
      return _$scheduleCreateRequestDayOfWeekEnum_thursday;
    case 'friday':
      return _$scheduleCreateRequestDayOfWeekEnum_friday;
    case 'saturday':
      return _$scheduleCreateRequestDayOfWeekEnum_saturday;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<ScheduleCreateRequestDayOfWeekEnum>
_$scheduleCreateRequestDayOfWeekEnumValues =
    BuiltSet<ScheduleCreateRequestDayOfWeekEnum>(
      const <ScheduleCreateRequestDayOfWeekEnum>[
        _$scheduleCreateRequestDayOfWeekEnum_sunday,
        _$scheduleCreateRequestDayOfWeekEnum_monday,
        _$scheduleCreateRequestDayOfWeekEnum_tuesday,
        _$scheduleCreateRequestDayOfWeekEnum_wednesday,
        _$scheduleCreateRequestDayOfWeekEnum_thursday,
        _$scheduleCreateRequestDayOfWeekEnum_friday,
        _$scheduleCreateRequestDayOfWeekEnum_saturday,
      ],
    );

Serializer<ScheduleCreateRequestDayOfWeekEnum>
_$scheduleCreateRequestDayOfWeekEnumSerializer =
    _$ScheduleCreateRequestDayOfWeekEnumSerializer();

class _$ScheduleCreateRequestDayOfWeekEnumSerializer
    implements PrimitiveSerializer<ScheduleCreateRequestDayOfWeekEnum> {
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
  final Iterable<Type> types = const <Type>[ScheduleCreateRequestDayOfWeekEnum];
  @override
  final String wireName = 'ScheduleCreateRequestDayOfWeekEnum';

  @override
  Object serialize(
    Serializers serializers,
    ScheduleCreateRequestDayOfWeekEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  ScheduleCreateRequestDayOfWeekEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => ScheduleCreateRequestDayOfWeekEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$ScheduleCreateRequest extends ScheduleCreateRequest {
  @override
  final String driverId;
  @override
  final ScheduleCreateRequestDayOfWeekEnum? dayOfWeek;
  @override
  final Time startTime;
  @override
  final Time endTime;
  @override
  final bool? isRecurring;
  @override
  final num? specificDate;
  @override
  final bool? isActive;

  factory _$ScheduleCreateRequest([
    void Function(ScheduleCreateRequestBuilder)? updates,
  ]) => (ScheduleCreateRequestBuilder()..update(updates))._build();

  _$ScheduleCreateRequest._({
    required this.driverId,
    this.dayOfWeek,
    required this.startTime,
    required this.endTime,
    this.isRecurring,
    this.specificDate,
    this.isActive,
  }) : super._();
  @override
  ScheduleCreateRequest rebuild(
    void Function(ScheduleCreateRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ScheduleCreateRequestBuilder toBuilder() =>
      ScheduleCreateRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ScheduleCreateRequest &&
        driverId == other.driverId &&
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
    _$hash = $jc(_$hash, driverId.hashCode);
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
    return (newBuiltValueToStringHelper(r'ScheduleCreateRequest')
          ..add('driverId', driverId)
          ..add('dayOfWeek', dayOfWeek)
          ..add('startTime', startTime)
          ..add('endTime', endTime)
          ..add('isRecurring', isRecurring)
          ..add('specificDate', specificDate)
          ..add('isActive', isActive))
        .toString();
  }
}

class ScheduleCreateRequestBuilder
    implements Builder<ScheduleCreateRequest, ScheduleCreateRequestBuilder> {
  _$ScheduleCreateRequest? _$v;

  String? _driverId;
  String? get driverId => _$this._driverId;
  set driverId(String? driverId) => _$this._driverId = driverId;

  ScheduleCreateRequestDayOfWeekEnum? _dayOfWeek;
  ScheduleCreateRequestDayOfWeekEnum? get dayOfWeek => _$this._dayOfWeek;
  set dayOfWeek(ScheduleCreateRequestDayOfWeekEnum? dayOfWeek) =>
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

  ScheduleCreateRequestBuilder() {
    ScheduleCreateRequest._defaults(this);
  }

  ScheduleCreateRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _driverId = $v.driverId;
      _dayOfWeek = $v.dayOfWeek;
      _startTime = $v.startTime.toBuilder();
      _endTime = $v.endTime.toBuilder();
      _isRecurring = $v.isRecurring;
      _specificDate = $v.specificDate;
      _isActive = $v.isActive;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ScheduleCreateRequest other) {
    _$v = other as _$ScheduleCreateRequest;
  }

  @override
  void update(void Function(ScheduleCreateRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ScheduleCreateRequest build() => _build();

  _$ScheduleCreateRequest _build() {
    _$ScheduleCreateRequest _$result;
    try {
      _$result =
          _$v ??
          _$ScheduleCreateRequest._(
            driverId: BuiltValueNullFieldError.checkNotNull(
              driverId,
              r'ScheduleCreateRequest',
              'driverId',
            ),
            dayOfWeek: dayOfWeek,
            startTime: startTime.build(),
            endTime: endTime.build(),
            isRecurring: isRecurring,
            specificDate: specificDate,
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
          r'ScheduleCreateRequest',
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
