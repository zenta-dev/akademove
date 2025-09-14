//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:auth_client/src/model/sign_in_email_post200_response_user.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'sign_in_email_post200_response.g.dart';

/// Session response when idToken is provided
///
/// Properties:
/// * [redirect] 
/// * [token] - Session token
/// * [url] 
/// * [user] 
@BuiltValue()
abstract class SignInEmailPost200Response implements Built<SignInEmailPost200Response, SignInEmailPost200ResponseBuilder> {
  @BuiltValueField(wireName: r'redirect')
  SignInEmailPost200ResponseRedirectEnum get redirect;
  // enum redirectEnum {  false,  };

  /// Session token
  @BuiltValueField(wireName: r'token')
  String get token;

  @BuiltValueField(wireName: r'url')
  JsonObject? get url;

  @BuiltValueField(wireName: r'user')
  SignInEmailPost200ResponseUser get user;

  SignInEmailPost200Response._();

  factory SignInEmailPost200Response([void updates(SignInEmailPost200ResponseBuilder b)]) = _$SignInEmailPost200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SignInEmailPost200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SignInEmailPost200Response> get serializer => _$SignInEmailPost200ResponseSerializer();
}

class _$SignInEmailPost200ResponseSerializer implements PrimitiveSerializer<SignInEmailPost200Response> {
  @override
  final Iterable<Type> types = const [SignInEmailPost200Response, _$SignInEmailPost200Response];

  @override
  final String wireName = r'SignInEmailPost200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SignInEmailPost200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'redirect';
    yield serializers.serialize(
      object.redirect,
      specifiedType: const FullType(SignInEmailPost200ResponseRedirectEnum),
    );
    yield r'token';
    yield serializers.serialize(
      object.token,
      specifiedType: const FullType(String),
    );
    if (object.url != null) {
      yield r'url';
      yield serializers.serialize(
        object.url,
        specifiedType: const FullType.nullable(JsonObject),
      );
    }
    yield r'user';
    yield serializers.serialize(
      object.user,
      specifiedType: const FullType(SignInEmailPost200ResponseUser),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    SignInEmailPost200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SignInEmailPost200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'redirect':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(SignInEmailPost200ResponseRedirectEnum),
          ) as SignInEmailPost200ResponseRedirectEnum;
          result.redirect = valueDes;
          break;
        case r'token':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.token = valueDes;
          break;
        case r'url':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(JsonObject),
          ) as JsonObject?;
          if (valueDes == null) continue;
          result.url = valueDes;
          break;
        case r'user':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(SignInEmailPost200ResponseUser),
          ) as SignInEmailPost200ResponseUser;
          result.user.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SignInEmailPost200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SignInEmailPost200ResponseBuilder();
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

class SignInEmailPost200ResponseRedirectEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'false')
  static const SignInEmailPost200ResponseRedirectEnum false_ = _$signInEmailPost200ResponseRedirectEnum_false_;

  static Serializer<SignInEmailPost200ResponseRedirectEnum> get serializer => _$signInEmailPost200ResponseRedirectEnumSerializer;

  const SignInEmailPost200ResponseRedirectEnum._(String name): super(name);

  static BuiltSet<SignInEmailPost200ResponseRedirectEnum> get values => _$signInEmailPost200ResponseRedirectEnumValues;
  static SignInEmailPost200ResponseRedirectEnum valueOf(String name) => _$signInEmailPost200ResponseRedirectEnumValueOf(name);
}

