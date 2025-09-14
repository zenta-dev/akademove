//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'social_sign_in_request_id_token.g.dart';

/// SocialSignInRequestIdToken
///
/// Properties:
/// * [token] - ID token from the provider
/// * [nonce] - Nonce used to generate the token
/// * [accessToken] - Access token from the provider
/// * [refreshToken] - Refresh token from the provider
/// * [expiresAt] - Expiry date of the token
@BuiltValue()
abstract class SocialSignInRequestIdToken implements Built<SocialSignInRequestIdToken, SocialSignInRequestIdTokenBuilder> {
  /// ID token from the provider
  @BuiltValueField(wireName: r'token')
  String get token;

  /// Nonce used to generate the token
  @BuiltValueField(wireName: r'nonce')
  String? get nonce;

  /// Access token from the provider
  @BuiltValueField(wireName: r'accessToken')
  String? get accessToken;

  /// Refresh token from the provider
  @BuiltValueField(wireName: r'refreshToken')
  String? get refreshToken;

  /// Expiry date of the token
  @BuiltValueField(wireName: r'expiresAt')
  num? get expiresAt;

  SocialSignInRequestIdToken._();

  factory SocialSignInRequestIdToken([void updates(SocialSignInRequestIdTokenBuilder b)]) = _$SocialSignInRequestIdToken;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SocialSignInRequestIdTokenBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SocialSignInRequestIdToken> get serializer => _$SocialSignInRequestIdTokenSerializer();
}

class _$SocialSignInRequestIdTokenSerializer implements PrimitiveSerializer<SocialSignInRequestIdToken> {
  @override
  final Iterable<Type> types = const [SocialSignInRequestIdToken, _$SocialSignInRequestIdToken];

  @override
  final String wireName = r'SocialSignInRequestIdToken';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SocialSignInRequestIdToken object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'token';
    yield serializers.serialize(
      object.token,
      specifiedType: const FullType(String),
    );
    if (object.nonce != null) {
      yield r'nonce';
      yield serializers.serialize(
        object.nonce,
        specifiedType: const FullType(String),
      );
    }
    if (object.accessToken != null) {
      yield r'accessToken';
      yield serializers.serialize(
        object.accessToken,
        specifiedType: const FullType(String),
      );
    }
    if (object.refreshToken != null) {
      yield r'refreshToken';
      yield serializers.serialize(
        object.refreshToken,
        specifiedType: const FullType(String),
      );
    }
    if (object.expiresAt != null) {
      yield r'expiresAt';
      yield serializers.serialize(
        object.expiresAt,
        specifiedType: const FullType(num),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SocialSignInRequestIdToken object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SocialSignInRequestIdTokenBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'token':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.token = valueDes;
          break;
        case r'nonce':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.nonce = valueDes;
          break;
        case r'accessToken':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.accessToken = valueDes;
          break;
        case r'refreshToken':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.refreshToken = valueDes;
          break;
        case r'expiresAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.expiresAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SocialSignInRequestIdToken deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SocialSignInRequestIdTokenBuilder();
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

