//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/time.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'schedule.g.dart';

/// Schedule
///
/// Properties:
/// * [id] 
/// * [driverId] 
/// * [dayOfWeek] 
/// * [startTime] 
/// * [endTime] 
/// * [isRecurring] 
/// * [specificDate] - unix timestamp format
/// * [isActive] 
/// * [createdAt] - unix timestamp format
/// * [updatedAt] - unix timestamp format
@BuiltValue()
abstract class Schedule implements Built<Schedule, ScheduleBuilder> {
  @BuiltValueField(wireName: r'id')
  String get id;

  @BuiltValueField(wireName: r'driverId')
  String get driverId;

  @BuiltValueField(wireName: r'dayOfWeek')
  ScheduleDayOfWeekEnum get dayOfWeek;
  // enum dayOfWeekEnum {  sunday,  monday,  tuesday,  wednesday,  thursday,  friday,  saturday,  };

  @BuiltValueField(wireName: r'startTime')
  Time get startTime;

  @BuiltValueField(wireName: r'endTime')
  Time get endTime;

  @BuiltValueField(wireName: r'isRecurring')
  bool? get isRecurring;

  /// unix timestamp format
  @BuiltValueField(wireName: r'specificDate')
  num? get specificDate;

  @BuiltValueField(wireName: r'isActive')
  bool? get isActive;

  /// unix timestamp format
  @BuiltValueField(wireName: r'createdAt')
  num get createdAt;

  /// unix timestamp format
  @BuiltValueField(wireName: r'updatedAt')
  num get updatedAt;

  Schedule._();

  factory Schedule([void updates(ScheduleBuilder b)]) = _$Schedule;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ScheduleBuilder b) => b
      ..isRecurring = true
      ..isActive = true;

  @BuiltValueSerializer(custom: true)
  static Serializer<Schedule> get serializer => _$ScheduleSerializer();
}

class _$ScheduleSerializer implements PrimitiveSerializer<Schedule> {
  @override
  final Iterable<Type> types = const [Schedule, _$Schedule];

  @override
  final String wireName = r'Schedule';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Schedule object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
    yield r'driverId';
    yield serializers.serialize(
      object.driverId,
      specifiedType: const FullType(String),
    );
    yield r'dayOfWeek';
    yield serializers.serialize(
      object.dayOfWeek,
      specifiedType: const FullType(ScheduleDayOfWeekEnum),
    );
    yield r'startTime';
    yield serializers.serialize(
      object.startTime,
      specifiedType: const FullType(Time),
    );
    yield r'endTime';
    yield serializers.serialize(
      object.endTime,
      specifiedType: const FullType(Time),
    );
    if (object.isRecurring != null) {
      yield r'isRecurring';
      yield serializers.serialize(
        object.isRecurring,
        specifiedType: const FullType(bool),
      );
    }
    if (object.specificDate != null) {
      yield r'specificDate';
      yield serializers.serialize(
        object.specificDate,
        specifiedType: const FullType(num),
      );
    }
    if (object.isActive != null) {
      yield r'isActive';
      yield serializers.serialize(
        object.isActive,
        specifiedType: const FullType(bool),
      );
    }
    yield r'createdAt';
    yield serializers.serialize(
      object.createdAt,
      specifiedType: const FullType(num),
    );
    yield r'updatedAt';
    yield serializers.serialize(
      object.updatedAt,
      specifiedType: const FullType(num),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Schedule object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ScheduleBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.id = valueDes;
          break;
        case r'driverId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.driverId = valueDes;
          break;
        case r'dayOfWeek':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ScheduleDayOfWeekEnum),
          ) as ScheduleDayOfWeekEnum;
          result.dayOfWeek = valueDes;
          break;
        case r'startTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Time),
          ) as Time;
          result.startTime.replace(valueDes);
          break;
        case r'endTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Time),
          ) as Time;
          result.endTime.replace(valueDes);
          break;
        case r'isRecurring':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isRecurring = valueDes;
          break;
        case r'specificDate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.specificDate = valueDes;
          break;
        case r'isActive':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isActive = valueDes;
          break;
        case r'createdAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.createdAt = valueDes;
          break;
        case r'updatedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.updatedAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Schedule deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ScheduleBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}

class ScheduleDayOfWeekEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'sunday')
  static const ScheduleDayOfWeekEnum sunday = _$scheduleDayOfWeekEnum_sunday;
  @BuiltValueEnumConst(wireName: r'monday')
  static const ScheduleDayOfWeekEnum monday = _$scheduleDayOfWeekEnum_monday;
  @BuiltValueEnumConst(wireName: r'tuesday')
  static const ScheduleDayOfWeekEnum tuesday = _$scheduleDayOfWeekEnum_tuesday;
  @BuiltValueEnumConst(wireName: r'wednesday')
  static const ScheduleDayOfWeekEnum wednesday = _$scheduleDayOfWeekEnum_wednesday;
  @BuiltValueEnumConst(wireName: r'thursday')
  static const ScheduleDayOfWeekEnum thursday = _$scheduleDayOfWeekEnum_thursday;
  @BuiltValueEnumConst(wireName: r'friday')
  static const ScheduleDayOfWeekEnum friday = _$scheduleDayOfWeekEnum_friday;
  @BuiltValueEnumConst(wireName: r'saturday')
  static const ScheduleDayOfWeekEnum saturday = _$scheduleDayOfWeekEnum_saturday;

  static Serializer<ScheduleDayOfWeekEnum> get serializer => _$scheduleDayOfWeekEnumSerializer;

  const ScheduleDayOfWeekEnum._(String name): super(name);

  static BuiltSet<ScheduleDayOfWeekEnum> get values => _$scheduleDayOfWeekEnumValues;
  static ScheduleDayOfWeekEnum valueOf(String name) => _$scheduleDayOfWeekEnumValueOf(name);
}

