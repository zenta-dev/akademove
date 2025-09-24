//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_user_password_request.g.dart';

/// UpdateUserPasswordRequest
///
/// Properties:
/// * [password] 
/// * [confirmPassword] 
@BuiltValue()
abstract class UpdateUserPasswordRequest implements Built<UpdateUserPasswordRequest, UpdateUserPasswordRequestBuilder> {
  @BuiltValueField(wireName: r'password')
  String get password;

  @BuiltValueField(wireName: r'confirmPassword')
  String get confirmPassword;

  UpdateUserPasswordRequest._();

  factory UpdateUserPasswordRequest([void updates(UpdateUserPasswordRequestBuilder b)]) = _$UpdateUserPasswordRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateUserPasswordRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateUserPasswordRequest> get serializer => _$UpdateUserPasswordRequestSerializer();
}

class _$UpdateUserPasswordRequestSerializer implements PrimitiveSerializer<UpdateUserPasswordRequest> {
  @override
  final Iterable<Type> types = const [UpdateUserPasswordRequest, _$UpdateUserPasswordRequest];

  @override
  final String wireName = r'UpdateUserPasswordRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateUserPasswordRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'password';
    yield serializers.serialize(
      object.password,
      specifiedType: const FullType(String),
    );
    yield r'confirmPassword';
    yield serializers.serialize(
      object.confirmPassword,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateUserPasswordRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UpdateUserPasswordRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'password':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.password = valueDes;
          break;
        case r'confirmPassword':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.confirmPassword = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdateUserPasswordRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateUserPasswordRequestBuilder();
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

