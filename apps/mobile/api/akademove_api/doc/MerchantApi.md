# akademove_api.api.MerchantApi

## Load the API package
```dart
import 'package:akademove_api/api.dart';
```

All URIs are relative to *http://localhost:3000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createMerchant**](MerchantApi.md#createmerchant) | **POST** /merchants | 
[**deleteMerchant**](MerchantApi.md#deletemerchant) | **DELETE** /merchants/{id} | 
[**getAllMerchant**](MerchantApi.md#getallmerchant) | **GET** /merchants | 
[**getMerchantById**](MerchantApi.md#getmerchantbyid) | **GET** /merchants/{id} | 
[**updateMerchant**](MerchantApi.md#updatemerchant) | **PUT** /merchants/{id} | 


# **createMerchant**
> CreateMerchantSuccessResponse createMerchant(createMerchantRequest)



### Example
```dart
import 'package:akademove_api/api.dart';

final api = AkademoveApi().getMerchantApi();
final CreateMerchantRequest createMerchantRequest = ; // CreateMerchantRequest | 

try {
    final response = api.createMerchant(createMerchantRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MerchantApi->createMerchant: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createMerchantRequest** | [**CreateMerchantRequest**](CreateMerchantRequest.md)|  | [optional] 

### Return type

[**CreateMerchantSuccessResponse**](CreateMerchantSuccessResponse.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteMerchant**
> DeleteMerchantSuccessResponse deleteMerchant(id)



### Example
```dart
import 'package:akademove_api/api.dart';

final api = AkademoveApi().getMerchantApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.deleteMerchant(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MerchantApi->deleteMerchant: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**DeleteMerchantSuccessResponse**](DeleteMerchantSuccessResponse.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getAllMerchant**
> GetAllMerchantSuccessResponse getAllMerchant(page, limit, cursor)



### Example
```dart
import 'package:akademove_api/api.dart';

final api = AkademoveApi().getMerchantApi();
final int page = 56; // int | 
final int limit = 56; // int | 
final String cursor = cursor_example; // String | 

try {
    final response = api.getAllMerchant(page, limit, cursor);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MerchantApi->getAllMerchant: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **page** | **int**|  | 
 **limit** | **int**|  | [default to 10]
 **cursor** | **String**|  | [optional] 

### Return type

[**GetAllMerchantSuccessResponse**](GetAllMerchantSuccessResponse.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMerchantById**
> GetMerchantByIdSuccessResponse getMerchantById(id, fromCache)



### Example
```dart
import 'package:akademove_api/api.dart';

final api = AkademoveApi().getMerchantApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final bool fromCache = true; // bool | 

try {
    final response = api.getMerchantById(id, fromCache);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MerchantApi->getMerchantById: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **fromCache** | **bool**|  | [default to false]

### Return type

[**GetMerchantByIdSuccessResponse**](GetMerchantByIdSuccessResponse.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateMerchant**
> UpdateMerchantSuccessResponse updateMerchant(id, createMerchantRequest)



### Example
```dart
import 'package:akademove_api/api.dart';

final api = AkademoveApi().getMerchantApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final CreateMerchantRequest createMerchantRequest = ; // CreateMerchantRequest | 

try {
    final response = api.updateMerchant(id, createMerchantRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MerchantApi->updateMerchant: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **createMerchantRequest** | [**CreateMerchantRequest**](CreateMerchantRequest.md)|  | [optional] 

### Return type

[**UpdateMerchantSuccessResponse**](UpdateMerchantSuccessResponse.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

