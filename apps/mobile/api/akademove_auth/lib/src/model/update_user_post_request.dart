//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_user_post_request.g.dart';

/// UpdateUserPostRequest
///
/// Properties:
/// * [name] - The name of the user
/// * [image] - The image of the user
@BuiltValue()
abstract class UpdateUserPostRequest
    implements Built<UpdateUserPostRequest, UpdateUserPostRequestBuilder> {
  /// The name of the user
  @BuiltValueField(wireName: r'name')
  String? get name;

  /// The image of the user
  @BuiltValueField(wireName: r'image')
  String? get image;

  UpdateUserPostRequest._();

  factory UpdateUserPostRequest(
      [void updates(UpdateUserPostRequestBuilder b)]) = _$UpdateUserPostRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateUserPostRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateUserPostRequest> get serializer =>
      _$UpdateUserPostRequestSerializer();
}

class _$UpdateUserPostRequestSerializer
    implements PrimitiveSerializer<UpdateUserPostRequest> {
  @override
  final Iterable<Type> types = const [
    UpdateUserPostRequest,
    _$UpdateUserPostRequest
  ];

  @override
  final String wireName = r'UpdateUserPostRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateUserPostRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.name != null) {
      yield r'name';
      yield serializers.serialize(
        object.name,
        specifiedType: const FullType(String),
      );
    }
    if (object.image != null) {
      yield r'image';
      yield serializers.serialize(
        object.image,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateUserPostRequest object, {
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
    required UpdateUserPostRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'image':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.image = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdateUserPostRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateUserPostRequestBuilder();
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
