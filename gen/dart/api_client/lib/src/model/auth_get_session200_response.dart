//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/auth_get_session200_response_data.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'auth_get_session200_response.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AuthGetSession200Response {
  /// Returns a new [AuthGetSession200Response] instance.
  AuthGetSession200Response({

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
    includeIfNull: true,
  )


  final AuthGetSession200ResponseData? data;



  @JsonKey(
    
    name: r'totalPages',
    required: false,
    includeIfNull: false,
  )


  final num? totalPages;





    @override
    bool operator ==(Object other) => identical(this, other) || other is AuthGetSession200Response &&
      other.message == message &&
      other.data == data &&
      other.totalPages == totalPages;

    @override
    int get hashCode =>
        message.hashCode +
        (data == null ? 0 : data.hashCode) +
        totalPages.hashCode;

  factory AuthGetSession200Response.fromJson(Map<String, dynamic> json) => _$AuthGetSession200ResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthGetSession200ResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

