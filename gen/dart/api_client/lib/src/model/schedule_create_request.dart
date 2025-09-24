//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/time.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'schedule_create_request.g.dart';

/// ScheduleCreateRequest
///
/// Properties:
/// * [driverId] 
/// * [dayOfWeek] 
/// * [startTime] 
/// * [endTime] 
/// * [isRecurring] 
/// * [specificDate] - unix timestamp format
/// * [isActive] 
@BuiltValue()
abstract class ScheduleCreateRequest implements Built<ScheduleCreateRequest, ScheduleCreateRequestBuilder> {
  @BuiltValueField(wireName: r'driverId')
  String get driverId;

  @BuiltValueField(wireName: r'dayOfWeek')
  ScheduleCreateRequestDayOfWeekEnum get dayOfWeek;
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

  ScheduleCreateRequest._();

  factory ScheduleCreateRequest([void updates(ScheduleCreateRequestBuilder b)]) = _$ScheduleCreateRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ScheduleCreateRequestBuilder b) => b
      ..isRecurring = true
      ..isActive = true;

  @BuiltValueSerializer(custom: true)
  static Serializer<ScheduleCreateRequest> get serializer => _$ScheduleCreateRequestSerializer();
}

class _$ScheduleCreateRequestSerializer implements PrimitiveSerializer<ScheduleCreateRequest> {
  @override
  final Iterable<Type> types = const [ScheduleCreateRequest, _$ScheduleCreateRequest];

  @override
  final String wireName = r'ScheduleCreateRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ScheduleCreateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'driverId';
    yield serializers.serialize(
      object.driverId,
      specifiedType: const FullType(String),
    );
    yield r'dayOfWeek';
    yield serializers.serialize(
      object.dayOfWeek,
      specifiedType: const FullType(ScheduleCreateRequestDayOfWeekEnum),
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
  }

  @override
  Object serialize(
    Serializers serializers,
    ScheduleCreateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ScheduleCreateRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
            specifiedType: const FullType(ScheduleCreateRequestDayOfWeekEnum),
          ) as ScheduleCreateRequestDayOfWeekEnum;
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ScheduleCreateRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ScheduleCreateRequestBuilder();
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

class ScheduleCreateRequestDayOfWeekEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'sunday')
  static const ScheduleCreateRequestDayOfWeekEnum sunday = _$scheduleCreateRequestDayOfWeekEnum_sunday;
  @BuiltValueEnumConst(wireName: r'monday')
  static const ScheduleCreateRequestDayOfWeekEnum monday = _$scheduleCreateRequestDayOfWeekEnum_monday;
  @BuiltValueEnumConst(wireName: r'tuesday')
  static const ScheduleCreateRequestDayOfWeekEnum tuesday = _$scheduleCreateRequestDayOfWeekEnum_tuesday;
  @BuiltValueEnumConst(wireName: r'wednesday')
  static const ScheduleCreateRequestDayOfWeekEnum wednesday = _$scheduleCreateRequestDayOfWeekEnum_wednesday;
  @BuiltValueEnumConst(wireName: r'thursday')
  static const ScheduleCreateRequestDayOfWeekEnum thursday = _$scheduleCreateRequestDayOfWeekEnum_thursday;
  @BuiltValueEnumConst(wireName: r'friday')
  static const ScheduleCreateRequestDayOfWeekEnum friday = _$scheduleCreateRequestDayOfWeekEnum_friday;
  @BuiltValueEnumConst(wireName: r'saturday')
  static const ScheduleCreateRequestDayOfWeekEnum saturday = _$scheduleCreateRequestDayOfWeekEnum_saturday;

  static Serializer<ScheduleCreateRequestDayOfWeekEnum> get serializer => _$scheduleCreateRequestDayOfWeekEnumSerializer;

  const ScheduleCreateRequestDayOfWeekEnum._(String name): super(name);

  static BuiltSet<ScheduleCreateRequestDayOfWeekEnum> get values => _$scheduleCreateRequestDayOfWeekEnumValues;
  static ScheduleCreateRequestDayOfWeekEnum valueOf(String name) => _$scheduleCreateRequestDayOfWeekEnumValueOf(name);
}

