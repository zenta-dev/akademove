// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_schedule_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const CreateScheduleRequestDayOfWeekEnum
    _$createScheduleRequestDayOfWeekEnum_sunday =
    const CreateScheduleRequestDayOfWeekEnum._('sunday');
const CreateScheduleRequestDayOfWeekEnum
    _$createScheduleRequestDayOfWeekEnum_monday =
    const CreateScheduleRequestDayOfWeekEnum._('monday');
const CreateScheduleRequestDayOfWeekEnum
    _$createScheduleRequestDayOfWeekEnum_tuesday =
    const CreateScheduleRequestDayOfWeekEnum._('tuesday');
const CreateScheduleRequestDayOfWeekEnum
    _$createScheduleRequestDayOfWeekEnum_wednesday =
    const CreateScheduleRequestDayOfWeekEnum._('wednesday');
const CreateScheduleRequestDayOfWeekEnum
    _$createScheduleRequestDayOfWeekEnum_thursday =
    const CreateScheduleRequestDayOfWeekEnum._('thursday');
const CreateScheduleRequestDayOfWeekEnum
    _$createScheduleRequestDayOfWeekEnum_friday =
    const CreateScheduleRequestDayOfWeekEnum._('friday');
const CreateScheduleRequestDayOfWeekEnum
    _$createScheduleRequestDayOfWeekEnum_saturday =
    const CreateScheduleRequestDayOfWeekEnum._('saturday');

