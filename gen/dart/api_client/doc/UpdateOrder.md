# api_client.model.UpdateOrder

## Load the model package
```dart
import 'package:api_client/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**driverId** | **String** |  | [optional] 
**merchantId** | **String** |  | [optional] 
**type** | [**OrderType**](OrderType.md) |  | [optional] 
**status** | [**OrderStatus**](OrderStatus.md) |  | [optional] 
**distanceKm** | **num** |  | [optional] 
**tip** | **num** |  | [optional] 
**totalPrice** | **num** |  | [optional] 
**note** | [**OrderNote**](OrderNote.md) |  | [optional] 
**cancelReason** | **String** |  | [optional] 
**gender** | [**UserGender**](UserGender.md) |  | [optional] 
**itemCount** | **num** |  | [optional] 
**items** | [**List&lt;OrderItem&gt;**](OrderItem.md) |  | [optional] 
**user** | [**OrderPlaceOrder200ResponseDataUser**](OrderPlaceOrder200ResponseDataUser.md) |  | [optional] 
**driver** | [**OrderPlaceOrder200ResponseDataDriver**](OrderPlaceOrder200ResponseDataDriver.md) |  | [optional] 
**merchant** | [**OrderPlaceOrder200ResponseDataMerchant**](OrderPlaceOrder200ResponseDataMerchant.md) |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


