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
**driverId** | **String** |  | 
**merchantId** | **String** |  | 
**type** | **String** |  | 
**status** | **String** |  | 
**pickupLocation** | [**Location**](Location.md) |  | 
**dropoffLocation** | [**Location**](Location.md) |  | 
**distanceKm** | **num** |  | 
**basePrice** | **num** |  | 
**tip** | **num** |  | [optional] [default to 0]
**totalPrice** | **num** |  | 
**note** | [**CreateOrderRequestNote**](CreateOrderRequestNote.md) |  | 
**requestedAt** | **num** | unix timestamp format | 
**acceptedAt** | **num** | unix timestamp format | 
**arrivedAt** | **num** | unix timestamp format | 
**createdAt** | **num** | unix timestamp format | 
**updatedAt** | **num** | unix timestamp format | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


