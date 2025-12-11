# api_client.api.ReviewApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *http://10.86.19.105:3000/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**reviewCheckCanReview**](ReviewApi.md#reviewcheckcanreview) | **GET** /reviews/can-review/{orderId} | 
[**reviewCreate**](ReviewApi.md#reviewcreate) | **POST** /reviews | 
[**reviewGet**](ReviewApi.md#reviewget) | **GET** /reviews/{id} | 
[**reviewGetByOrder**](ReviewApi.md#reviewgetbyorder) | **GET** /reviews/order/{orderId} | 
[**reviewList**](ReviewApi.md#reviewlist) | **GET** /reviews | 
[**reviewRemove**](ReviewApi.md#reviewremove) | **DELETE** /reviews/{id} | 
[**reviewUpdate**](ReviewApi.md#reviewupdate) | **PUT** /reviews/{id} | 


# **reviewCheckCanReview**
> ReviewCheckCanReview200Response reviewCheckCanReview(orderId)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getReviewApi();
final String orderId = orderId_example; // String | 

try {
    final response = api.reviewCheckCanReview(orderId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ReviewApi->reviewCheckCanReview: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **orderId** | **String**|  | 

### Return type

[**ReviewCheckCanReview200Response**](ReviewCheckCanReview200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **reviewCreate**
> ReviewCreate200Response reviewCreate(insertReview)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getReviewApi();
final InsertReview insertReview = ; // InsertReview | 

try {
    final response = api.reviewCreate(insertReview);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ReviewApi->reviewCreate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **insertReview** | [**InsertReview**](InsertReview.md)|  | 

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

# **reviewGetByOrder**
> ReviewList200Response reviewGetByOrder(orderId)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getReviewApi();
final String orderId = orderId_example; // String | 

try {
    final response = api.reviewGetByOrder(orderId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ReviewApi->reviewGetByOrder: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **orderId** | **String**|  | 

### Return type

[**ReviewList200Response**](ReviewList200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **reviewList**
> ReviewList200Response reviewList(cursor, limit, direction, page, query, sortBy, order, mode)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getReviewApi();
final String cursor = cursor_example; // String | 
final Object limit = ; // Object | 
final String direction = direction_example; // String | 
final Object page = ; // Object | 
final String query = query_example; // String | 
final String sortBy = sortBy_example; // String | 
final PaginationOrder order = ; // PaginationOrder | 
final PaginationMode mode = ; // PaginationMode | 

try {
    final response = api.reviewList(cursor, limit, direction, page, query, sortBy, order, mode);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ReviewApi->reviewList: $e\n');
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

[**ReviewList200Response**](ReviewList200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **reviewRemove**
> BadgeRemove200Response reviewRemove(id)



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

[**BadgeRemove200Response**](BadgeRemove200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **reviewUpdate**
> ReviewCreate200Response reviewUpdate(id, updateReview)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getReviewApi();
final String id = id_example; // String | 
final UpdateReview updateReview = ; // UpdateReview | 

try {
    final response = api.reviewUpdate(id, updateReview);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ReviewApi->reviewUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **updateReview** | [**UpdateReview**](UpdateReview.md)|  | 

### Return type

[**ReviewCreate200Response**](ReviewCreate200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

