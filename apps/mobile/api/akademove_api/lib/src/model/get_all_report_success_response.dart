//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:akademove_api/src/model/report.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'get_all_report_success_response.g.dart';

/// GetAllReportSuccessResponse
///
/// Properties:
/// * [success]
/// * [message]
/// * [data]
@BuiltValue()
abstract class GetAllReportSuccessResponse
    implements
        Built<GetAllReportSuccessResponse, GetAllReportSuccessResponseBuilder> {
  @BuiltValueField(wireName: r'success')
  GetAllReportSuccessResponseSuccessEnum get success;
  // enum successEnum {  true,  };

  @BuiltValueField(wireName: r'message')
  String get message;

  @BuiltValueField(wireName: r'data')
  BuiltList<Report> get data;

  GetAllReportSuccessResponse._();

  factory GetAllReportSuccessResponse(
          [void updates(GetAllReportSuccessResponseBuilder b)]) =
      _$GetAllReportSuccessResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GetAllReportSuccessResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GetAllReportSuccessResponse> get serializer =>
      _$GetAllReportSuccessResponseSerializer();
}

class _$GetAllReportSuccessResponseSerializer
    implements PrimitiveSerializer<GetAllReportSuccessResponse> {
  @override
  final Iterable<Type> types = const [
    GetAllReportSuccessResponse,
    _$GetAllReportSuccessResponse
  ];

  @override
  final String wireName = r'GetAllReportSuccessResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GetAllReportSuccessResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'success';
    yield serializers.serialize(
      object.success,
      specifiedType: const FullType(GetAllReportSuccessResponseSuccessEnum),
    );
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(String),
    );
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(BuiltList, [FullType(Report)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    GetAllReportSuccessResponse object, {
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
    required GetAllReportSuccessResponseBuilder result,
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
                const FullType(GetAllReportSuccessResponseSuccessEnum),
          ) as GetAllReportSuccessResponseSuccessEnum;
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
            specifiedType: const FullType(BuiltList, [FullType(Report)]),
          ) as BuiltList<Report>;
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
  GetAllReportSuccessResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GetAllReportSuccessResponseBuilder();
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

class GetAllReportSuccessResponseSuccessEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'true')
  static const GetAllReportSuccessResponseSuccessEnum true_ =
      _$getAllReportSuccessResponseSuccessEnum_true_;

  static Serializer<GetAllReportSuccessResponseSuccessEnum> get serializer =>
      _$getAllReportSuccessResponseSuccessEnumSerializer;

  const GetAllReportSuccessResponseSuccessEnum._(String name) : super(name);

  static BuiltSet<GetAllReportSuccessResponseSuccessEnum> get values =>
      _$getAllReportSuccessResponseSuccessEnumValues;
  static GetAllReportSuccessResponseSuccessEnum valueOf(String name) =>
      _$getAllReportSuccessResponseSuccessEnumValueOf(name);
}
