//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:akademove_api/src/model/promo.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_promo_success_response.g.dart';

/// UpdatePromoSuccessResponse
///
/// Properties:
/// * [success]
/// * [message]
/// * [data]
@BuiltValue()
abstract class UpdatePromoSuccessResponse
    implements
        Built<UpdatePromoSuccessResponse, UpdatePromoSuccessResponseBuilder> {
  @BuiltValueField(wireName: r'success')
  UpdatePromoSuccessResponseSuccessEnum get success;
  // enum successEnum {  true,  };

  @BuiltValueField(wireName: r'message')
  String get message;

  @BuiltValueField(wireName: r'data')
  Promo get data;

  UpdatePromoSuccessResponse._();

  factory UpdatePromoSuccessResponse(
          [void updates(UpdatePromoSuccessResponseBuilder b)]) =
      _$UpdatePromoSuccessResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdatePromoSuccessResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdatePromoSuccessResponse> get serializer =>
      _$UpdatePromoSuccessResponseSerializer();
}

class _$UpdatePromoSuccessResponseSerializer
    implements PrimitiveSerializer<UpdatePromoSuccessResponse> {
  @override
  final Iterable<Type> types = const [
    UpdatePromoSuccessResponse,
    _$UpdatePromoSuccessResponse
  ];

  @override
  final String wireName = r'UpdatePromoSuccessResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdatePromoSuccessResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'success';
    yield serializers.serialize(
      object.success,
      specifiedType: const FullType(UpdatePromoSuccessResponseSuccessEnum),
    );
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(String),
    );
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(Promo),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdatePromoSuccessResponse object, {
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
    required UpdatePromoSuccessResponseBuilder result,
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
                const FullType(UpdatePromoSuccessResponseSuccessEnum),
          ) as UpdatePromoSuccessResponseSuccessEnum;
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
            specifiedType: const FullType(Promo),
          ) as Promo;
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
  UpdatePromoSuccessResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdatePromoSuccessResponseBuilder();
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

class UpdatePromoSuccessResponseSuccessEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'true')
  static const UpdatePromoSuccessResponseSuccessEnum true_ =
      _$updatePromoSuccessResponseSuccessEnum_true_;

  static Serializer<UpdatePromoSuccessResponseSuccessEnum> get serializer =>
      _$updatePromoSuccessResponseSuccessEnumSerializer;

  const UpdatePromoSuccessResponseSuccessEnum._(String name) : super(name);

  static BuiltSet<UpdatePromoSuccessResponseSuccessEnum> get values =>
      _$updatePromoSuccessResponseSuccessEnumValues;
  static UpdatePromoSuccessResponseSuccessEnum valueOf(String name) =>
      _$updatePromoSuccessResponseSuccessEnumValueOf(name);
}
