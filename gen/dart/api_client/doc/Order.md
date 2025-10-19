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
**requestedAt** | [**DateTime**](DateTime.md) |  | 
**acceptedAt** | [**DateTime**](DateTime.md) |  | [optional] 
**arrivedAt** | [**DateTime**](DateTime.md) |  | [optional] 
**createdAt** | [**DateTime**](DateTime.md) |  | 
**updatedAt** | [**DateTime**](DateTime.md) |  | 
**itemCount** | **num** |  | [optional] 
**items** | [**List&lt;OrderCreateRequestItemsInner&gt;**](OrderCreateRequestItemsInner.md) |  | [optional] 
**user** | [**OrderCreateRequestUser**](OrderCreateRequestUser.md) |  | [optional] 
**driver** | [**OrderCreateRequestDriver**](OrderCreateRequestDriver.md) |  | [optional] 
**merchant** | [**OrderCreateRequestMerchant**](OrderCreateRequestMerchant.md) |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


