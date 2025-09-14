//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:auth_client/src/model/social_sign_in_request_id_token.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'social_sign_in_request.g.dart';

/// SocialSignInRequest
///
/// Properties:
/// * [callbackURL] - Callback URL to redirect to after the user has signed in
/// * [newUserCallbackURL] 
/// * [errorCallbackURL] - Callback URL to redirect to if an error happens
/// * [provider] 
/// * [disableRedirect] - Disable automatic redirection to the provider. Useful for handling the redirection yourself
/// * [idToken] 
/// * [scopes] - Array of scopes to request from the provider. This will override the default scopes passed.
/// * [requestSignUp] - Explicitly request sign-up. Useful when disableImplicitSignUp is true for this provider
/// * [loginHint] - The login hint to use for the authorization code request
@BuiltValue()
abstract class SocialSignInRequest implements Built<SocialSignInRequest, SocialSignInRequestBuilder> {
  /// Callback URL to redirect to after the user has signed in
  @BuiltValueField(wireName: r'callbackURL')
  String? get callbackURL;

  @BuiltValueField(wireName: r'newUserCallbackURL')
  String? get newUserCallbackURL;

  /// Callback URL to redirect to if an error happens
  @BuiltValueField(wireName: r'errorCallbackURL')
  String? get errorCallbackURL;

  @BuiltValueField(wireName: r'provider')
  String get provider;

  /// Disable automatic redirection to the provider. Useful for handling the redirection yourself
  @BuiltValueField(wireName: r'disableRedirect')
  bool? get disableRedirect;

  @BuiltValueField(wireName: r'idToken')
  SocialSignInRequestIdToken? get idToken;

  /// Array of scopes to request from the provider. This will override the default scopes passed.
  @BuiltValueField(wireName: r'scopes')
  BuiltList<JsonObject?>? get scopes;

  /// Explicitly request sign-up. Useful when disableImplicitSignUp is true for this provider
  @BuiltValueField(wireName: r'requestSignUp')
  bool? get requestSignUp;

  /// The login hint to use for the authorization code request
  @BuiltValueField(wireName: r'loginHint')
  String? get loginHint;

  SocialSignInRequest._();

  factory SocialSignInRequest([void updates(SocialSignInRequestBuilder b)]) = _$SocialSignInRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SocialSignInRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SocialSignInRequest> get serializer => _$SocialSignInRequestSerializer();
}

class _$SocialSignInRequestSerializer implements PrimitiveSerializer<SocialSignInRequest> {
  @override
  final Iterable<Type> types = const [SocialSignInRequest, _$SocialSignInRequest];

  @override
  final String wireName = r'SocialSignInRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SocialSignInRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.callbackURL != null) {
      yield r'callbackURL';
      yield serializers.serialize(
        object.callbackURL,
        specifiedType: const FullType(String),
      );
    }
    if (object.newUserCallbackURL != null) {
      yield r'newUserCallbackURL';
      yield serializers.serialize(
        object.newUserCallbackURL,
        specifiedType: const FullType(String),
      );
    }
    if (object.errorCallbackURL != null) {
      yield r'errorCallbackURL';
      yield serializers.serialize(
        object.errorCallbackURL,
        specifiedType: const FullType(String),
      );
    }
    yield r'provider';
    yield serializers.serialize(
      object.provider,
      specifiedType: const FullType(String),
    );
    if (object.disableRedirect != null) {
      yield r'disableRedirect';
      yield serializers.serialize(
        object.disableRedirect,
        specifiedType: const FullType(bool),
      );
    }
    if (object.idToken != null) {
      yield r'idToken';
      yield serializers.serialize(
        object.idToken,
        specifiedType: const FullType(SocialSignInRequestIdToken),
      );
    }
    if (object.scopes != null) {
      yield r'scopes';
      yield serializers.serialize(
        object.scopes,
        specifiedType: const FullType(BuiltList, [FullType.nullable(JsonObject)]),
      );
    }
    if (object.requestSignUp != null) {
      yield r'requestSignUp';
      yield serializers.serialize(
        object.requestSignUp,
        specifiedType: const FullType(bool),
      );
    }
    if (object.loginHint != null) {
      yield r'loginHint';
      yield serializers.serialize(
        object.loginHint,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SocialSignInRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SocialSignInRequestBuilder result,
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
        case r'newUserCallbackURL':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.newUserCallbackURL = valueDes;
          break;
        case r'errorCallbackURL':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.errorCallbackURL = valueDes;
          break;
        case r'provider':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.provider = valueDes;
          break;
        case r'disableRedirect':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.disableRedirect = valueDes;
          break;
        case r'idToken':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(SocialSignInRequestIdToken),
          ) as SocialSignInRequestIdToken;
          result.idToken.replace(valueDes);
          break;
        case r'scopes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType.nullable(JsonObject)]),
          ) as BuiltList<JsonObject?>;
          result.scopes.replace(valueDes);
          break;
        case r'requestSignUp':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.requestSignUp = valueDes;
          break;
        case r'loginHint':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.loginHint = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SocialSignInRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SocialSignInRequestBuilder();
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

