//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/schedule.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_schedule_success_response.g.dart';

/// UpdateScheduleSuccessResponse
///
/// Properties:
/// * [success] 
/// * [message] 
/// * [data] 
@BuiltValue()
abstract class UpdateScheduleSuccessResponse implements Built<UpdateScheduleSuccessResponse, UpdateScheduleSuccessResponseBuilder> {
  @BuiltValueField(wireName: r'success')
  UpdateScheduleSuccessResponseSuccessEnum get success;
  // enum successEnum {  true,  };

  @BuiltValueField(wireName: r'message')
  String get message;

  @BuiltValueField(wireName: r'data')
  Schedule get data;

  UpdateScheduleSuccessResponse._();

  factory UpdateScheduleSuccessResponse([void updates(UpdateScheduleSuccessResponseBuilder b)]) = _$UpdateScheduleSuccessResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateScheduleSuccessResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateScheduleSuccessResponse> get serializer => _$UpdateScheduleSuccessResponseSerializer();
}

class _$UpdateScheduleSuccessResponseSerializer implements PrimitiveSerializer<UpdateScheduleSuccessResponse> {
  @override
  final Iterable<Type> types = const [UpdateScheduleSuccessResponse, _$UpdateScheduleSuccessResponse];

  @override
  final String wireName = r'UpdateScheduleSuccessResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateScheduleSuccessResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'success';
    yield serializers.serialize(
      object.success,
      specifiedType: const FullType(UpdateScheduleSuccessResponseSuccessEnum),
    );
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
    UpdateScheduleSuccessResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UpdateScheduleSuccessResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'success':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(UpdateScheduleSuccessResponseSuccessEnum),
          ) as UpdateScheduleSuccessResponseSuccessEnum;
          result.success = valueDes;
          break;
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
  UpdateScheduleSuccessResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateScheduleSuccessResponseBuilder();
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

class UpdateScheduleSuccessResponseSuccessEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'true')
  static const UpdateScheduleSuccessResponseSuccessEnum true_ = _$updateScheduleSuccessResponseSuccessEnum_true_;

  static Serializer<UpdateScheduleSuccessResponseSuccessEnum> get serializer => _$updateScheduleSuccessResponseSuccessEnumSerializer;

  const UpdateScheduleSuccessResponseSuccessEnum._(String name): super(name);

  static BuiltSet<UpdateScheduleSuccessResponseSuccessEnum> get values => _$updateScheduleSuccessResponseSuccessEnumValues;
  static UpdateScheduleSuccessResponseSuccessEnum valueOf(String name) => _$updateScheduleSuccessResponseSuccessEnumValueOf(name);
}

