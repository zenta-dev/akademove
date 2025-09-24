# api_client.model.Order

## Load the model package
```dart
import 'package:api_client/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **String** |  | 
**userId** | **String** |  | 
**driverId** | **String** |  | [optional] 
**merchantId** | **String** |  | [optional] 
**type** | **String** |  | 
**status** | **String** |  | 
**pickupLocation** | [**Location**](Location.md) |  | 
**dropoffLocation** | [**Location**](Location.md) |  | 
**distanceKm** | **num** |  | 
**basePrice** | **num** |  | 
**tip** | **num** |  | [optional] 
**totalPrice** | **num** |  | 
**note** | [**OrderCreateRequestNote**](OrderCreateRequestNote.md) |  | [optional] 
**requestedAt** | **num** | unix timestamp format | 
**acceptedAt** | **num** | unix timestamp format | [optional] 
**arrivedAt** | **num** | unix timestamp format | [optional] 
**createdAt** | **num** | unix timestamp format | 
**updatedAt** | **num** | unix timestamp format | 
**user** | [**DriverUpdateRequestUser**](DriverUpdateRequestUser.md) |  | [optional] 
**driver** | [**OrderCreateRequestDriver**](OrderCreateRequestDriver.md) |  | [optional] 
**merchant** | [**OrderCreateRequestMerchant**](OrderCreateRequestMerchant.md) |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


