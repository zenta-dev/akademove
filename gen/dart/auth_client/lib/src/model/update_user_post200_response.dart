//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_user_post200_response.g.dart';

/// UpdateUserPost200Response
///
/// Properties:
/// * [status] - Indicates if the update was successful
@BuiltValue()
abstract class UpdateUserPost200Response implements Built<UpdateUserPost200Response, UpdateUserPost200ResponseBuilder> {
  /// Indicates if the update was successful
  @BuiltValueField(wireName: r'status')
  bool? get status;

  UpdateUserPost200Response._();

  factory UpdateUserPost200Response([void updates(UpdateUserPost200ResponseBuilder b)]) = _$UpdateUserPost200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateUserPost200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateUserPost200Response> get serializer => _$UpdateUserPost200ResponseSerializer();
}

class _$UpdateUserPost200ResponseSerializer implements PrimitiveSerializer<UpdateUserPost200Response> {
  @override
  final Iterable<Type> types = const [UpdateUserPost200Response, _$UpdateUserPost200Response];

  @override
  final String wireName = r'UpdateUserPost200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateUserPost200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateUserPost200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UpdateUserPost200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.status = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdateUserPost200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateUserPost200ResponseBuilder();
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

