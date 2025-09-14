//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/schedule.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'get_all_schedule_success_response.g.dart';

/// GetAllScheduleSuccessResponse
///
/// Properties:
/// * [success] 
/// * [message] 
/// * [data] 
@BuiltValue()
abstract class GetAllScheduleSuccessResponse implements Built<GetAllScheduleSuccessResponse, GetAllScheduleSuccessResponseBuilder> {
  @BuiltValueField(wireName: r'success')
  GetAllScheduleSuccessResponseSuccessEnum get success;
  // enum successEnum {  true,  };

  @BuiltValueField(wireName: r'message')
  String get message;

  @BuiltValueField(wireName: r'data')
  BuiltList<Schedule> get data;

  GetAllScheduleSuccessResponse._();

  factory GetAllScheduleSuccessResponse([void updates(GetAllScheduleSuccessResponseBuilder b)]) = _$GetAllScheduleSuccessResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GetAllScheduleSuccessResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GetAllScheduleSuccessResponse> get serializer => _$GetAllScheduleSuccessResponseSerializer();
}

class _$GetAllScheduleSuccessResponseSerializer implements PrimitiveSerializer<GetAllScheduleSuccessResponse> {
  @override
  final Iterable<Type> types = const [GetAllScheduleSuccessResponse, _$GetAllScheduleSuccessResponse];

  @override
  final String wireName = r'GetAllScheduleSuccessResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GetAllScheduleSuccessResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'success';
    yield serializers.serialize(
      object.success,
      specifiedType: const FullType(GetAllScheduleSuccessResponseSuccessEnum),
    );
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
    GetAllScheduleSuccessResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required GetAllScheduleSuccessResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'success':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(GetAllScheduleSuccessResponseSuccessEnum),
          ) as GetAllScheduleSuccessResponseSuccessEnum;
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
  GetAllScheduleSuccessResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GetAllScheduleSuccessResponseBuilder();
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

class GetAllScheduleSuccessResponseSuccessEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'true')
  static const GetAllScheduleSuccessResponseSuccessEnum true_ = _$getAllScheduleSuccessResponseSuccessEnum_true_;

  static Serializer<GetAllScheduleSuccessResponseSuccessEnum> get serializer => _$getAllScheduleSuccessResponseSuccessEnumSerializer;

  const GetAllScheduleSuccessResponseSuccessEnum._(String name): super(name);

  static BuiltSet<GetAllScheduleSuccessResponseSuccessEnum> get values => _$getAllScheduleSuccessResponseSuccessEnumValues;
  static GetAllScheduleSuccessResponseSuccessEnum valueOf(String name) => _$getAllScheduleSuccessResponseSuccessEnumValueOf(name);
}

