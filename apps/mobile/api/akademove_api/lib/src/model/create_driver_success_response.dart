//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:akademove_api/src/model/driver.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_driver_success_response.g.dart';

/// CreateDriverSuccessResponse
///
/// Properties:
/// * [success]
/// * [message]
/// * [data]
@BuiltValue()
abstract class CreateDriverSuccessResponse
    implements
        Built<CreateDriverSuccessResponse, CreateDriverSuccessResponseBuilder> {
  @BuiltValueField(wireName: r'success')
  CreateDriverSuccessResponseSuccessEnum get success;
  // enum successEnum {  true,  };

  @BuiltValueField(wireName: r'message')
  String get message;

  @BuiltValueField(wireName: r'data')
  Driver get data;

  CreateDriverSuccessResponse._();

  factory CreateDriverSuccessResponse(
          [void updates(CreateDriverSuccessResponseBuilder b)]) =
      _$CreateDriverSuccessResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateDriverSuccessResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateDriverSuccessResponse> get serializer =>
      _$CreateDriverSuccessResponseSerializer();
}

class _$CreateDriverSuccessResponseSerializer
    implements PrimitiveSerializer<CreateDriverSuccessResponse> {
  @override
  final Iterable<Type> types = const [
    CreateDriverSuccessResponse,
    _$CreateDriverSuccessResponse
  ];

  @override
  final String wireName = r'CreateDriverSuccessResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateDriverSuccessResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'success';
    yield serializers.serialize(
      object.success,
      specifiedType: const FullType(CreateDriverSuccessResponseSuccessEnum),
    );
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(String),
    );
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(Driver),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateDriverSuccessResponse object, {
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
    required CreateDriverSuccessResponseBuilder result,
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
                const FullType(CreateDriverSuccessResponseSuccessEnum),
          ) as CreateDriverSuccessResponseSuccessEnum;
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
            specifiedType: const FullType(Driver),
          ) as Driver;
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
  CreateDriverSuccessResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateDriverSuccessResponseBuilder();
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

class CreateDriverSuccessResponseSuccessEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'true')
  static const CreateDriverSuccessResponseSuccessEnum true_ =
      _$createDriverSuccessResponseSuccessEnum_true_;

  static Serializer<CreateDriverSuccessResponseSuccessEnum> get serializer =>
      _$createDriverSuccessResponseSuccessEnumSerializer;

  const CreateDriverSuccessResponseSuccessEnum._(String name) : super(name);

  static BuiltSet<CreateDriverSuccessResponseSuccessEnum> get values =>
      _$createDriverSuccessResponseSuccessEnumValues;
  static CreateDriverSuccessResponseSuccessEnum valueOf(String name) =>
      _$createDriverSuccessResponseSuccessEnumValueOf(name);
}
