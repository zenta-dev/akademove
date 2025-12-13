//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';


enum SupportChatEnvelopeEvent {
      @JsonValue(r'NEW_MESSAGE')
      NEW_MESSAGE(r'NEW_MESSAGE'),
      @JsonValue(r'MESSAGE_READ')
      MESSAGE_READ(r'MESSAGE_READ'),
      @JsonValue(r'TICKET_UPDATED')
      TICKET_UPDATED(r'TICKET_UPDATED'),
      @JsonValue(r'TICKET_ASSIGNED')
      TICKET_ASSIGNED(r'TICKET_ASSIGNED'),
      @JsonValue(r'TICKET_CLOSED')
      TICKET_CLOSED(r'TICKET_CLOSED'),
      @JsonValue(r'TYPING')
      TYPING(r'TYPING');

  const SupportChatEnvelopeEvent(this.value);

  final String value;

  @override
  String toString() => value;
}
