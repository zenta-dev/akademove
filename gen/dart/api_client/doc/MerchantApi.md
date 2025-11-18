# api_client.api.MerchantApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *http://localhost:3000/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**merchantGet**](MerchantApi.md#merchantget) | **GET** /merchants/{id} | 
[**merchantGetMine**](MerchantApi.md#merchantgetmine) | **GET** /merchants/mine | 
[**merchantList**](MerchantApi.md#merchantlist) | **GET** /merchants | 
[**merchantMenuCreate**](MerchantApi.md#merchantmenucreate) | **POST** /merchants/{merchantId}/menus | 
[**merchantMenuGet**](MerchantApi.md#merchantmenuget) | **GET** /merchants/{merchantId}/menus/{id} | 
[**merchantMenuList**](MerchantApi.md#merchantmenulist) | **GET** /merchants/{merchantId}/menus | 
[**merchantMenuRemove**](MerchantApi.md#merchantmenuremove) | **DELETE** /merchants/{merchantId}/menus/{id} | 
[**merchantMenuUpdate**](MerchantApi.md#merchantmenuupdate) | **PUT** /merchants/{merchantId}/menus/{id} | 
[**merchantPopulars**](MerchantApi.md#merchantpopulars) | **GET** /merchants/populars | 
[**merchantRemove**](MerchantApi.md#merchantremove) | **DELETE** /merchants/{id} | 
[**merchantUpdate**](MerchantApi.md#merchantupdate) | **PUT** /merchants/{id} | 


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
> MerchantPopulars200Response merchantList(cursor, limit, direction, page, query, sortBy, order, mode)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMerchantApi();
final String cursor = cursor_example; // String | 
final Object limit = ; // Object | 
final String direction = direction_example; // String | 
final Object page = ; // Object | 
final String query = query_example; // String | 
final String sortBy = sortBy_example; // String | 
final PaginationOrder order = ; // PaginationOrder | 
final PaginationMode mode = ; // PaginationMode | 

try {
    final response = api.merchantList(cursor, limit, direction, page, query, sortBy, order, mode);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MerchantApi->merchantList: $e\n');
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

[**MerchantPopulars200Response**](MerchantPopulars200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **merchantMenuCreate**
> MerchantMenuCreate200Response merchantMenuCreate(merchantId, name, price, stock, category, image)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMerchantApi();
final String merchantId = merchantId_example; // String | 
final String name = name_example; // String | 
final num price = 8.14; // num | 
final int stock = 56; // int | 
final String category = category_example; // String | 
final MultipartFile image = BINARY_DATA_HERE; // MultipartFile | 

try {
    final response = api.merchantMenuCreate(merchantId, name, price, stock, category, image);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MerchantApi->merchantMenuCreate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **merchantId** | **String**|  | 
 **name** | **String**|  | 
 **price** | **num**|  | 
 **stock** | **int**|  | 
 **category** | **String**|  | [optional] 
 **image** | **MultipartFile**|  | [optional] 

### Return type

[**MerchantMenuCreate200Response**](MerchantMenuCreate200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: multipart/form-data
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
> MerchantMenuList200Response merchantMenuList(merchantId, cursor, limit, direction, page, query, sortBy, order, mode)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMerchantApi();
final String merchantId = merchantId_example; // String | 
final String cursor = cursor_example; // String | 
final Object limit = ; // Object | 
final String direction = direction_example; // String | 
final Object page = ; // Object | 
final String query = query_example; // String | 
final String sortBy = sortBy_example; // String | 
final PaginationOrder order = ; // PaginationOrder | 
final PaginationMode mode = ; // PaginationMode | 

try {
    final response = api.merchantMenuList(merchantId, cursor, limit, direction, page, query, sortBy, order, mode);
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
 **limit** | [**Object**](.md)|  | [optional] 
 **direction** | **String**|  | [optional] 
 **page** | [**Object**](.md)|  | [optional] 
 **query** | **String**|  | [optional] 
 **sortBy** | **String**|  | [optional] 
 **order** | [**PaginationOrder**](.md)|  | [optional] [default to desc]
 **mode** | [**PaginationMode**](.md)|  | [optional] [default to offset]

### Return type

[**MerchantMenuList200Response**](MerchantMenuList200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **merchantMenuRemove**
> BadgeRemove200Response merchantMenuRemove(merchantId, id)



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

[**BadgeRemove200Response**](BadgeRemove200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **merchantMenuUpdate**
> MerchantMenuCreate200Response merchantMenuUpdate(merchantId, id, name, category, price, stock, image)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMerchantApi();
final String merchantId = merchantId_example; // String | 
final String id = id_example; // String | 
final String name = name_example; // String | 
final String category = category_example; // String | 
final num price = 8.14; // num | 
final int stock = 56; // int | 
final MultipartFile image = BINARY_DATA_HERE; // MultipartFile | 

try {
    final response = api.merchantMenuUpdate(merchantId, id, name, category, price, stock, image);
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
 **name** | **String**|  | [optional] 
 **category** | **String**|  | [optional] 
 **price** | **num**|  | [optional] 
 **stock** | **int**|  | [optional] 
 **image** | **MultipartFile**|  | [optional] 

### Return type

[**MerchantMenuCreate200Response**](MerchantMenuCreate200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **merchantPopulars**
> MerchantPopulars200Response merchantPopulars(cursor, limit, direction, page, query, sortBy, order, mode)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMerchantApi();
final String cursor = cursor_example; // String | 
final Object limit = ; // Object | 
final String direction = direction_example; // String | 
final Object page = ; // Object | 
final String query = query_example; // String | 
final String sortBy = sortBy_example; // String | 
final PaginationOrder order = ; // PaginationOrder | 
final PaginationMode mode = ; // PaginationMode | 

try {
    final response = api.merchantPopulars(cursor, limit, direction, page, query, sortBy, order, mode);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MerchantApi->merchantPopulars: $e\n');
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

[**MerchantPopulars200Response**](MerchantPopulars200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **merchantRemove**
> BadgeRemove200Response merchantRemove(id)



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

[**BadgeRemove200Response**](BadgeRemove200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **merchantUpdate**
> MerchantGetMine200ResponseBody merchantUpdate(id, phoneCountryCode, phoneNumber, locationX, locationY, bankProvider, bankNumber, name, email, address, document, image)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMerchantApi();
final String id = id_example; // String | 
final String phoneCountryCode = phoneCountryCode_example; // String | 
final int phoneNumber = 56; // int | 
final num locationX = 8.14; // num | Longitude (X-axis, East-West)
final num locationY = 8.14; // num | Latitude (Y-axis, North-South)
final String bankProvider = bankProvider_example; // String | 
final num bankNumber = 8.14; // num | 
final String name = name_example; // String | 
final String email = email_example; // String | 
final String address = address_example; // String | 
final MultipartFile document = BINARY_DATA_HERE; // MultipartFile | 
final MultipartFile image = BINARY_DATA_HERE; // MultipartFile | 

try {
    final response = api.merchantUpdate(id, phoneCountryCode, phoneNumber, locationX, locationY, bankProvider, bankNumber, name, email, address, document, image);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MerchantApi->merchantUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **phoneCountryCode** | **String**|  | 
 **phoneNumber** | **int**|  | 
 **locationX** | **num**| Longitude (X-axis, East-West) | 
 **locationY** | **num**| Latitude (Y-axis, North-South) | 
 **bankProvider** | **String**|  | 
 **bankNumber** | **num**|  | 
 **name** | **String**|  | [optional] 
 **email** | **String**|  | [optional] 
 **address** | **String**|  | [optional] 
 **document** | **MultipartFile**|  | [optional] 
 **image** | **MultipartFile**|  | [optional] 

### Return type

[**MerchantGetMine200ResponseBody**](MerchantGetMine200ResponseBody.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

