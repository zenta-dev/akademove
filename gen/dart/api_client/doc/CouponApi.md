# api_client.api.CouponApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *http://10.86.19.105:3000/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**couponActivate**](CouponApi.md#couponactivate) | **POST** /coupons/{id}/activate | 
[**couponCreate**](CouponApi.md#couponcreate) | **POST** /coupons | 
[**couponDeactivate**](CouponApi.md#coupondeactivate) | **POST** /coupons/{id}/deactivate | 
[**couponGet**](CouponApi.md#couponget) | **GET** /coupons/{id} | 
[**couponGetEligibleCoupons**](CouponApi.md#coupongeteligiblecoupons) | **POST** /coupons/eligible | 
[**couponList**](CouponApi.md#couponlist) | **GET** /coupons | 
[**couponRemove**](CouponApi.md#couponremove) | **DELETE** /coupons/{id} | 
[**couponUpdate**](CouponApi.md#couponupdate) | **PUT** /coupons/{id} | 
[**couponValidate**](CouponApi.md#couponvalidate) | **POST** /coupons/validate | 


# **couponActivate**
> CouponCreate200Response couponActivate(id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getCouponApi();
final String id = id_example; // String | 

try {
    final response = api.couponActivate(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling CouponApi->couponActivate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**CouponCreate200Response**](CouponCreate200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **couponCreate**
> CouponCreate200Response couponCreate(insertCoupon)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getCouponApi();
final InsertCoupon insertCoupon = ; // InsertCoupon | 

try {
    final response = api.couponCreate(insertCoupon);
    print(response);
} catch on DioException (e) {
    print('Exception when calling CouponApi->couponCreate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **insertCoupon** | [**InsertCoupon**](InsertCoupon.md)|  | 

### Return type

[**CouponCreate200Response**](CouponCreate200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **couponDeactivate**
> CouponCreate200Response couponDeactivate(id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getCouponApi();
final String id = id_example; // String | 

try {
    final response = api.couponDeactivate(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling CouponApi->couponDeactivate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**CouponCreate200Response**](CouponCreate200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **couponGet**
> CouponCreate200Response couponGet(id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getCouponApi();
final String id = id_example; // String | 

try {
    final response = api.couponGet(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling CouponApi->couponGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**CouponCreate200Response**](CouponCreate200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **couponGetEligibleCoupons**
> CouponGetEligibleCoupons200Response couponGetEligibleCoupons(couponGetEligibleCouponsRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getCouponApi();
final CouponGetEligibleCouponsRequest couponGetEligibleCouponsRequest = ; // CouponGetEligibleCouponsRequest | 

try {
    final response = api.couponGetEligibleCoupons(couponGetEligibleCouponsRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling CouponApi->couponGetEligibleCoupons: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **couponGetEligibleCouponsRequest** | [**CouponGetEligibleCouponsRequest**](CouponGetEligibleCouponsRequest.md)|  | 

### Return type

[**CouponGetEligibleCoupons200Response**](CouponGetEligibleCoupons200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **couponList**
> CouponList200Response couponList(cursor, limit, direction, page, query, sortBy, order, mode)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getCouponApi();
final String cursor = cursor_example; // String | 
final Object limit = ; // Object | 
final String direction = direction_example; // String | 
final Object page = ; // Object | 
final String query = query_example; // String | 
final String sortBy = sortBy_example; // String | 
final PaginationOrder order = ; // PaginationOrder | 
final PaginationMode mode = ; // PaginationMode | 

try {
    final response = api.couponList(cursor, limit, direction, page, query, sortBy, order, mode);
    print(response);
} catch on DioException (e) {
    print('Exception when calling CouponApi->couponList: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **cursor** | **String**|  | [optional] 
 **limit** | [**Object**](.md)|  | [optional] 
 **direction** | **String**|  | [optional] 
 **page** | [**Object**](.md)|  | [optional] 
 **query** | **String**|  | [optional] 
 **sortBy** | **String**|  | [optional] 
 **order** | [**PaginationOrder**](.md)|  | [optional] [default to desc]
 **mode** | [**PaginationMode**](.md)|  | [optional] [default to offset]

### Return type

[**CouponList200Response**](CouponList200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **couponRemove**
> BadgeRemove200Response couponRemove(id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getCouponApi();
final String id = id_example; // String | 

try {
    final response = api.couponRemove(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling CouponApi->couponRemove: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**BadgeRemove200Response**](BadgeRemove200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **couponUpdate**
> CouponCreate200Response couponUpdate(id, updateCoupon)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getCouponApi();
final String id = id_example; // String | 
final UpdateCoupon updateCoupon = ; // UpdateCoupon | 

try {
    final response = api.couponUpdate(id, updateCoupon);
    print(response);
} catch on DioException (e) {
    print('Exception when calling CouponApi->couponUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **updateCoupon** | [**UpdateCoupon**](UpdateCoupon.md)|  | 

### Return type

[**CouponCreate200Response**](CouponCreate200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **couponValidate**
> CouponValidate200Response couponValidate(couponValidateRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getCouponApi();
final CouponValidateRequest couponValidateRequest = ; // CouponValidateRequest | 

try {
    final response = api.couponValidate(couponValidateRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling CouponApi->couponValidate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **couponValidateRequest** | [**CouponValidateRequest**](CouponValidateRequest.md)|  | 

### Return type

[**CouponValidate200Response**](CouponValidate200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

