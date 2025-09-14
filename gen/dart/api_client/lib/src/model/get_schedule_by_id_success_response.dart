//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/schedule.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'get_schedule_by_id_success_response.g.dart';

/// GetScheduleByIdSuccessResponse
///
/// Properties:
/// * [success] 
/// * [message] 
/// * [data] 
@BuiltValue()
abstract class GetScheduleByIdSuccessResponse implements Built<GetScheduleByIdSuccessResponse, GetScheduleByIdSuccessResponseBuilder> {
  @BuiltValueField(wireName: r'success')
  GetScheduleByIdSuccessResponseSuccessEnum get success;
  // enum successEnum {  true,  };

  @BuiltValueField(wireName: r'message')
  String get message;

  @BuiltValueField(wireName: r'data')
  Schedule get data;

  GetScheduleByIdSuccessResponse._();

  factory GetScheduleByIdSuccessResponse([void updates(GetScheduleByIdSuccessResponseBuilder b)]) = _$GetScheduleByIdSuccessResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GetScheduleByIdSuccessResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GetScheduleByIdSuccessResponse> get serializer => _$GetScheduleByIdSuccessResponseSerializer();
}

class _$GetScheduleByIdSuccessResponseSerializer implements PrimitiveSerializer<GetScheduleByIdSuccessResponse> {
  @override
  final Iterable<Type> types = const [GetScheduleByIdSuccessResponse, _$GetScheduleByIdSuccessResponse];

  @override
  final String wireName = r'GetScheduleByIdSuccessResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GetScheduleByIdSuccessResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'success';
    yield serializers.serialize(
      object.success,
      specifiedType: const FullType(GetScheduleByIdSuccessResponseSuccessEnum),
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
    GetScheduleByIdSuccessResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required GetScheduleByIdSuccessResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'success':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(GetScheduleByIdSuccessResponseSuccessEnum),
          ) as GetScheduleByIdSuccessResponseSuccessEnum;
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
  GetScheduleByIdSuccessResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GetScheduleByIdSuccessResponseBuilder();
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

class GetScheduleByIdSuccessResponseSuccessEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'true')
  static const GetScheduleByIdSuccessResponseSuccessEnum true_ = _$getScheduleByIdSuccessResponseSuccessEnum_true_;

  static Serializer<GetScheduleByIdSuccessResponseSuccessEnum> get serializer => _$getScheduleByIdSuccessResponseSuccessEnumSerializer;

  const GetScheduleByIdSuccessResponseSuccessEnum._(String name): super(name);

  static BuiltSet<GetScheduleByIdSuccessResponseSuccessEnum> get values => _$getScheduleByIdSuccessResponseSuccessEnumValues;
  static GetScheduleByIdSuccessResponseSuccessEnum valueOf(String name) => _$getScheduleByIdSuccessResponseSuccessEnumValueOf(name);
}

