//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/time.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_schedule_request.g.dart';

/// CreateScheduleRequest
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
abstract class CreateScheduleRequest implements Built<CreateScheduleRequest, CreateScheduleRequestBuilder> {
  @BuiltValueField(wireName: r'driverId')
  String get driverId;

  @BuiltValueField(wireName: r'dayOfWeek')
  CreateScheduleRequestDayOfWeekEnum get dayOfWeek;
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

  CreateScheduleRequest._();

  factory CreateScheduleRequest([void updates(CreateScheduleRequestBuilder b)]) = _$CreateScheduleRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateScheduleRequestBuilder b) => b
      ..isRecurring = true
      ..isActive = true;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateScheduleRequest> get serializer => _$CreateScheduleRequestSerializer();
}

class _$CreateScheduleRequestSerializer implements PrimitiveSerializer<CreateScheduleRequest> {
  @override
  final Iterable<Type> types = const [CreateScheduleRequest, _$CreateScheduleRequest];

  @override
  final String wireName = r'CreateScheduleRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateScheduleRequest object, {
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
      specifiedType: const FullType(CreateScheduleRequestDayOfWeekEnum),
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
    yield r'specificDate';
    yield object.specificDate == null ? null : serializers.serialize(
      object.specificDate,
      specifiedType: const FullType.nullable(num),
    );
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
    CreateScheduleRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateScheduleRequestBuilder result,
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
            specifiedType: const FullType(CreateScheduleRequestDayOfWeekEnum),
          ) as CreateScheduleRequestDayOfWeekEnum;
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
            specifiedType: const FullType.nullable(num),
          ) as num?;
          if (valueDes == null) continue;
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
  CreateScheduleRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateScheduleRequestBuilder();
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

class CreateScheduleRequestDayOfWeekEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'sunday')
  static const CreateScheduleRequestDayOfWeekEnum sunday = _$createScheduleRequestDayOfWeekEnum_sunday;
  @BuiltValueEnumConst(wireName: r'monday')
  static const CreateScheduleRequestDayOfWeekEnum monday = _$createScheduleRequestDayOfWeekEnum_monday;
  @BuiltValueEnumConst(wireName: r'tuesday')
  static const CreateScheduleRequestDayOfWeekEnum tuesday = _$createScheduleRequestDayOfWeekEnum_tuesday;
  @BuiltValueEnumConst(wireName: r'wednesday')
  static const CreateScheduleRequestDayOfWeekEnum wednesday = _$createScheduleRequestDayOfWeekEnum_wednesday;
  @BuiltValueEnumConst(wireName: r'thursday')
  static const CreateScheduleRequestDayOfWeekEnum thursday = _$createScheduleRequestDayOfWeekEnum_thursday;
  @BuiltValueEnumConst(wireName: r'friday')
  static const CreateScheduleRequestDayOfWeekEnum friday = _$createScheduleRequestDayOfWeekEnum_friday;
  @BuiltValueEnumConst(wireName: r'saturday')
  static const CreateScheduleRequestDayOfWeekEnum saturday = _$createScheduleRequestDayOfWeekEnum_saturday;

  static Serializer<CreateScheduleRequestDayOfWeekEnum> get serializer => _$createScheduleRequestDayOfWeekEnumSerializer;

  const CreateScheduleRequestDayOfWeekEnum._(String name): super(name);

  static BuiltSet<CreateScheduleRequestDayOfWeekEnum> get values => _$createScheduleRequestDayOfWeekEnumValues;
  static CreateScheduleRequestDayOfWeekEnum valueOf(String name) => _$createScheduleRequestDayOfWeekEnumValueOf(name);
}

