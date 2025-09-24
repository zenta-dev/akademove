# api_client.api.ReviewApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://akademove-server.zenta.dev/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**reviewCreate**](ReviewApi.md#reviewcreate) | **POST** /reviews | 
[**reviewGet**](ReviewApi.md#reviewget) | **GET** /reviews/{id} | 
[**reviewList**](ReviewApi.md#reviewlist) | **GET** /reviews | 
[**reviewRemove**](ReviewApi.md#reviewremove) | **DELETE** /reviews/{id} | 
[**reviewUpdate**](ReviewApi.md#reviewupdate) | **PUT** /reviews/{id} | 


# **reviewCreate**
> ReviewCreate200Response reviewCreate(reviewCreateRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getReviewApi();
final ReviewCreateRequest reviewCreateRequest = ; // ReviewCreateRequest | 

try {
    final response = api.reviewCreate(reviewCreateRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ReviewApi->reviewCreate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **reviewCreateRequest** | [**ReviewCreateRequest**](ReviewCreateRequest.md)|  | 

### Return type

[**ReviewCreate200Response**](ReviewCreate200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **reviewGet**
> ReviewCreate200Response reviewGet(id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getReviewApi();
final String id = id_example; // String | 

try {
    final response = api.reviewGet(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ReviewApi->reviewGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**ReviewCreate200Response**](ReviewCreate200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **reviewList**
> ReviewList200Response reviewList(cursor, page, limit)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getReviewApi();
final String cursor = cursor_example; // String | 
final JsonObject page = ; // JsonObject | 
final JsonObject limit = ; // JsonObject | 

try {
    final response = api.reviewList(cursor, page, limit);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ReviewApi->reviewList: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **cursor** | **String**|  | [optional] 
 **page** | [**JsonObject**](.md)|  | [optional] 
 **limit** | [**JsonObject**](.md)|  | [optional] 

### Return type

[**ReviewList200Response**](ReviewList200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **reviewRemove**
> DriverRemove200Response reviewRemove(id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getReviewApi();
final String id = id_example; // String | 

try {
    final response = api.reviewRemove(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ReviewApi->reviewRemove: $e\n');
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

# **reviewUpdate**
> ReviewCreate200Response reviewUpdate(id, reviewUpdateRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getReviewApi();
final String id = id_example; // String | 
final ReviewUpdateRequest reviewUpdateRequest = ; // ReviewUpdateRequest | 

try {
    final response = api.reviewUpdate(id, reviewUpdateRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ReviewApi->reviewUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **reviewUpdateRequest** | [**ReviewUpdateRequest**](ReviewUpdateRequest.md)|  | 

### Return type

[**ReviewCreate200Response**](ReviewCreate200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

