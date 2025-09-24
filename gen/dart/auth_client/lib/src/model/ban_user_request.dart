//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'ban_user_request.g.dart';

/// BanUserRequest
///
/// Properties:
/// * [userId] - The user id
/// * [banReason] - The reason for the ban
/// * [banExpiresIn] - The number of seconds until the ban expires
@BuiltValue()
abstract class BanUserRequest implements Built<BanUserRequest, BanUserRequestBuilder> {
  /// The user id
  @BuiltValueField(wireName: r'userId')
  String get userId;

  /// The reason for the ban
  @BuiltValueField(wireName: r'banReason')
  String? get banReason;

  /// The number of seconds until the ban expires
  @BuiltValueField(wireName: r'banExpiresIn')
  num? get banExpiresIn;

  BanUserRequest._();

  factory BanUserRequest([void updates(BanUserRequestBuilder b)]) = _$BanUserRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BanUserRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BanUserRequest> get serializer => _$BanUserRequestSerializer();
}

class _$BanUserRequestSerializer implements PrimitiveSerializer<BanUserRequest> {
  @override
  final Iterable<Type> types = const [BanUserRequest, _$BanUserRequest];

  @override
  final String wireName = r'BanUserRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BanUserRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'userId';
    yield serializers.serialize(
      object.userId,
      specifiedType: const FullType(String),
    );
    if (object.banReason != null) {
      yield r'banReason';
      yield serializers.serialize(
        object.banReason,
        specifiedType: const FullType(String),
      );
    }
    if (object.banExpiresIn != null) {
      yield r'banExpiresIn';
      yield serializers.serialize(
        object.banExpiresIn,
        specifiedType: const FullType(num),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    BanUserRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BanUserRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'userId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.userId = valueDes;
          break;
        case r'banReason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.banReason = valueDes;
          break;
        case r'banExpiresIn':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.banExpiresIn = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BanUserRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BanUserRequestBuilder();
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

