# api_client.api.MerchantApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *https://akademove-server.zenta.dev/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**merchantCreate**](MerchantApi.md#merchantcreate) | **POST** /merchants | 
[**merchantGet**](MerchantApi.md#merchantget) | **GET** /merchants/{id} | 
[**merchantGetMine**](MerchantApi.md#merchantgetmine) | **GET** /merchants/mine | 
[**merchantList**](MerchantApi.md#merchantlist) | **GET** /merchants | 
[**merchantMenuCreate**](MerchantApi.md#merchantmenucreate) | **POST** /merchants/{merchantId}/menus | 
[**merchantMenuGet**](MerchantApi.md#merchantmenuget) | **GET** /merchants/{merchantId}/menus/{id} | 
[**merchantMenuList**](MerchantApi.md#merchantmenulist) | **GET** /merchants/{merchantId}/menus | 
[**merchantMenuRemove**](MerchantApi.md#merchantmenuremove) | **DELETE** /merchants/{merchantId}/menus/{id} | 
[**merchantMenuUpdate**](MerchantApi.md#merchantmenuupdate) | **PUT** /merchants/{merchantId}/menus/{id} | 
[**merchantRemove**](MerchantApi.md#merchantremove) | **DELETE** /merchants/{id} | 
[**merchantUpdate**](MerchantApi.md#merchantupdate) | **PUT** /merchants/{id} | 


# **merchantCreate**
> MerchantGetMine200ResponseBody merchantCreate(merchantCreateRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMerchantApi();
final MerchantCreateRequest merchantCreateRequest = ; // MerchantCreateRequest | 

try {
    final response = api.merchantCreate(merchantCreateRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MerchantApi->merchantCreate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **merchantCreateRequest** | [**MerchantCreateRequest**](MerchantCreateRequest.md)|  | 

### Return type

[**MerchantGetMine200ResponseBody**](MerchantGetMine200ResponseBody.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **merchantGet**
> MerchantGetMine200ResponseBody merchantGet(id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMerchantApi();
final String id = id_example; // String | 

try {
    final response = api.merchantGet(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MerchantApi->merchantGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**MerchantGetMine200ResponseBody**](MerchantGetMine200ResponseBody.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **merchantGetMine**
> MerchantGetMine200Response merchantGetMine()



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMerchantApi();

try {
    final response = api.merchantGetMine();
    print(response);
} catch on DioException (e) {
    print('Exception when calling MerchantApi->merchantGetMine: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**MerchantGetMine200Response**](MerchantGetMine200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **merchantList**
> MerchantList200Response merchantList(cursor, page, limit)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMerchantApi();
final String cursor = cursor_example; // String | 
final JsonObject page = ; // JsonObject | 
final JsonObject limit = ; // JsonObject | 

try {
    final response = api.merchantList(cursor, page, limit);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MerchantApi->merchantList: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **cursor** | **String**|  | [optional] 
 **page** | [**JsonObject**](.md)|  | [optional] 
 **limit** | [**JsonObject**](.md)|  | [optional] 

### Return type

[**MerchantList200Response**](MerchantList200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **merchantMenuCreate**
> MerchantMenuCreate200Response merchantMenuCreate(merchantId, merchantMenuCreateRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMerchantApi();
final String merchantId = merchantId_example; // String | 
final MerchantMenuCreateRequest merchantMenuCreateRequest = ; // MerchantMenuCreateRequest | 

try {
    final response = api.merchantMenuCreate(merchantId, merchantMenuCreateRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MerchantApi->merchantMenuCreate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **merchantId** | **String**|  | 
 **merchantMenuCreateRequest** | [**MerchantMenuCreateRequest**](MerchantMenuCreateRequest.md)|  | 

### Return type

[**MerchantMenuCreate200Response**](MerchantMenuCreate200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **merchantMenuGet**
> MerchantMenuCreate200Response merchantMenuGet(merchantId, id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMerchantApi();
final String merchantId = merchantId_example; // String | 
final String id = id_example; // String | 

try {
    final response = api.merchantMenuGet(merchantId, id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MerchantApi->merchantMenuGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **merchantId** | **String**|  | 
 **id** | **String**|  | 

### Return type

[**MerchantMenuCreate200Response**](MerchantMenuCreate200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **merchantMenuList**
> MerchantMenuList200Response merchantMenuList(merchantId, cursor, page, limit)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMerchantApi();
final String merchantId = merchantId_example; // String | 
final String cursor = cursor_example; // String | 
final JsonObject page = ; // JsonObject | 
final JsonObject limit = ; // JsonObject | 

try {
    final response = api.merchantMenuList(merchantId, cursor, page, limit);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MerchantApi->merchantMenuList: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **merchantId** | **String**|  | 
 **cursor** | **String**|  | [optional] 
 **page** | [**JsonObject**](.md)|  | [optional] 
 **limit** | [**JsonObject**](.md)|  | [optional] 

### Return type

[**MerchantMenuList200Response**](MerchantMenuList200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **merchantMenuRemove**
> DriverRemove200Response merchantMenuRemove(merchantId, id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMerchantApi();
final String merchantId = merchantId_example; // String | 
final String id = id_example; // String | 

try {
    final response = api.merchantMenuRemove(merchantId, id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MerchantApi->merchantMenuRemove: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **merchantId** | **String**|  | 
 **id** | **String**|  | 

### Return type

[**DriverRemove200Response**](DriverRemove200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **merchantMenuUpdate**
> MerchantMenuCreate200Response merchantMenuUpdate(merchantId, id, merchantMenuUpdateRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMerchantApi();
final String merchantId = merchantId_example; // String | 
final String id = id_example; // String | 
final MerchantMenuUpdateRequest merchantMenuUpdateRequest = ; // MerchantMenuUpdateRequest | 

try {
    final response = api.merchantMenuUpdate(merchantId, id, merchantMenuUpdateRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MerchantApi->merchantMenuUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **merchantId** | **String**|  | 
 **id** | **String**|  | 
 **merchantMenuUpdateRequest** | [**MerchantMenuUpdateRequest**](MerchantMenuUpdateRequest.md)|  | 

### Return type

[**MerchantMenuCreate200Response**](MerchantMenuCreate200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **merchantRemove**
> DriverRemove200Response merchantRemove(id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMerchantApi();
final String id = id_example; // String | 

try {
    final response = api.merchantRemove(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MerchantApi->merchantRemove: $e\n');
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

# **merchantUpdate**
> MerchantGetMine200ResponseBody merchantUpdate(id, merchantUpdateRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMerchantApi();
final String id = id_example; // String | 
final MerchantUpdateRequest merchantUpdateRequest = ; // MerchantUpdateRequest | 

try {
    final response = api.merchantUpdate(id, merchantUpdateRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MerchantApi->merchantUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **merchantUpdateRequest** | [**MerchantUpdateRequest**](MerchantUpdateRequest.md)|  | 

### Return type

[**MerchantGetMine200ResponseBody**](MerchantGetMine200ResponseBody.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

