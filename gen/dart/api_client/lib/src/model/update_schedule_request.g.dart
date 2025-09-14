// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_schedule_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const UpdateScheduleRequestDayOfWeekEnum
_$updateScheduleRequestDayOfWeekEnum_sunday =
    const UpdateScheduleRequestDayOfWeekEnum._('sunday');
const UpdateScheduleRequestDayOfWeekEnum
_$updateScheduleRequestDayOfWeekEnum_monday =
    const UpdateScheduleRequestDayOfWeekEnum._('monday');
const UpdateScheduleRequestDayOfWeekEnum
_$updateScheduleRequestDayOfWeekEnum_tuesday =
    const UpdateScheduleRequestDayOfWeekEnum._('tuesday');
const UpdateScheduleRequestDayOfWeekEnum
_$updateScheduleRequestDayOfWeekEnum_wednesday =
    const UpdateScheduleRequestDayOfWeekEnum._('wednesday');
const UpdateScheduleRequestDayOfWeekEnum
_$updateScheduleRequestDayOfWeekEnum_thursday =
    const UpdateScheduleRequestDayOfWeekEnum._('thursday');
const UpdateScheduleRequestDayOfWeekEnum
_$updateScheduleRequestDayOfWeekEnum_friday =
    const UpdateScheduleRequestDayOfWeekEnum._('friday');
const UpdateScheduleRequestDayOfWeekEnum
_$updateScheduleRequestDayOfWeekEnum_saturday =
    const UpdateScheduleRequestDayOfWeekEnum._('saturday');

UpdateScheduleRequestDayOfWeekEnum _$updateScheduleRequestDayOfWeekEnumValueOf(
  String name,
) {
  switch (name) {
    case 'sunday':
      return _$updateScheduleRequestDayOfWeekEnum_sunday;
    case 'monday':
      return _$updateScheduleRequestDayOfWeekEnum_monday;
    case 'tuesday':
      return _$updateScheduleRequestDayOfWeekEnum_tuesday;
    case 'wednesday':
      return _$updateScheduleRequestDayOfWeekEnum_wednesday;
    case 'thursday':
      return _$updateScheduleRequestDayOfWeekEnum_thursday;
    case 'friday':
      return _$updateScheduleRequestDayOfWeekEnum_friday;
    case 'saturday':
      return _$updateScheduleRequestDayOfWeekEnum_saturday;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<UpdateScheduleRequestDayOfWeekEnum>
_$updateScheduleRequestDayOfWeekEnumValues =
    BuiltSet<UpdateScheduleRequestDayOfWeekEnum>(
      const <UpdateScheduleRequestDayOfWeekEnum>[
        _$updateScheduleRequestDayOfWeekEnum_sunday,
        _$updateScheduleRequestDayOfWeekEnum_monday,
        _$updateScheduleRequestDayOfWeekEnum_tuesday,
        _$updateScheduleRequestDayOfWeekEnum_wednesday,
        _$updateScheduleRequestDayOfWeekEnum_thursday,
        _$updateScheduleRequestDayOfWeekEnum_friday,
        _$updateScheduleRequestDayOfWeekEnum_saturday,
      ],
    );

Serializer<UpdateScheduleRequestDayOfWeekEnum>
_$updateScheduleRequestDayOfWeekEnumSerializer =
    _$UpdateScheduleRequestDayOfWeekEnumSerializer();

class _$UpdateScheduleRequestDayOfWeekEnumSerializer
    implements PrimitiveSerializer<UpdateScheduleRequestDayOfWeekEnum> {
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
  final Iterable<Type> types = const <Type>[UpdateScheduleRequestDayOfWeekEnum];
  @override
  final String wireName = 'UpdateScheduleRequestDayOfWeekEnum';

  @override
  Object serialize(
    Serializers serializers,
    UpdateScheduleRequestDayOfWeekEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  UpdateScheduleRequestDayOfWeekEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => UpdateScheduleRequestDayOfWeekEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$UpdateScheduleRequest extends UpdateScheduleRequest {
  @override
  final UpdateScheduleRequestDayOfWeekEnum dayOfWeek;
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

  factory _$UpdateScheduleRequest([
    void Function(UpdateScheduleRequestBuilder)? updates,
  ]) => (UpdateScheduleRequestBuilder()..update(updates))._build();

  _$UpdateScheduleRequest._({
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
    this.isRecurring,
    this.specificDate,
    this.isActive,
  }) : super._();
  @override
  UpdateScheduleRequest rebuild(
    void Function(UpdateScheduleRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UpdateScheduleRequestBuilder toBuilder() =>
      UpdateScheduleRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateScheduleRequest &&
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
    return (newBuiltValueToStringHelper(r'UpdateScheduleRequest')
          ..add('dayOfWeek', dayOfWeek)
          ..add('startTime', startTime)
          ..add('endTime', endTime)
          ..add('isRecurring', isRecurring)
          ..add('specificDate', specificDate)
          ..add('isActive', isActive))
        .toString();
  }
}

class UpdateScheduleRequestBuilder
    implements Builder<UpdateScheduleRequest, UpdateScheduleRequestBuilder> {
  _$UpdateScheduleRequest? _$v;

  UpdateScheduleRequestDayOfWeekEnum? _dayOfWeek;
  UpdateScheduleRequestDayOfWeekEnum? get dayOfWeek => _$this._dayOfWeek;
  set dayOfWeek(UpdateScheduleRequestDayOfWeekEnum? dayOfWeek) =>
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

  UpdateScheduleRequestBuilder() {
    UpdateScheduleRequest._defaults(this);
  }

  UpdateScheduleRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
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
  void replace(UpdateScheduleRequest other) {
    _$v = other as _$UpdateScheduleRequest;
  }

  @override
  void update(void Function(UpdateScheduleRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateScheduleRequest build() => _build();

  _$UpdateScheduleRequest _build() {
    _$UpdateScheduleRequest _$result;
    try {
      _$result =
          _$v ??
          _$UpdateScheduleRequest._(
            dayOfWeek: BuiltValueNullFieldError.checkNotNull(
              dayOfWeek,
              r'UpdateScheduleRequest',
              'dayOfWeek',
            ),
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
          r'UpdateScheduleRequest',
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
