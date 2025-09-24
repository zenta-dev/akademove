//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/schedule.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'schedule_list200_response.g.dart';

/// ScheduleList200Response
///
/// Properties:
/// * [message] 
/// * [data] 
@BuiltValue()
abstract class ScheduleList200Response implements Built<ScheduleList200Response, ScheduleList200ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  String get message;

  @BuiltValueField(wireName: r'data')
  BuiltList<Schedule> get data;

  ScheduleList200Response._();

  factory ScheduleList200Response([void updates(ScheduleList200ResponseBuilder b)]) = _$ScheduleList200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ScheduleList200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ScheduleList200Response> get serializer => _$ScheduleList200ResponseSerializer();
}

class _$ScheduleList200ResponseSerializer implements PrimitiveSerializer<ScheduleList200Response> {
  @override
  final Iterable<Type> types = const [ScheduleList200Response, _$ScheduleList200Response];

  @override
  final String wireName = r'ScheduleList200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ScheduleList200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(String),
    );
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(BuiltList, [FullType(Schedule)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ScheduleList200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ScheduleList200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.message = valueDes;
          break;
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(Schedule)]),
          ) as BuiltList<Schedule>;
          result.data.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ScheduleList200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ScheduleList200ResponseBuilder();
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

