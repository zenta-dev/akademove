//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';


enum SupportChatEnvelopeAction {
      @JsonValue(r'SEND_MESSAGE')
      SEND_MESSAGE(r'SEND_MESSAGE'),
      @JsonValue(r'MARK_READ')
      MARK_READ(r'MARK_READ'),
      @JsonValue(r'START_TYPING')
      START_TYPING(r'START_TYPING'),
      @JsonValue(r'STOP_TYPING')
      STOP_TYPING(r'STOP_TYPING');

  const SupportChatEnvelopeAction(this.value);

  final String value;

  @override
  String toString() => value;
}
