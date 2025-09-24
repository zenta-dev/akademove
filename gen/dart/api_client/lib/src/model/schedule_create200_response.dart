//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/schedule.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'schedule_create200_response.g.dart';

/// ScheduleCreate200Response
///
/// Properties:
/// * [message] 
/// * [data] 
@BuiltValue()
abstract class ScheduleCreate200Response implements Built<ScheduleCreate200Response, ScheduleCreate200ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  String get message;

  @BuiltValueField(wireName: r'data')
  Schedule get data;

  ScheduleCreate200Response._();

  factory ScheduleCreate200Response([void updates(ScheduleCreate200ResponseBuilder b)]) = _$ScheduleCreate200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ScheduleCreate200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ScheduleCreate200Response> get serializer => _$ScheduleCreate200ResponseSerializer();
}

class _$ScheduleCreate200ResponseSerializer implements PrimitiveSerializer<ScheduleCreate200Response> {
  @override
  final Iterable<Type> types = const [ScheduleCreate200Response, _$ScheduleCreate200Response];

  @override
  final String wireName = r'ScheduleCreate200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ScheduleCreate200Response object, {
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
      specifiedType: const FullType(Schedule),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ScheduleCreate200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ScheduleCreate200ResponseBuilder result,
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
            specifiedType: const FullType(Schedule),
          ) as Schedule;
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
  ScheduleCreate200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ScheduleCreate200ResponseBuilder();
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

