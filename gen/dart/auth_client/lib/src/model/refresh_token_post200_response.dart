//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'refresh_token_post200_response.g.dart';

/// RefreshTokenPost200Response
///
/// Properties:
/// * [tokenType] 
/// * [idToken] 
/// * [accessToken] 
/// * [refreshToken] 
/// * [accessTokenExpiresAt] 
/// * [refreshTokenExpiresAt] 
@BuiltValue()
abstract class RefreshTokenPost200Response implements Built<RefreshTokenPost200Response, RefreshTokenPost200ResponseBuilder> {
  @BuiltValueField(wireName: r'tokenType')
  String? get tokenType;

  @BuiltValueField(wireName: r'idToken')
  String? get idToken;

  @BuiltValueField(wireName: r'accessToken')
  String? get accessToken;

  @BuiltValueField(wireName: r'refreshToken')
  String? get refreshToken;

  @BuiltValueField(wireName: r'accessTokenExpiresAt')
  DateTime? get accessTokenExpiresAt;

  @BuiltValueField(wireName: r'refreshTokenExpiresAt')
  DateTime? get refreshTokenExpiresAt;

  RefreshTokenPost200Response._();

  factory RefreshTokenPost200Response([void updates(RefreshTokenPost200ResponseBuilder b)]) = _$RefreshTokenPost200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RefreshTokenPost200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RefreshTokenPost200Response> get serializer => _$RefreshTokenPost200ResponseSerializer();
}

class _$RefreshTokenPost200ResponseSerializer implements PrimitiveSerializer<RefreshTokenPost200Response> {
  @override
  final Iterable<Type> types = const [RefreshTokenPost200Response, _$RefreshTokenPost200Response];

  @override
  final String wireName = r'RefreshTokenPost200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RefreshTokenPost200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.tokenType != null) {
      yield r'tokenType';
      yield serializers.serialize(
        object.tokenType,
        specifiedType: const FullType(String),
      );
    }
    if (object.idToken != null) {
      yield r'idToken';
      yield serializers.serialize(
        object.idToken,
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
    if (object.accessTokenExpiresAt != null) {
      yield r'accessTokenExpiresAt';
      yield serializers.serialize(
        object.accessTokenExpiresAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.refreshTokenExpiresAt != null) {
      yield r'refreshTokenExpiresAt';
      yield serializers.serialize(
        object.refreshTokenExpiresAt,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    RefreshTokenPost200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RefreshTokenPost200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'tokenType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.tokenType = valueDes;
          break;
        case r'idToken':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.idToken = valueDes;
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
        case r'accessTokenExpiresAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.accessTokenExpiresAt = valueDes;
          break;
        case r'refreshTokenExpiresAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.refreshTokenExpiresAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  RefreshTokenPost200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RefreshTokenPost200ResponseBuilder();
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