CreateScheduleRequestDayOfWeekEnum _$createScheduleRequestDayOfWeekEnumValueOf(
    String name) {
  switch (name) {
    case 'sunday':
      return _$createScheduleRequestDayOfWeekEnum_sunday;
    case 'monday':
      return _$createScheduleRequestDayOfWeekEnum_monday;
    case 'tuesday':
      return _$createScheduleRequestDayOfWeekEnum_tuesday;
    case 'wednesday':
      return _$createScheduleRequestDayOfWeekEnum_wednesday;
    case 'thursday':
      return _$createScheduleRequestDayOfWeekEnum_thursday;
    case 'friday':
      return _$createScheduleRequestDayOfWeekEnum_friday;
    case 'saturday':
      return _$createScheduleRequestDayOfWeekEnum_saturday;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<CreateScheduleRequestDayOfWeekEnum>
    _$createScheduleRequestDayOfWeekEnumValues = BuiltSet<
        CreateScheduleRequestDayOfWeekEnum>(const <CreateScheduleRequestDayOfWeekEnum>[
  _$createScheduleRequestDayOfWeekEnum_sunday,
  _$createScheduleRequestDayOfWeekEnum_monday,
  _$createScheduleRequestDayOfWeekEnum_tuesday,
  _$createScheduleRequestDayOfWeekEnum_wednesday,
  _$createScheduleRequestDayOfWeekEnum_thursday,
  _$createScheduleRequestDayOfWeekEnum_friday,
  _$createScheduleRequestDayOfWeekEnum_saturday,
]);

Serializer<CreateScheduleRequestDayOfWeekEnum>
    _$createScheduleRequestDayOfWeekEnumSerializer =
    _$CreateScheduleRequestDayOfWeekEnumSerializer();

class _$CreateScheduleRequestDayOfWeekEnumSerializer
    implements PrimitiveSerializer<CreateScheduleRequestDayOfWeekEnum> {
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
  final Iterable<Type> types = const <Type>[CreateScheduleRequestDayOfWeekEnum];
  @override
  final String wireName = 'CreateScheduleRequestDayOfWeekEnum';

  @override
  Object serialize(
          Serializers serializers, CreateScheduleRequestDayOfWeekEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  CreateScheduleRequestDayOfWeekEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      CreateScheduleRequestDayOfWeekEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$CreateScheduleRequest extends CreateScheduleRequest {
  @override
  final String driverId;
  @override
  final CreateScheduleRequestDayOfWeekEnum dayOfWeek;
  @override
  final Time startTime;
  @override
  final Time endTime;
  @override
  final num? specificDate;
  @override
  final bool? isRecurring;
  @override
  final bool? isActive;

  factory _$CreateScheduleRequest(
          [void Function(CreateScheduleRequestBuilder)? updates]) =>
      (CreateScheduleRequestBuilder()..update(updates))._build();

  _$CreateScheduleRequest._(
      {required this.driverId,
      required this.dayOfWeek,
      required this.startTime,
      required this.endTime,
      this.specificDate,
      this.isRecurring,
      this.isActive})
      : super._();
  @override
  CreateScheduleRequest rebuild(
          void Function(CreateScheduleRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateScheduleRequestBuilder toBuilder() =>
      CreateScheduleRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateScheduleRequest &&
        driverId == other.driverId &&
        dayOfWeek == other.dayOfWeek &&
        startTime == other.startTime &&
        endTime == other.endTime &&
        specificDate == other.specificDate &&
        isRecurring == other.isRecurring &&
        isActive == other.isActive;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, driverId.hashCode);
    _$hash = $jc(_$hash, dayOfWeek.hashCode);
    _$hash = $jc(_$hash, startTime.hashCode);
    _$hash = $jc(_$hash, endTime.hashCode);
    _$hash = $jc(_$hash, specificDate.hashCode);
    _$hash = $jc(_$hash, isRecurring.hashCode);
    _$hash = $jc(_$hash, isActive.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateScheduleRequest')
          ..add('driverId', driverId)
          ..add('dayOfWeek', dayOfWeek)
          ..add('startTime', startTime)
          ..add('endTime', endTime)
          ..add('specificDate', specificDate)
          ..add('isRecurring', isRecurring)
          ..add('isActive', isActive))
        .toString();
  }
}

class CreateScheduleRequestBuilder
    implements Builder<CreateScheduleRequest, CreateScheduleRequestBuilder> {
  _$CreateScheduleRequest? _$v;

  String? _driverId;
  String? get driverId => _$this._driverId;
  set driverId(String? driverId) => _$this._driverId = driverId;

  CreateScheduleRequestDayOfWeekEnum? _dayOfWeek;
  CreateScheduleRequestDayOfWeekEnum? get dayOfWeek => _$this._dayOfWeek;
  set dayOfWeek(CreateScheduleRequestDayOfWeekEnum? dayOfWeek) =>
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

  bool? _isRecurring;
  bool? get isRecurring => _$this._isRecurring;
  set isRecurring(bool? isRecurring) => _$this._isRecurring = isRecurring;

  bool? _isActive;
  bool? get isActive => _$this._isActive;
  set isActive(bool? isActive) => _$this._isActive = isActive;

  CreateScheduleRequestBuilder() {
    CreateScheduleRequest._defaults(this);
  }

  CreateScheduleRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _driverId = $v.driverId;
      _dayOfWeek = $v.dayOfWeek;
      _startTime = $v.startTime.toBuilder();
      _endTime = $v.endTime.toBuilder();
      _specificDate = $v.specificDate;
      _isRecurring = $v.isRecurring;
      _isActive = $v.isActive;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateScheduleRequest other) {
    _$v = other as _$CreateScheduleRequest;
  }

  @override
  void update(void Function(CreateScheduleRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateScheduleRequest build() => _build();

  _$CreateScheduleRequest _build() {
    _$CreateScheduleRequest _$result;
    try {
      _$result = _$v ??
          _$CreateScheduleRequest._(
            driverId: BuiltValueNullFieldError.checkNotNull(
                driverId, r'CreateScheduleRequest', 'driverId'),
            dayOfWeek: BuiltValueNullFieldError.checkNotNull(
                dayOfWeek, r'CreateScheduleRequest', 'dayOfWeek'),
            startTime: startTime.build(),
            endTime: endTime.build(),
            specificDate: specificDate,
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
            r'CreateScheduleRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
