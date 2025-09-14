# akademove_api.api.ReviewApi

## Load the API package
```dart
import 'package:akademove_api/api.dart';
```

All URIs are relative to *http://localhost:3000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createReview**](ReviewApi.md#createreview) | **POST** /review | 
[**deleteReview**](ReviewApi.md#deletereview) | **DELETE** /review/{id} | 
[**getAllReview**](ReviewApi.md#getallreview) | **GET** /review | 
[**getReviewById**](ReviewApi.md#getreviewbyid) | **GET** /review/{id} | 
[**updateReview**](ReviewApi.md#updatereview) | **PUT** /review/{id} | 


# **createReview**
> CreateReviewSuccessResponse createReview(createReviewRequest)



### Example
```dart
import 'package:akademove_api/api.dart';

final api = AkademoveApi().getReviewApi();
final CreateReviewRequest createReviewRequest = ; // CreateReviewRequest | 

try {
    final response = api.createReview(createReviewRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ReviewApi->createReview: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createReviewRequest** | [**CreateReviewRequest**](CreateReviewRequest.md)|  | [optional] 

### Return type

[**CreateReviewSuccessResponse**](CreateReviewSuccessResponse.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteReview**
> DeleteReviewSuccessResponse deleteReview(id)



### Example
```dart
import 'package:akademove_api/api.dart';

final api = AkademoveApi().getReviewApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.deleteReview(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ReviewApi->deleteReview: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**DeleteReviewSuccessResponse**](DeleteReviewSuccessResponse.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getAllReview**
> GetAllReviewSuccessResponse getAllReview(page, limit, cursor)



### Example
```dart
import 'package:akademove_api/api.dart';

final api = AkademoveApi().getReviewApi();
final int page = 56; // int | 
final int limit = 56; // int | 
final String cursor = cursor_example; // String | 

try {
    final response = api.getAllReview(page, limit, cursor);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ReviewApi->getAllReview: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **page** | **int**|  | 
 **limit** | **int**|  | [default to 10]
 **cursor** | **String**|  | [optional] 

### Return type

[**GetAllReviewSuccessResponse**](GetAllReviewSuccessResponse.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getReviewById**
> GetReviewByIdSuccessResponse getReviewById(id, fromCache)



### Example
```dart
import 'package:akademove_api/api.dart';

final api = AkademoveApi().getReviewApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final bool fromCache = true; // bool | 

try {
    final response = api.getReviewById(id, fromCache);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ReviewApi->getReviewById: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **fromCache** | **bool**|  | [default to false]

### Return type

[**GetReviewByIdSuccessResponse**](GetReviewByIdSuccessResponse.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateReview**
> UpdateReviewSuccessResponse updateReview(id, createReviewRequest)



### Example
```dart
import 'package:akademove_api/api.dart';

final api = AkademoveApi().getReviewApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final CreateReviewRequest createReviewRequest = ; // CreateReviewRequest | 

try {
    final response = api.updateReview(id, createReviewRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ReviewApi->updateReview: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **createReviewRequest** | [**CreateReviewRequest**](CreateReviewRequest.md)|  | [optional] 

### Return type

[**UpdateReviewSuccessResponse**](UpdateReviewSuccessResponse.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

