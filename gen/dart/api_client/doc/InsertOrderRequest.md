# api_client.model.InsertOrderRequest

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
**note** | [**OrderNote**](OrderNote.md) |  | [optional] 
**itemCount** | **num** |  | [optional] 
**items** | [**List&lt;OrderItem&gt;**](OrderItem.md) |  | [optional] 
**user** | [**InsertOrderRequestUser**](InsertOrderRequestUser.md) |  | [optional] 
**driver** | [**InsertOrderRequestDriver**](InsertOrderRequestDriver.md) |  | [optional] 
**merchant** | [**InsertOrderRequestMerchant**](InsertOrderRequestMerchant.md) |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


