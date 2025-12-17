// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_cart_attachment_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UpdateCartAttachmentRequestCWProxy {
  UpdateCartAttachmentRequest attachmentUrl(String? attachmentUrl);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UpdateCartAttachmentRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UpdateCartAttachmentRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  UpdateCartAttachmentRequest call({String? attachmentUrl});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfUpdateCartAttachmentRequest.copyWith(...)` or call `instanceOfUpdateCartAttachmentRequest.copyWith.fieldName(value)` for a single field.
class _$UpdateCartAttachmentRequestCWProxyImpl
    implements _$UpdateCartAttachmentRequestCWProxy {
  const _$UpdateCartAttachmentRequestCWProxyImpl(this._value);

  final UpdateCartAttachmentRequest _value;

  @override
  UpdateCartAttachmentRequest attachmentUrl(String? attachmentUrl) =>
      call(attachmentUrl: attachmentUrl);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UpdateCartAttachmentRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UpdateCartAttachmentRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  UpdateCartAttachmentRequest call({
    Object? attachmentUrl = const $CopyWithPlaceholder(),
  }) {
    return UpdateCartAttachmentRequest(
      attachmentUrl: attachmentUrl == const $CopyWithPlaceholder()
          ? _value.attachmentUrl
          // ignore: cast_nullable_to_non_nullable
          : attachmentUrl as String?,
    );
  }
}

extension $UpdateCartAttachmentRequestCopyWith on UpdateCartAttachmentRequest {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfUpdateCartAttachmentRequest.copyWith(...)` or `instanceOfUpdateCartAttachmentRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UpdateCartAttachmentRequestCWProxy get copyWith =>
      _$UpdateCartAttachmentRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateCartAttachmentRequest _$UpdateCartAttachmentRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('UpdateCartAttachmentRequest', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['attachmentUrl']);
  final val = UpdateCartAttachmentRequest(
    attachmentUrl: $checkedConvert('attachmentUrl', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$UpdateCartAttachmentRequestToJson(
  UpdateCartAttachmentRequest instance,
) => <String, dynamic>{'attachmentUrl': instance.attachmentUrl};
