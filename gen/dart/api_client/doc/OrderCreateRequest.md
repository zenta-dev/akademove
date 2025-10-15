# api_client.model.OrderCreateRequest

## Load the model package
```dart
import 'package:api_client/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
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
**user** | [**OrderCreateRequestUser**](OrderCreateRequestUser.md) |  | [optional] 
**driver** | [**OrderCreateRequestDriver**](OrderCreateRequestDriver.md) |  | [optional] 
**merchant** | [**OrderCreateRequestMerchant**](OrderCreateRequestMerchant.md) |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


