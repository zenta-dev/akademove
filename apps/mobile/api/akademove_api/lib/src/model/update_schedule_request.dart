//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:akademove_api/src/model/time.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_schedule_request.g.dart';

/// UpdateScheduleRequest
///
/// Properties:
/// * [dayOfWeek]
/// * [startTime]
/// * [endTime]
/// * [specificDate] - unix timestamp format
/// * [isRecurring]
/// * [isActive]
@BuiltValue()
abstract class UpdateScheduleRequest
    implements Built<UpdateScheduleRequest, UpdateScheduleRequestBuilder> {
  @BuiltValueField(wireName: r'dayOfWeek')
  UpdateScheduleRequestDayOfWeekEnum get dayOfWeek;
  // enum dayOfWeekEnum {  sunday,  monday,  tuesday,  wednesday,  thursday,  friday,  saturday,  };

  @BuiltValueField(wireName: r'startTime')
  Time get startTime;

  @BuiltValueField(wireName: r'endTime')
  Time get endTime;

  /// unix timestamp format
  @BuiltValueField(wireName: r'specificDate')
  num? get specificDate;

  @BuiltValueField(wireName: r'isRecurring')
  bool? get isRecurring;

  @BuiltValueField(wireName: r'isActive')
  bool? get isActive;

  UpdateScheduleRequest._();

  factory UpdateScheduleRequest(
      [void updates(UpdateScheduleRequestBuilder b)]) = _$UpdateScheduleRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateScheduleRequestBuilder b) => b
    ..isRecurring = true
    ..isActive = true;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateScheduleRequest> get serializer =>
      _$UpdateScheduleRequestSerializer();
}

class _$UpdateScheduleRequestSerializer
    implements PrimitiveSerializer<UpdateScheduleRequest> {
  @override
  final Iterable<Type> types = const [
    UpdateScheduleRequest,
    _$UpdateScheduleRequest
  ];

  @override
  final String wireName = r'UpdateScheduleRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateScheduleRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'dayOfWeek';
    yield serializers.serialize(
      object.dayOfWeek,
      specifiedType: const FullType(UpdateScheduleRequestDayOfWeekEnum),
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
    yield r'specificDate';
    yield object.specificDate == null
        ? null
        : serializers.serialize(
            object.specificDate,
            specifiedType: const FullType.nullable(num),
          );
    if (object.isRecurring != null) {
      yield r'isRecurring';
      yield serializers.serialize(
        object.isRecurring,
        specifiedType: const FullType(bool),
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
    UpdateScheduleRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object,
            specifiedType: specifiedType)
        .toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UpdateScheduleRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'dayOfWeek':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(UpdateScheduleRequestDayOfWeekEnum),
          ) as UpdateScheduleRequestDayOfWeekEnum;
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
        case r'specificDate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(num),
          ) as num?;
          if (valueDes == null) continue;
          result.specificDate = valueDes;
          break;
        case r'isRecurring':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isRecurring = valueDes;
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
  UpdateScheduleRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateScheduleRequestBuilder();
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

class UpdateScheduleRequestDayOfWeekEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'sunday')
  static const UpdateScheduleRequestDayOfWeekEnum sunday =
      _$updateScheduleRequestDayOfWeekEnum_sunday;
  @BuiltValueEnumConst(wireName: r'monday')
  static const UpdateScheduleRequestDayOfWeekEnum monday =
      _$updateScheduleRequestDayOfWeekEnum_monday;
  @BuiltValueEnumConst(wireName: r'tuesday')
  static const UpdateScheduleRequestDayOfWeekEnum tuesday =
      _$updateScheduleRequestDayOfWeekEnum_tuesday;
  @BuiltValueEnumConst(wireName: r'wednesday')
  static const UpdateScheduleRequestDayOfWeekEnum wednesday =
      _$updateScheduleRequestDayOfWeekEnum_wednesday;
  @BuiltValueEnumConst(wireName: r'thursday')
  static const UpdateScheduleRequestDayOfWeekEnum thursday =
      _$updateScheduleRequestDayOfWeekEnum_thursday;
  @BuiltValueEnumConst(wireName: r'friday')
  static const UpdateScheduleRequestDayOfWeekEnum friday =
      _$updateScheduleRequestDayOfWeekEnum_friday;
  @BuiltValueEnumConst(wireName: r'saturday')
  static const UpdateScheduleRequestDayOfWeekEnum saturday =
      _$updateScheduleRequestDayOfWeekEnum_saturday;

  static Serializer<UpdateScheduleRequestDayOfWeekEnum> get serializer =>
      _$updateScheduleRequestDayOfWeekEnumSerializer;

  const UpdateScheduleRequestDayOfWeekEnum._(String name) : super(name);

  static BuiltSet<UpdateScheduleRequestDayOfWeekEnum> get values =>
      _$updateScheduleRequestDayOfWeekEnumValues;
  static UpdateScheduleRequestDayOfWeekEnum valueOf(String name) =>
      _$updateScheduleRequestDayOfWeekEnumValueOf(name);
}
