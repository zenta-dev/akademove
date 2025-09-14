//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:akademove_api/src/model/merchant.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_merchant_success_response.g.dart';

/// UpdateMerchantSuccessResponse
///
/// Properties:
/// * [success]
/// * [message]
/// * [data]
@BuiltValue()
abstract class UpdateMerchantSuccessResponse
    implements
        Built<UpdateMerchantSuccessResponse,
            UpdateMerchantSuccessResponseBuilder> {
  @BuiltValueField(wireName: r'success')
  UpdateMerchantSuccessResponseSuccessEnum get success;
  // enum successEnum {  true,  };

  @BuiltValueField(wireName: r'message')
  String get message;

  @BuiltValueField(wireName: r'data')
  Merchant get data;

  UpdateMerchantSuccessResponse._();

  factory UpdateMerchantSuccessResponse(
          [void updates(UpdateMerchantSuccessResponseBuilder b)]) =
      _$UpdateMerchantSuccessResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateMerchantSuccessResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateMerchantSuccessResponse> get serializer =>
      _$UpdateMerchantSuccessResponseSerializer();
}

class _$UpdateMerchantSuccessResponseSerializer
    implements PrimitiveSerializer<UpdateMerchantSuccessResponse> {
  @override
  final Iterable<Type> types = const [
    UpdateMerchantSuccessResponse,
    _$UpdateMerchantSuccessResponse
  ];

  @override
  final String wireName = r'UpdateMerchantSuccessResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateMerchantSuccessResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'success';
    yield serializers.serialize(
      object.success,
      specifiedType: const FullType(UpdateMerchantSuccessResponseSuccessEnum),
    );
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(String),
    );
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(Merchant),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateMerchantSuccessResponse object, {
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
    required UpdateMerchantSuccessResponseBuilder result,
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
                const FullType(UpdateMerchantSuccessResponseSuccessEnum),
          ) as UpdateMerchantSuccessResponseSuccessEnum;
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
            specifiedType: const FullType(Merchant),
          ) as Merchant;
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
  UpdateMerchantSuccessResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateMerchantSuccessResponseBuilder();
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

class UpdateMerchantSuccessResponseSuccessEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'true')
  static const UpdateMerchantSuccessResponseSuccessEnum true_ =
      _$updateMerchantSuccessResponseSuccessEnum_true_;

  static Serializer<UpdateMerchantSuccessResponseSuccessEnum> get serializer =>
      _$updateMerchantSuccessResponseSuccessEnumSerializer;

  const UpdateMerchantSuccessResponseSuccessEnum._(String name) : super(name);

  static BuiltSet<UpdateMerchantSuccessResponseSuccessEnum> get values =>
      _$updateMerchantSuccessResponseSuccessEnumValues;
  static UpdateMerchantSuccessResponseSuccessEnum valueOf(String name) =>
      _$updateMerchantSuccessResponseSuccessEnumValueOf(name);
}
