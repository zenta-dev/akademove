//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/support_chat_envelope_payload.dart';
import 'package:api_client/src/model/support_chat_envelope_action.dart';
import 'package:api_client/src/model/support_chat_envelope_event.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'support_chat_envelope.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class SupportChatEnvelope {
  /// Returns a new [SupportChatEnvelope] instance.
  const SupportChatEnvelope({
     this.e,
     this.a,
    required this.f,
    required this.t,
    required this.p,
  });
  @JsonKey(name: r'e', required: false, includeIfNull: false)
  final SupportChatEnvelopeEvent? e;
  
  @JsonKey(name: r'a', required: false, includeIfNull: false)
  final SupportChatEnvelopeAction? a;
  
  @JsonKey(name: r'f', required: true, includeIfNull: false)
  final SupportChatEnvelopeFEnum f;
  
  @JsonKey(name: r't', required: true, includeIfNull: false)
  final SupportChatEnvelopeTEnum t;
  
  @JsonKey(name: r'p', required: true, includeIfNull: false)
  final SupportChatEnvelopePayload p;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is SupportChatEnvelope &&
    other.e == e &&
    other.a == a &&
    other.f == f &&
    other.t == t &&
    other.p == p;

  @override
  int get hashCode =>
      e.hashCode +
      a.hashCode +
      f.hashCode +
      t.hashCode +
      p.hashCode;

  factory SupportChatEnvelope.fromJson(Map<String, dynamic> json) => _$SupportChatEnvelopeFromJson(json);

  Map<String, dynamic> toJson() => _$SupportChatEnvelopeToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

enum SupportChatEnvelopeFEnum {
  @JsonValue(r's')
  s(r's'),
  @JsonValue(r'c')
  c(r'c');
  
  const SupportChatEnvelopeFEnum(this.value);
  
  final String value;
  
  @override
  String toString() => value;
}

enum SupportChatEnvelopeTEnum {
  @JsonValue(r's')
  s(r's'),
  @JsonValue(r'c')
  c(r'c');
  
  const SupportChatEnvelopeTEnum(this.value);
  
  final String value;
  
  @override
  String toString() => value;
}

