# akademove_api.api.PromoApi

## Load the API package
```dart
import 'package:akademove_api/api.dart';
```

All URIs are relative to *http://localhost:3000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createPromo**](PromoApi.md#createpromo) | **POST** /promos | 
[**deletePromo**](PromoApi.md#deletepromo) | **DELETE** /promos/{id} | 
[**getAllPromo**](PromoApi.md#getallpromo) | **GET** /promos | 
[**getPromoById**](PromoApi.md#getpromobyid) | **GET** /promos/{id} | 
[**updatePromo**](PromoApi.md#updatepromo) | **PUT** /promos/{id} | 


# **createPromo**
> CreatePromoSuccessResponse createPromo(createPromoRequest)



### Example
```dart
import 'package:akademove_api/api.dart';

final api = AkademoveApi().getPromoApi();
final CreatePromoRequest createPromoRequest = ; // CreatePromoRequest | 

try {
    final response = api.createPromo(createPromoRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling PromoApi->createPromo: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createPromoRequest** | [**CreatePromoRequest**](CreatePromoRequest.md)|  | [optional] 

### Return type

[**CreatePromoSuccessResponse**](CreatePromoSuccessResponse.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deletePromo**
> DeletePromoSuccessResponse deletePromo(id)



### Example
```dart
import 'package:akademove_api/api.dart';

final api = AkademoveApi().getPromoApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.deletePromo(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling PromoApi->deletePromo: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**DeletePromoSuccessResponse**](DeletePromoSuccessResponse.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getAllPromo**
> GetAllPromoSuccessResponse getAllPromo(page, limit, cursor)



### Example
```dart
import 'package:akademove_api/api.dart';

final api = AkademoveApi().getPromoApi();
final int page = 56; // int | 
final int limit = 56; // int | 
final String cursor = cursor_example; // String | 

try {
    final response = api.getAllPromo(page, limit, cursor);
    print(response);
} catch on DioException (e) {
    print('Exception when calling PromoApi->getAllPromo: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **page** | **int**|  | 
 **limit** | **int**|  | [default to 10]
 **cursor** | **String**|  | [optional] 

### Return type

[**GetAllPromoSuccessResponse**](GetAllPromoSuccessResponse.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getPromoById**
> GetPromoByIdSuccessResponse getPromoById(id, fromCache)



### Example
```dart
import 'package:akademove_api/api.dart';

final api = AkademoveApi().getPromoApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final bool fromCache = true; // bool | 

try {
    final response = api.getPromoById(id, fromCache);
    print(response);
} catch on DioException (e) {
    print('Exception when calling PromoApi->getPromoById: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **fromCache** | **bool**|  | [default to false]

### Return type

[**GetPromoByIdSuccessResponse**](GetPromoByIdSuccessResponse.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updatePromo**
> UpdatePromoSuccessResponse updatePromo(id, createPromoRequest)



### Example
```dart
import 'package:akademove_api/api.dart';

final api = AkademoveApi().getPromoApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final CreatePromoRequest createPromoRequest = ; // CreatePromoRequest | 

try {
    final response = api.updatePromo(id, createPromoRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling PromoApi->updatePromo: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **createPromoRequest** | [**CreatePromoRequest**](CreatePromoRequest.md)|  | [optional] 

### Return type

[**UpdatePromoSuccessResponse**](UpdatePromoSuccessResponse.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

