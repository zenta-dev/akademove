//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/time.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'schedule_update_request.g.dart';

/// ScheduleUpdateRequest
///
/// Properties:
/// * [dayOfWeek] 
/// * [startTime] 
/// * [endTime] 
/// * [isRecurring] 
/// * [specificDate] - unix timestamp format
/// * [isActive] 
@BuiltValue()
abstract class ScheduleUpdateRequest implements Built<ScheduleUpdateRequest, ScheduleUpdateRequestBuilder> {
  @BuiltValueField(wireName: r'dayOfWeek')
  ScheduleUpdateRequestDayOfWeekEnum? get dayOfWeek;
  // enum dayOfWeekEnum {  sunday,  monday,  tuesday,  wednesday,  thursday,  friday,  saturday,  };

  @BuiltValueField(wireName: r'startTime')
  Time? get startTime;

  @BuiltValueField(wireName: r'endTime')
  Time? get endTime;

  @BuiltValueField(wireName: r'isRecurring')
  bool? get isRecurring;

  /// unix timestamp format
  @BuiltValueField(wireName: r'specificDate')
  num? get specificDate;

  @BuiltValueField(wireName: r'isActive')
  bool? get isActive;

  ScheduleUpdateRequest._();

  factory ScheduleUpdateRequest([void updates(ScheduleUpdateRequestBuilder b)]) = _$ScheduleUpdateRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ScheduleUpdateRequestBuilder b) => b
      ..isRecurring = true
      ..isActive = true;

  @BuiltValueSerializer(custom: true)
  static Serializer<ScheduleUpdateRequest> get serializer => _$ScheduleUpdateRequestSerializer();
}

class _$ScheduleUpdateRequestSerializer implements PrimitiveSerializer<ScheduleUpdateRequest> {
  @override
  final Iterable<Type> types = const [ScheduleUpdateRequest, _$ScheduleUpdateRequest];

  @override
  final String wireName = r'ScheduleUpdateRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ScheduleUpdateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.dayOfWeek != null) {
      yield r'dayOfWeek';
      yield serializers.serialize(
        object.dayOfWeek,
        specifiedType: const FullType(ScheduleUpdateRequestDayOfWeekEnum),
      );
    }
    if (object.startTime != null) {
      yield r'startTime';
      yield serializers.serialize(
        object.startTime,
        specifiedType: const FullType(Time),
      );
    }
    if (object.endTime != null) {
      yield r'endTime';
      yield serializers.serialize(
        object.endTime,
        specifiedType: const FullType(Time),
      );
    }
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
    ScheduleUpdateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ScheduleUpdateRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'dayOfWeek':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ScheduleUpdateRequestDayOfWeekEnum),
          ) as ScheduleUpdateRequestDayOfWeekEnum;
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
  ScheduleUpdateRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ScheduleUpdateRequestBuilder();
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

class ScheduleUpdateRequestDayOfWeekEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'sunday')
  static const ScheduleUpdateRequestDayOfWeekEnum sunday = _$scheduleUpdateRequestDayOfWeekEnum_sunday;
  @BuiltValueEnumConst(wireName: r'monday')
  static const ScheduleUpdateRequestDayOfWeekEnum monday = _$scheduleUpdateRequestDayOfWeekEnum_monday;
  @BuiltValueEnumConst(wireName: r'tuesday')
  static const ScheduleUpdateRequestDayOfWeekEnum tuesday = _$scheduleUpdateRequestDayOfWeekEnum_tuesday;
  @BuiltValueEnumConst(wireName: r'wednesday')
  static const ScheduleUpdateRequestDayOfWeekEnum wednesday = _$scheduleUpdateRequestDayOfWeekEnum_wednesday;
  @BuiltValueEnumConst(wireName: r'thursday')
  static const ScheduleUpdateRequestDayOfWeekEnum thursday = _$scheduleUpdateRequestDayOfWeekEnum_thursday;
  @BuiltValueEnumConst(wireName: r'friday')
  static const ScheduleUpdateRequestDayOfWeekEnum friday = _$scheduleUpdateRequestDayOfWeekEnum_friday;
  @BuiltValueEnumConst(wireName: r'saturday')
  static const ScheduleUpdateRequestDayOfWeekEnum saturday = _$scheduleUpdateRequestDayOfWeekEnum_saturday;

  static Serializer<ScheduleUpdateRequestDayOfWeekEnum> get serializer => _$scheduleUpdateRequestDayOfWeekEnumSerializer;

  const ScheduleUpdateRequestDayOfWeekEnum._(String name): super(name);

  static BuiltSet<ScheduleUpdateRequestDayOfWeekEnum> get values => _$scheduleUpdateRequestDayOfWeekEnumValues;
  static ScheduleUpdateRequestDayOfWeekEnum valueOf(String name) => _$scheduleUpdateRequestDayOfWeekEnumValueOf(name);
}

