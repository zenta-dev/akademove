# api_client.model.OrderPlaceOrder200ResponseData

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
**type** | [**OrderType**](OrderType.md) |  | 
**status** | [**OrderStatus**](OrderStatus.md) |  | 
**pickupLocation** | [**Coordinate**](Coordinate.md) |  | 
**dropoffLocation** | [**Coordinate**](Coordinate.md) |  | 
**distanceKm** | **num** |  | 
**basePrice** | **num** |  | 
**tip** | **num** |  | [optional] 
**totalPrice** | **num** |  | 
**note** | [**OrderNote**](OrderNote.md) |  | [optional] 
**requestedAt** | [**DateTime**](DateTime.md) |  | 
**acceptedAt** | [**DateTime**](DateTime.md) |  | [optional] 
**arrivedAt** | [**DateTime**](DateTime.md) |  | [optional] 
**cancelReason** | **String** |  | [optional] 
**createdAt** | [**DateTime**](DateTime.md) |  | 
**updatedAt** | [**DateTime**](DateTime.md) |  | 
**gender** | [**UserGender**](UserGender.md) |  | [optional] 
**itemCount** | **num** |  | [optional] 
**items** | [**List&lt;OrderItem&gt;**](OrderItem.md) |  | [optional] 
**user** | [**OrderPlaceOrder200ResponseDataUser**](OrderPlaceOrder200ResponseDataUser.md) |  | [optional] 
**driver** | [**OrderPlaceOrder200ResponseDataDriver**](OrderPlaceOrder200ResponseDataDriver.md) |  | [optional] 
**merchant** | [**OrderPlaceOrder200ResponseDataMerchant**](OrderPlaceOrder200ResponseDataMerchant.md) |  | [optional] 
**payment** | [**Payment**](Payment.md) |  | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


