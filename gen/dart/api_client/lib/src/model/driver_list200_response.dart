//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/driver.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'driver_list200_response.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DriverList200Response {
  /// Returns a new [DriverList200Response] instance.
  DriverList200Response({

    required  this.message,

    required  this.data,

     this.totalPages,
  });

  @JsonKey(
    
    name: r'message',
    required: true,
    includeIfNull: false,
  )


  final String message;



  @JsonKey(
    
    name: r'data',
    required: true,
    includeIfNull: false,
  )


  final List<Driver> data;



  @JsonKey(
    
    name: r'totalPages',
    required: false,
    includeIfNull: false,
  )


  final num? totalPages;





    @override
    bool operator ==(Object other) => identical(this, other) || other is DriverList200Response &&
      other.message == message &&
      other.data == data &&
      other.totalPages == totalPages;

    @override
    int get hashCode =>
        message.hashCode +
        data.hashCode +
        totalPages.hashCode;

  factory DriverList200Response.fromJson(Map<String, dynamic> json) => _$DriverList200ResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DriverList200ResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

