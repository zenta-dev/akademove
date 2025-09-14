//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:akademove_api/src/model/driver.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'get_driver_by_id_success_response.g.dart';

/// GetDriverByIdSuccessResponse
///
/// Properties:
/// * [success]
/// * [message]
/// * [data]
@BuiltValue()
abstract class GetDriverByIdSuccessResponse
    implements
        Built<GetDriverByIdSuccessResponse,
            GetDriverByIdSuccessResponseBuilder> {
  @BuiltValueField(wireName: r'success')
  GetDriverByIdSuccessResponseSuccessEnum get success;
  // enum successEnum {  true,  };

  @BuiltValueField(wireName: r'message')
  String get message;

  @BuiltValueField(wireName: r'data')
  Driver get data;

  GetDriverByIdSuccessResponse._();

  factory GetDriverByIdSuccessResponse(
          [void updates(GetDriverByIdSuccessResponseBuilder b)]) =
      _$GetDriverByIdSuccessResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GetDriverByIdSuccessResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GetDriverByIdSuccessResponse> get serializer =>
      _$GetDriverByIdSuccessResponseSerializer();
}

class _$GetDriverByIdSuccessResponseSerializer
    implements PrimitiveSerializer<GetDriverByIdSuccessResponse> {
  @override
  final Iterable<Type> types = const [
    GetDriverByIdSuccessResponse,
    _$GetDriverByIdSuccessResponse
  ];

  @override
  final String wireName = r'GetDriverByIdSuccessResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GetDriverByIdSuccessResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'success';
    yield serializers.serialize(
      object.success,
      specifiedType: const FullType(GetDriverByIdSuccessResponseSuccessEnum),
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
    GetDriverByIdSuccessResponse object, {
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
    required GetDriverByIdSuccessResponseBuilder result,
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
                const FullType(GetDriverByIdSuccessResponseSuccessEnum),
          ) as GetDriverByIdSuccessResponseSuccessEnum;
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
  GetDriverByIdSuccessResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GetDriverByIdSuccessResponseBuilder();
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

class GetDriverByIdSuccessResponseSuccessEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'true')
  static const GetDriverByIdSuccessResponseSuccessEnum true_ =
      _$getDriverByIdSuccessResponseSuccessEnum_true_;

  static Serializer<GetDriverByIdSuccessResponseSuccessEnum> get serializer =>
      _$getDriverByIdSuccessResponseSuccessEnumSerializer;

  const GetDriverByIdSuccessResponseSuccessEnum._(String name) : super(name);

  static BuiltSet<GetDriverByIdSuccessResponseSuccessEnum> get values =>
      _$getDriverByIdSuccessResponseSuccessEnumValues;
  static GetDriverByIdSuccessResponseSuccessEnum valueOf(String name) =>
      _$getDriverByIdSuccessResponseSuccessEnumValueOf(name);
}
