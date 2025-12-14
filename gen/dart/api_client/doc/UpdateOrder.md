# api_client.model.UpdateOrder

## Load the model package
```dart
import 'package:api_client/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**driverId** | **String** |  | [optional] 
**completedDriverId** | **String** |  | [optional] 
**merchantId** | **String** |  | [optional] 
**type** | [**OrderType**](OrderType.md) |  | [optional] 
**status** | [**OrderStatus**](OrderStatus.md) |  | [optional] 
**pickupAddress** | **String** |  | [optional] 
**dropoffAddress** | **String** |  | [optional] 
**distanceKm** | **num** |  | [optional] 
**tip** | **num** |  | [optional] 
**totalPrice** | **num** |  | [optional] 
**platformCommission** | **num** |  | [optional] 
**driverEarning** | **num** |  | [optional] 
**merchantCommission** | **num** |  | [optional] 
**couponId** | **String** |  | [optional] 
**couponCode** | **String** |  | [optional] 
**discountAmount** | **num** |  | [optional] 
**note** | [**OrderNote**](OrderNote.md) |  | [optional] 
**cancelReason** | **String** |  | [optional] 
**gender** | [**UserGender**](UserGender.md) |  | [optional] 
**genderPreference** | **String** |  | [optional] 
**scheduledAt** | [**DateTime**](DateTime.md) |  | [optional] 
**scheduledMatchingAt** | [**DateTime**](DateTime.md) |  | [optional] 
**proofOfDeliveryUrl** | **String** |  | [optional] 
**deliveryOtp** | **String** |  | [optional] 
**otpVerifiedAt** | [**DateTime**](DateTime.md) |  | [optional] 
**deliveryItemPhotoUrl** | **String** |  | [optional] 
**itemCount** | **int** |  | [optional] 
**items** | [**List&lt;OrderItem&gt;**](OrderItem.md) |  | [optional] 
**deliveryItemType** | [**DeliveryItemType**](DeliveryItemType.md) |  | [optional] 
**user** | [**DriverUser**](DriverUser.md) |  | [optional] 
**driver** | [**OrderDriver**](OrderDriver.md) |  | [optional] 
**merchant** | [**OrderMerchant**](OrderMerchant.md) |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


