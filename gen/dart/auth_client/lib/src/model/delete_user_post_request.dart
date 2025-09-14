//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'delete_user_post_request.g.dart';

/// DeleteUserPostRequest
///
/// Properties:
/// * [callbackURL] - The callback URL to redirect to after the user is deleted
/// * [password] - The password of the user is required to delete the user
/// * [token] - The token to delete the user is required
@BuiltValue()
abstract class DeleteUserPostRequest implements Built<DeleteUserPostRequest, DeleteUserPostRequestBuilder> {
  /// The callback URL to redirect to after the user is deleted
  @BuiltValueField(wireName: r'callbackURL')
  String? get callbackURL;

  /// The password of the user is required to delete the user
  @BuiltValueField(wireName: r'password')
  String? get password;

  /// The token to delete the user is required
  @BuiltValueField(wireName: r'token')
  String? get token;

  DeleteUserPostRequest._();

  factory DeleteUserPostRequest([void updates(DeleteUserPostRequestBuilder b)]) = _$DeleteUserPostRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DeleteUserPostRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DeleteUserPostRequest> get serializer => _$DeleteUserPostRequestSerializer();
}

class _$DeleteUserPostRequestSerializer implements PrimitiveSerializer<DeleteUserPostRequest> {
  @override
  final Iterable<Type> types = const [DeleteUserPostRequest, _$DeleteUserPostRequest];

  @override
  final String wireName = r'DeleteUserPostRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DeleteUserPostRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.callbackURL != null) {
      yield r'callbackURL';
      yield serializers.serialize(
        object.callbackURL,
        specifiedType: const FullType(String),
      );
    }
    if (object.password != null) {
      yield r'password';
      yield serializers.serialize(
        object.password,
        specifiedType: const FullType(String),
      );
    }
    if (object.token != null) {
      yield r'token';
      yield serializers.serialize(
        object.token,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    DeleteUserPostRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DeleteUserPostRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'callbackURL':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.callbackURL = valueDes;
          break;
        case r'password':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.password = valueDes;
          break;
        case r'token':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.token = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DeleteUserPostRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DeleteUserPostRequestBuilder();
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

