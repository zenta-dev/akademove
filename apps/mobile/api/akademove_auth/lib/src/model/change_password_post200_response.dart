//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:akademove_auth/src/model/sign_up_email_post200_response_user.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'change_password_post200_response.g.dart';

/// ChangePasswordPost200Response
///
/// Properties:
/// * [user]
/// * [token] - New session token if other sessions were revoked
@BuiltValue()
abstract class ChangePasswordPost200Response
    implements
        Built<ChangePasswordPost200Response,
            ChangePasswordPost200ResponseBuilder> {
  @BuiltValueField(wireName: r'user')
  SignUpEmailPost200ResponseUser get user;

  /// New session token if other sessions were revoked
  @BuiltValueField(wireName: r'token')
  String? get token;

  ChangePasswordPost200Response._();

  factory ChangePasswordPost200Response(
          [void updates(ChangePasswordPost200ResponseBuilder b)]) =
      _$ChangePasswordPost200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ChangePasswordPost200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ChangePasswordPost200Response> get serializer =>
      _$ChangePasswordPost200ResponseSerializer();
}

class _$ChangePasswordPost200ResponseSerializer
    implements PrimitiveSerializer<ChangePasswordPost200Response> {
  @override
  final Iterable<Type> types = const [
    ChangePasswordPost200Response,
    _$ChangePasswordPost200Response
  ];

  @override
  final String wireName = r'ChangePasswordPost200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ChangePasswordPost200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'user';
    yield serializers.serialize(
      object.user,
      specifiedType: const FullType(SignUpEmailPost200ResponseUser),
    );
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
    ChangePasswordPost200Response object, {
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
    required ChangePasswordPost200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'user':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(SignUpEmailPost200ResponseUser),
          ) as SignUpEmailPost200ResponseUser;
          result.user.replace(valueDes);
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
  ChangePasswordPost200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ChangePasswordPost200ResponseBuilder();
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
