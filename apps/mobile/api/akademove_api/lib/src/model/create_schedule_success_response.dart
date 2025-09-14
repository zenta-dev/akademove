//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:akademove_api/src/model/schedule.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_schedule_success_response.g.dart';

/// CreateScheduleSuccessResponse
///
/// Properties:
/// * [success]
/// * [message]
/// * [data]
@BuiltValue()
abstract class CreateScheduleSuccessResponse
    implements
        Built<CreateScheduleSuccessResponse,
            CreateScheduleSuccessResponseBuilder> {
  @BuiltValueField(wireName: r'success')
  CreateScheduleSuccessResponseSuccessEnum get success;
  // enum successEnum {  true,  };

  @BuiltValueField(wireName: r'message')
  String get message;

  @BuiltValueField(wireName: r'data')
  Schedule get data;

  CreateScheduleSuccessResponse._();

  factory CreateScheduleSuccessResponse(
          [void updates(CreateScheduleSuccessResponseBuilder b)]) =
      _$CreateScheduleSuccessResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateScheduleSuccessResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateScheduleSuccessResponse> get serializer =>
      _$CreateScheduleSuccessResponseSerializer();
}

class _$CreateScheduleSuccessResponseSerializer
    implements PrimitiveSerializer<CreateScheduleSuccessResponse> {
  @override
  final Iterable<Type> types = const [
    CreateScheduleSuccessResponse,
    _$CreateScheduleSuccessResponse
  ];

  @override
  final String wireName = r'CreateScheduleSuccessResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateScheduleSuccessResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'success';
    yield serializers.serialize(
      object.success,
      specifiedType: const FullType(CreateScheduleSuccessResponseSuccessEnum),
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
    CreateScheduleSuccessResponse object, {
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
    required CreateScheduleSuccessResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'success':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(CreateScheduleSuccessResponseSuccessEnum),
          ) as CreateScheduleSuccessResponseSuccessEnum;
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
  CreateScheduleSuccessResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateScheduleSuccessResponseBuilder();
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

class CreateScheduleSuccessResponseSuccessEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'true')
  static const CreateScheduleSuccessResponseSuccessEnum true_ =
      _$createScheduleSuccessResponseSuccessEnum_true_;

  static Serializer<CreateScheduleSuccessResponseSuccessEnum> get serializer =>
      _$createScheduleSuccessResponseSuccessEnumSerializer;

  const CreateScheduleSuccessResponseSuccessEnum._(String name) : super(name);

  static BuiltSet<CreateScheduleSuccessResponseSuccessEnum> get values =>
      _$createScheduleSuccessResponseSuccessEnumValues;
  static CreateScheduleSuccessResponseSuccessEnum valueOf(String name) =>
      _$createScheduleSuccessResponseSuccessEnumValueOf(name);
}
