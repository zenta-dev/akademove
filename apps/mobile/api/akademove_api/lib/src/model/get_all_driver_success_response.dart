//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:akademove_api/src/model/driver.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'get_all_driver_success_response.g.dart';

/// GetAllDriverSuccessResponse
///
/// Properties:
/// * [success]
/// * [message]
/// * [data]
@BuiltValue()
abstract class GetAllDriverSuccessResponse
    implements
        Built<GetAllDriverSuccessResponse, GetAllDriverSuccessResponseBuilder> {
  @BuiltValueField(wireName: r'success')
  GetAllDriverSuccessResponseSuccessEnum get success;
  // enum successEnum {  true,  };

  @BuiltValueField(wireName: r'message')
  String get message;

  @BuiltValueField(wireName: r'data')
  BuiltList<Driver> get data;

  GetAllDriverSuccessResponse._();

  factory GetAllDriverSuccessResponse(
          [void updates(GetAllDriverSuccessResponseBuilder b)]) =
      _$GetAllDriverSuccessResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GetAllDriverSuccessResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GetAllDriverSuccessResponse> get serializer =>
      _$GetAllDriverSuccessResponseSerializer();
}

class _$GetAllDriverSuccessResponseSerializer
    implements PrimitiveSerializer<GetAllDriverSuccessResponse> {
  @override
  final Iterable<Type> types = const [
    GetAllDriverSuccessResponse,
    _$GetAllDriverSuccessResponse
  ];

  @override
  final String wireName = r'GetAllDriverSuccessResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GetAllDriverSuccessResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'success';
    yield serializers.serialize(
      object.success,
      specifiedType: const FullType(GetAllDriverSuccessResponseSuccessEnum),
    );
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(String),
    );
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(BuiltList, [FullType(Driver)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    GetAllDriverSuccessResponse object, {
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
    required GetAllDriverSuccessResponseBuilder result,
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
                const FullType(GetAllDriverSuccessResponseSuccessEnum),
          ) as GetAllDriverSuccessResponseSuccessEnum;
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
            specifiedType: const FullType(BuiltList, [FullType(Driver)]),
          ) as BuiltList<Driver>;
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
  GetAllDriverSuccessResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GetAllDriverSuccessResponseBuilder();
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

class GetAllDriverSuccessResponseSuccessEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'true')
  static const GetAllDriverSuccessResponseSuccessEnum true_ =
      _$getAllDriverSuccessResponseSuccessEnum_true_;

  static Serializer<GetAllDriverSuccessResponseSuccessEnum> get serializer =>
      _$getAllDriverSuccessResponseSuccessEnumSerializer;

  const GetAllDriverSuccessResponseSuccessEnum._(String name) : super(name);

  static BuiltSet<GetAllDriverSuccessResponseSuccessEnum> get values =>
      _$getAllDriverSuccessResponseSuccessEnumValues;
  static GetAllDriverSuccessResponseSuccessEnum valueOf(String name) =>
      _$getAllDriverSuccessResponseSuccessEnumValueOf(name);
}
