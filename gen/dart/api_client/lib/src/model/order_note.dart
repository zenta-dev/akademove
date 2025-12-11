//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'order_note.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OrderNote {
  /// Returns a new [OrderNote] instance.
  const OrderNote({
     this.pickup,
     this.senderName,
     this.senderPhone,
     this.dropoff,
     this.recevierName,
     this.recevierPhone,
  });
  @JsonKey(name: r'pickup', required: false, includeIfNull: false)
  final String? pickup;
  
  @JsonKey(name: r'senderName', required: false, includeIfNull: false)
  final String? senderName;
  
  @JsonKey(name: r'senderPhone', required: false, includeIfNull: false)
  final String? senderPhone;
  
  @JsonKey(name: r'dropoff', required: false, includeIfNull: false)
  final String? dropoff;
  
  @JsonKey(name: r'recevierName', required: false, includeIfNull: false)
  final String? recevierName;
  
  @JsonKey(name: r'recevierPhone', required: false, includeIfNull: false)
  final String? recevierPhone;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is OrderNote &&
    other.pickup == pickup &&
    other.senderName == senderName &&
    other.senderPhone == senderPhone &&
    other.dropoff == dropoff &&
    other.recevierName == recevierName &&
    other.recevierPhone == recevierPhone;

  @override
  int get hashCode =>
      pickup.hashCode +
      senderName.hashCode +
      senderPhone.hashCode +
      dropoff.hashCode +
      recevierName.hashCode +
      recevierPhone.hashCode;

  factory OrderNote.fromJson(Map<String, dynamic> json) => _$OrderNoteFromJson(json);

  Map<String, dynamic> toJson() => _$OrderNoteToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

