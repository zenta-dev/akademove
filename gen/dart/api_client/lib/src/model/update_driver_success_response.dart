//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/driver.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_driver_success_response.g.dart';

/// UpdateDriverSuccessResponse
///
/// Properties:
/// * [success] 
/// * [message] 
/// * [data] 
@BuiltValue()
abstract class UpdateDriverSuccessResponse implements Built<UpdateDriverSuccessResponse, UpdateDriverSuccessResponseBuilder> {
  @BuiltValueField(wireName: r'success')
  UpdateDriverSuccessResponseSuccessEnum get success;
  // enum successEnum {  true,  };

  @BuiltValueField(wireName: r'message')
  String get message;

  @BuiltValueField(wireName: r'data')
  Driver get data;

  UpdateDriverSuccessResponse._();

  factory UpdateDriverSuccessResponse([void updates(UpdateDriverSuccessResponseBuilder b)]) = _$UpdateDriverSuccessResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateDriverSuccessResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateDriverSuccessResponse> get serializer => _$UpdateDriverSuccessResponseSerializer();
}

class _$UpdateDriverSuccessResponseSerializer implements PrimitiveSerializer<UpdateDriverSuccessResponse> {
  @override
  final Iterable<Type> types = const [UpdateDriverSuccessResponse, _$UpdateDriverSuccessResponse];

  @override
  final String wireName = r'UpdateDriverSuccessResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateDriverSuccessResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'success';
    yield serializers.serialize(
      object.success,
      specifiedType: const FullType(UpdateDriverSuccessResponseSuccessEnum),
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
    UpdateDriverSuccessResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UpdateDriverSuccessResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'success':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(UpdateDriverSuccessResponseSuccessEnum),
          ) as UpdateDriverSuccessResponseSuccessEnum;
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
  UpdateDriverSuccessResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateDriverSuccessResponseBuilder();
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

class UpdateDriverSuccessResponseSuccessEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'true')
  static const UpdateDriverSuccessResponseSuccessEnum true_ = _$updateDriverSuccessResponseSuccessEnum_true_;

  static Serializer<UpdateDriverSuccessResponseSuccessEnum> get serializer => _$updateDriverSuccessResponseSuccessEnumSerializer;

  const UpdateDriverSuccessResponseSuccessEnum._(String name): super(name);

  static BuiltSet<UpdateDriverSuccessResponseSuccessEnum> get values => _$updateDriverSuccessResponseSuccessEnumValues;
  static UpdateDriverSuccessResponseSuccessEnum valueOf(String name) => _$updateDriverSuccessResponseSuccessEnumValueOf(name);
}

