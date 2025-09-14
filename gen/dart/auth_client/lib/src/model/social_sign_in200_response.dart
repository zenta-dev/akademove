//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'social_sign_in200_response.g.dart';

/// Session response when idToken is provided
///
/// Properties:
/// * [redirect] 
/// * [token] - Session token
@BuiltValue()
abstract class SocialSignIn200Response implements Built<SocialSignIn200Response, SocialSignIn200ResponseBuilder> {
  @BuiltValueField(wireName: r'redirect')
  SocialSignIn200ResponseRedirectEnum get redirect;
  // enum redirectEnum {  false,  };

  /// Session token
  @BuiltValueField(wireName: r'token')
  String get token;

  SocialSignIn200Response._();

  factory SocialSignIn200Response([void updates(SocialSignIn200ResponseBuilder b)]) = _$SocialSignIn200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SocialSignIn200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SocialSignIn200Response> get serializer => _$SocialSignIn200ResponseSerializer();
}

class _$SocialSignIn200ResponseSerializer implements PrimitiveSerializer<SocialSignIn200Response> {
  @override
  final Iterable<Type> types = const [SocialSignIn200Response, _$SocialSignIn200Response];

  @override
  final String wireName = r'SocialSignIn200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SocialSignIn200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'redirect';
    yield serializers.serialize(
      object.redirect,
      specifiedType: const FullType(SocialSignIn200ResponseRedirectEnum),
    );
    yield r'token';
    yield serializers.serialize(
      object.token,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    SocialSignIn200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SocialSignIn200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'redirect':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(SocialSignIn200ResponseRedirectEnum),
          ) as SocialSignIn200ResponseRedirectEnum;
          result.redirect = valueDes;
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
  SocialSignIn200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SocialSignIn200ResponseBuilder();
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

class SocialSignIn200ResponseRedirectEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'false')
  static const SocialSignIn200ResponseRedirectEnum false_ = _$socialSignIn200ResponseRedirectEnum_false_;

  static Serializer<SocialSignIn200ResponseRedirectEnum> get serializer => _$socialSignIn200ResponseRedirectEnumSerializer;

  const SocialSignIn200ResponseRedirectEnum._(String name): super(name);

  static BuiltSet<SocialSignIn200ResponseRedirectEnum> get values => _$socialSignIn200ResponseRedirectEnumValues;
  static SocialSignIn200ResponseRedirectEnum valueOf(String name) => _$socialSignIn200ResponseRedirectEnumValueOf(name);
}

