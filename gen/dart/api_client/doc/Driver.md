# api_client.model.Driver

## Load the model package
```dart
import 'package:api_client/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **String** |  | 
**userId** | **String** |  | 
**studentId** | **String** |  | 
**licenseNumber** | **String** |  | 
**status** | **String** |  | [optional] [default to 'pending']
**rating** | **num** |  | 
**isOnline** | **bool** |  | 
**currentLocation** | [**Location**](Location.md) |  | [optional] 
**lastLocationUpdate** | **num** | unix timestamp format | [optional] 
**createdAt** | **num** | unix timestamp format | 
**user** | [**DriverUpdateRequestUser**](DriverUpdateRequestUser.md) |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


