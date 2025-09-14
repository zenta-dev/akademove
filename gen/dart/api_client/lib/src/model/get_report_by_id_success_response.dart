//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/report.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'get_report_by_id_success_response.g.dart';

/// GetReportByIdSuccessResponse
///
/// Properties:
/// * [success] 
/// * [message] 
/// * [data] 
@BuiltValue()
abstract class GetReportByIdSuccessResponse implements Built<GetReportByIdSuccessResponse, GetReportByIdSuccessResponseBuilder> {
  @BuiltValueField(wireName: r'success')
  GetReportByIdSuccessResponseSuccessEnum get success;
  // enum successEnum {  true,  };

  @BuiltValueField(wireName: r'message')
  String get message;

  @BuiltValueField(wireName: r'data')
  Report get data;

  GetReportByIdSuccessResponse._();

  factory GetReportByIdSuccessResponse([void updates(GetReportByIdSuccessResponseBuilder b)]) = _$GetReportByIdSuccessResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GetReportByIdSuccessResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GetReportByIdSuccessResponse> get serializer => _$GetReportByIdSuccessResponseSerializer();
}

class _$GetReportByIdSuccessResponseSerializer implements PrimitiveSerializer<GetReportByIdSuccessResponse> {
  @override
  final Iterable<Type> types = const [GetReportByIdSuccessResponse, _$GetReportByIdSuccessResponse];

  @override
  final String wireName = r'GetReportByIdSuccessResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GetReportByIdSuccessResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'success';
    yield serializers.serialize(
      object.success,
      specifiedType: const FullType(GetReportByIdSuccessResponseSuccessEnum),
    );
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(String),
    );
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(Report),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    GetReportByIdSuccessResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required GetReportByIdSuccessResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'success':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(GetReportByIdSuccessResponseSuccessEnum),
          ) as GetReportByIdSuccessResponseSuccessEnum;
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
            specifiedType: const FullType(Report),
          ) as Report;
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
  GetReportByIdSuccessResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GetReportByIdSuccessResponseBuilder();
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

class GetReportByIdSuccessResponseSuccessEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'true')
  static const GetReportByIdSuccessResponseSuccessEnum true_ = _$getReportByIdSuccessResponseSuccessEnum_true_;

  static Serializer<GetReportByIdSuccessResponseSuccessEnum> get serializer => _$getReportByIdSuccessResponseSuccessEnumSerializer;

  const GetReportByIdSuccessResponseSuccessEnum._(String name): super(name);

  static BuiltSet<GetReportByIdSuccessResponseSuccessEnum> get values => _$getReportByIdSuccessResponseSuccessEnumValues;
  static GetReportByIdSuccessResponseSuccessEnum valueOf(String name) => _$getReportByIdSuccessResponseSuccessEnumValueOf(name);
}

