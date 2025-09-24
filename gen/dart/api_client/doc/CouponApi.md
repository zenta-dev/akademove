# api_client.api.CouponApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://akademove-server.zenta.dev/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**couponCreate**](CouponApi.md#couponcreate) | **POST** /coupons | 
[**couponGet**](CouponApi.md#couponget) | **GET** /coupons/{id} | 
[**couponList**](CouponApi.md#couponlist) | **GET** /coupons | 
[**couponRemove**](CouponApi.md#couponremove) | **DELETE** /coupons/{id} | 
[**couponUpdate**](CouponApi.md#couponupdate) | **PUT** /coupons/{id} | 


# **couponCreate**
> CouponCreate200Response couponCreate(couponCreateRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getCouponApi();
final CouponCreateRequest couponCreateRequest = ; // CouponCreateRequest | 

try {
    final response = api.couponCreate(couponCreateRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling CouponApi->couponCreate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **couponCreateRequest** | [**CouponCreateRequest**](CouponCreateRequest.md)|  | 

### Return type

[**CouponCreate200Response**](CouponCreate200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
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

# **couponList**
> CouponList200Response couponList(cursor, page, limit)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getCouponApi();
final String cursor = cursor_example; // String | 
final JsonObject page = ; // JsonObject | 
final JsonObject limit = ; // JsonObject | 

try {
    final response = api.couponList(cursor, page, limit);
    print(response);
} catch on DioException (e) {
    print('Exception when calling CouponApi->couponList: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **cursor** | **String**|  | [optional] 
 **page** | [**JsonObject**](.md)|  | [optional] 
 **limit** | [**JsonObject**](.md)|  | [optional] 

### Return type

[**CouponList200Response**](CouponList200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **couponRemove**
> DriverRemove200Response couponRemove(id)



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

[**DriverRemove200Response**](DriverRemove200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **couponUpdate**
> CouponCreate200Response couponUpdate(id, couponUpdateRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getCouponApi();
final String id = id_example; // String | 
final CouponUpdateRequest couponUpdateRequest = ; // CouponUpdateRequest | 

try {
    final response = api.couponUpdate(id, couponUpdateRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling CouponApi->couponUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **couponUpdateRequest** | [**CouponUpdateRequest**](CouponUpdateRequest.md)|  | 

### Return type

[**CouponCreate200Response**](CouponCreate200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

