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
**type** | [**OrderType**](OrderType.md) |  | 
**status** | [**OrderStatus**](OrderStatus.md) |  | 
**pickupLocation** | [**Coordinate**](Coordinate.md) |  | 
**dropoffLocation** | [**Coordinate**](Coordinate.md) |  | 
**pickupAddress** | **String** |  | [optional] 
**dropoffAddress** | **String** |  | [optional] 
**distanceKm** | **num** |  | 
**basePrice** | **num** |  | 
**tip** | **num** |  | [optional] 
**totalPrice** | **num** |  | 
**platformCommission** | **num** |  | [optional] 
**driverEarning** | **num** |  | [optional] 
**merchantCommission** | **num** |  | [optional] 
**couponId** | **String** |  | [optional] 
**couponCode** | **String** |  | [optional] 
**discountAmount** | **num** |  | [optional] 
**note** | [**OrderNote**](OrderNote.md) |  | [optional] 
**requestedAt** | [**DateTime**](DateTime.md) |  | 
**acceptedAt** | [**DateTime**](DateTime.md) |  | [optional] 
**preparedAt** | [**DateTime**](DateTime.md) |  | [optional] 
**readyAt** | [**DateTime**](DateTime.md) |  | [optional] 
**arrivedAt** | [**DateTime**](DateTime.md) |  | [optional] 
**cancelReason** | **String** |  | [optional] 
**createdAt** | [**DateTime**](DateTime.md) |  | 
**updatedAt** | [**DateTime**](DateTime.md) |  | 
**gender** | [**UserGender**](UserGender.md) |  | [optional] 
**genderPreference** | **String** |  | [optional] 
**scheduledAt** | [**DateTime**](DateTime.md) |  | [optional] 
**scheduledMatchingAt** | [**DateTime**](DateTime.md) |  | [optional] 
**proofOfDeliveryUrl** | **String** |  | [optional] 
**deliveryOtp** | **String** |  | [optional] 
**otpVerifiedAt** | [**DateTime**](DateTime.md) |  | [optional] 
**itemCount** | **int** |  | [optional] 
**items** | [**List&lt;OrderItem&gt;**](OrderItem.md) |  | [optional] 
**deliveryItemType** | [**DeliveryItemType**](DeliveryItemType.md) |  | [optional] 
**user** | [**DriverUser**](DriverUser.md) |  | [optional] 
**driver** | [**OrderDriver**](OrderDriver.md) |  | [optional] 
**merchant** | [**OrderMerchant**](OrderMerchant.md) |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


