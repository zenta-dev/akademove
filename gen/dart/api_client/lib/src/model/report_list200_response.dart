//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/report.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'report_list200_response.g.dart';

/// ReportList200Response
///
/// Properties:
/// * [message] 
/// * [data] 
@BuiltValue()
abstract class ReportList200Response implements Built<ReportList200Response, ReportList200ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  String get message;

  @BuiltValueField(wireName: r'data')
  BuiltList<Report> get data;

  ReportList200Response._();

  factory ReportList200Response([void updates(ReportList200ResponseBuilder b)]) = _$ReportList200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ReportList200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ReportList200Response> get serializer => _$ReportList200ResponseSerializer();
}

class _$ReportList200ResponseSerializer implements PrimitiveSerializer<ReportList200Response> {
  @override
  final Iterable<Type> types = const [ReportList200Response, _$ReportList200Response];

  @override
  final String wireName = r'ReportList200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ReportList200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
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
    ReportList200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ReportList200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
  ReportList200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ReportList200ResponseBuilder();
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

