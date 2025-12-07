// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_verify_quiz_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DriverVerifyQuizRequestCWProxy {
  DriverVerifyQuizRequest quizVerified(bool quizVerified);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverVerifyQuizRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverVerifyQuizRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverVerifyQuizRequest call({bool quizVerified});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDriverVerifyQuizRequest.copyWith(...)` or call `instanceOfDriverVerifyQuizRequest.copyWith.fieldName(value)` for a single field.
class _$DriverVerifyQuizRequestCWProxyImpl
    implements _$DriverVerifyQuizRequestCWProxy {
  const _$DriverVerifyQuizRequestCWProxyImpl(this._value);

  final DriverVerifyQuizRequest _value;

  @override
  DriverVerifyQuizRequest quizVerified(bool quizVerified) =>
      call(quizVerified: quizVerified);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverVerifyQuizRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverVerifyQuizRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverVerifyQuizRequest call({
    Object? quizVerified = const $CopyWithPlaceholder(),
  }) {
    return DriverVerifyQuizRequest(
      quizVerified:
          quizVerified == const $CopyWithPlaceholder() || quizVerified == null
          ? _value.quizVerified
          // ignore: cast_nullable_to_non_nullable
          : quizVerified as bool,
    );
  }
}

extension $DriverVerifyQuizRequestCopyWith on DriverVerifyQuizRequest {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDriverVerifyQuizRequest.copyWith(...)` or `instanceOfDriverVerifyQuizRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DriverVerifyQuizRequestCWProxy get copyWith =>
      _$DriverVerifyQuizRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverVerifyQuizRequest _$DriverVerifyQuizRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('DriverVerifyQuizRequest', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['quizVerified']);
  final val = DriverVerifyQuizRequest(
    quizVerified: $checkedConvert('quizVerified', (v) => v as bool),
  );
  return val;
});

Map<String, dynamic> _$DriverVerifyQuizRequestToJson(
  DriverVerifyQuizRequest instance,
) => <String, dynamic>{'quizVerified': instance.quizVerified};
