//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'refresh_token_post_request.g.dart';

/// RefreshTokenPostRequest
///
/// Properties:
/// * [providerId] - The provider ID for the OAuth provider
/// * [accountId] - The account ID associated with the refresh token
/// * [userId] - The user ID associated with the account
@BuiltValue()
abstract class RefreshTokenPostRequest
    implements Built<RefreshTokenPostRequest, RefreshTokenPostRequestBuilder> {
  /// The provider ID for the OAuth provider
  @BuiltValueField(wireName: r'providerId')
  String get providerId;

  /// The account ID associated with the refresh token
  @BuiltValueField(wireName: r'accountId')
  String? get accountId;

  /// The user ID associated with the account
  @BuiltValueField(wireName: r'userId')
  String? get userId;

  RefreshTokenPostRequest._();

  factory RefreshTokenPostRequest(
          [void updates(RefreshTokenPostRequestBuilder b)]) =
      _$RefreshTokenPostRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RefreshTokenPostRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RefreshTokenPostRequest> get serializer =>
      _$RefreshTokenPostRequestSerializer();
}

class _$RefreshTokenPostRequestSerializer
    implements PrimitiveSerializer<RefreshTokenPostRequest> {
  @override
  final Iterable<Type> types = const [
    RefreshTokenPostRequest,
    _$RefreshTokenPostRequest
  ];

  @override
  final String wireName = r'RefreshTokenPostRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RefreshTokenPostRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'providerId';
    yield serializers.serialize(
      object.providerId,
      specifiedType: const FullType(String),
    );
    if (object.accountId != null) {
      yield r'accountId';
      yield serializers.serialize(
        object.accountId,
        specifiedType: const FullType(String),
      );
    }
    if (object.userId != null) {
      yield r'userId';
      yield serializers.serialize(
        object.userId,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    RefreshTokenPostRequest object, {
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
    required RefreshTokenPostRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'providerId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.providerId = valueDes;
          break;
        case r'accountId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.accountId = valueDes;
          break;
        case r'userId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.userId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  RefreshTokenPostRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RefreshTokenPostRequestBuilder();
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
