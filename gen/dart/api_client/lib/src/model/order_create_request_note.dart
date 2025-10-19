//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'order_create_request_note.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OrderCreateRequestNote {
  /// Returns a new [OrderCreateRequestNote] instance.
  OrderCreateRequestNote({

     this.pickup,

     this.dropoff,
  });

  @JsonKey(
    
    name: r'pickup',
    required: false,
    includeIfNull: false,
  )


  final String? pickup;



  @JsonKey(
    
    name: r'dropoff',
    required: false,
    includeIfNull: false,
  )


  final String? dropoff;





    @override
    bool operator ==(Object other) => identical(this, other) || other is OrderCreateRequestNote &&
      other.pickup == pickup &&
      other.dropoff == dropoff;

    @override
    int get hashCode =>
        pickup.hashCode +
        dropoff.hashCode;

  factory OrderCreateRequestNote.fromJson(Map<String, dynamic> json) => _$OrderCreateRequestNoteFromJson(json);

  Map<String, dynamic> toJson() => _$OrderCreateRequestNoteToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

