// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_respond_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ContactRespondRequestCWProxy {
  ContactRespondRequest response(String response);

  ContactRespondRequest status(ContactRespondRequestStatusEnum? status);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `ContactRespondRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ContactRespondRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  ContactRespondRequest call({
    String response,
    ContactRespondRequestStatusEnum? status,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfContactRespondRequest.copyWith(...)` or call `instanceOfContactRespondRequest.copyWith.fieldName(value)` for a single field.
class _$ContactRespondRequestCWProxyImpl
    implements _$ContactRespondRequestCWProxy {
  const _$ContactRespondRequestCWProxyImpl(this._value);

  final ContactRespondRequest _value;

  @override
  ContactRespondRequest response(String response) => call(response: response);

  @override
  ContactRespondRequest status(ContactRespondRequestStatusEnum? status) =>
      call(status: status);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `ContactRespondRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ContactRespondRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  ContactRespondRequest call({
    Object? response = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
  }) {
    return ContactRespondRequest(
      response: response == const $CopyWithPlaceholder() || response == null
          ? _value.response
          // ignore: cast_nullable_to_non_nullable
          : response as String,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as ContactRespondRequestStatusEnum?,
    );
  }
}

extension $ContactRespondRequestCopyWith on ContactRespondRequest {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfContactRespondRequest.copyWith(...)` or `instanceOfContactRespondRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ContactRespondRequestCWProxy get copyWith =>
      _$ContactRespondRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactRespondRequest _$ContactRespondRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('ContactRespondRequest', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['response']);
  final val = ContactRespondRequest(
    response: $checkedConvert('response', (v) => v as String),
    status: $checkedConvert(
      'status',
      (v) => $enumDecodeNullable(_$ContactRespondRequestStatusEnumEnumMap, v),
    ),
  );
  return val;
});

Map<String, dynamic> _$ContactRespondRequestToJson(
  ContactRespondRequest instance,
) => <String, dynamic>{
  'response': instance.response,
  'status': ?_$ContactRespondRequestStatusEnumEnumMap[instance.status],
};

const _$ContactRespondRequestStatusEnumEnumMap = {
  ContactRespondRequestStatusEnum.PENDING: 'PENDING',
  ContactRespondRequestStatusEnum.REVIEWING: 'REVIEWING',
  ContactRespondRequestStatusEnum.RESOLVED: 'RESOLVED',
  ContactRespondRequestStatusEnum.CLOSED: 'CLOSED',
};
