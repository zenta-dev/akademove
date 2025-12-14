# api_client.model.InsertCoupon

## Load the model package
```dart
import 'package:api_client/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**name** | **String** |  | 
**code** | **String** |  | 
**couponType** | [**CouponType**](CouponType.md) |  | [optional] [default to CouponType.GENERAL]
**rules** | [**CouponRules**](CouponRules.md) |  | 
**discountAmount** | **num** |  | [optional] 
**discountPercentage** | **num** |  | [optional] 
**usageLimit** | **num** |  | 
**periodStart** | [**DateTime**](DateTime.md) |  | 
**periodEnd** | [**DateTime**](DateTime.md) |  | 
**isActive** | **bool** |  | 
**merchantId** | **String** |  | [optional] 
**serviceTypes** | [**List&lt;OrderType&gt;**](OrderType.md) |  | [optional] 
**eventName** | **String** |  | [optional] 
**eventDescription** | **String** |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


