# api_client.api.MerchantApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *http://localhost:3000/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**analyticsExportMerchantAnalytics**](MerchantApi.md#analyticsexportmerchantanalytics) | **GET** /analytics/merchant/{merchantId}/export | 
[**merchantActivate**](MerchantApi.md#merchantactivate) | **POST** /merchants/{id}/activate | 
[**merchantAnalytics**](MerchantApi.md#merchantanalytics) | **GET** /merchants/{id}/analytics | 
[**merchantBestSellers**](MerchantApi.md#merchantbestsellers) | **GET** /merchants/best-sellers | 
[**merchantDeactivate**](MerchantApi.md#merchantdeactivate) | **PATCH** /merchants/{id}/deactivate | 
[**merchantGet**](MerchantApi.md#merchantget) | **GET** /merchants/{id} | 
[**merchantGetAvailabilityStatus**](MerchantApi.md#merchantgetavailabilitystatus) | **GET** /merchants/{id}/availability/status | 
[**merchantGetMine**](MerchantApi.md#merchantgetmine) | **GET** /merchants/mine | 
[**merchantGetReview**](MerchantApi.md#merchantgetreview) | **GET** /merchants/{id}/approval-review | 
[**merchantList**](MerchantApi.md#merchantlist) | **GET** /merchants | 
[**merchantMenuCreate**](MerchantApi.md#merchantmenucreate) | **POST** /merchants/{merchantId}/menus | 
[**merchantMenuGet**](MerchantApi.md#merchantmenuget) | **GET** /merchants/{merchantId}/menus/{id} | 
[**merchantMenuList**](MerchantApi.md#merchantmenulist) | **GET** /merchants/{merchantId}/menus | 
[**merchantMenuRemove**](MerchantApi.md#merchantmenuremove) | **DELETE** /merchants/{merchantId}/menus/{id} | 
[**merchantMenuUpdate**](MerchantApi.md#merchantmenuupdate) | **PUT** /merchants/{merchantId}/menus/{id} | 
[**merchantOrderAccept**](MerchantApi.md#merchantorderaccept) | **POST** /merchants/{merchantId}/orders/orders/{id}/accept | 
[**merchantOrderMarkPreparing**](MerchantApi.md#merchantordermarkpreparing) | **PUT** /merchants/{merchantId}/orders/orders/{id}/preparing | 
[**merchantOrderMarkReady**](MerchantApi.md#merchantordermarkready) | **PUT** /merchants/{merchantId}/orders/orders/{id}/ready | 
[**merchantOrderReject**](MerchantApi.md#merchantorderreject) | **POST** /merchants/{merchantId}/orders/orders/{id}/reject | 
[**merchantPopulars**](MerchantApi.md#merchantpopulars) | **GET** /merchants/populars | 
[**merchantRemove**](MerchantApi.md#merchantremove) | **DELETE** /merchants/{id} | 
[**merchantSetOnlineStatus**](MerchantApi.md#merchantsetonlinestatus) | **PATCH** /merchants/{id}/availability/online | 
[**merchantSetOperatingStatus**](MerchantApi.md#merchantsetoperatingstatus) | **PATCH** /merchants/{id}/availability/operating-status | 
[**merchantSetOrderTakingStatus**](MerchantApi.md#merchantsetordertakingstatus) | **PATCH** /merchants/{id}/availability/order-taking | 
[**merchantSubmitApproval**](MerchantApi.md#merchantsubmitapproval) | **POST** /merchants/{id}/approval-review/submit-approval | 
[**merchantSubmitRejection**](MerchantApi.md#merchantsubmitrejection) | **POST** /merchants/{id}/approval-review/submit-rejection | 
[**merchantUpdate**](MerchantApi.md#merchantupdate) | **PUT** /merchants/{id} | 
[**merchantUpdateDocumentStatus**](MerchantApi.md#merchantupdatedocumentstatus) | **POST** /merchants/{id}/approval-review/update-document | 


# **analyticsExportMerchantAnalytics**
> String analyticsExportMerchantAnalytics(merchantId, startDate, endDate)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMerchantApi();
final String merchantId = merchantId_example; // String | 
final DateTime startDate = 2013-10-20T19:20:30+01:00; // DateTime | 
final DateTime endDate = 2013-10-20T19:20:30+01:00; // DateTime | 

try {
    final response = api.analyticsExportMerchantAnalytics(merchantId, startDate, endDate);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MerchantApi->analyticsExportMerchantAnalytics: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **merchantId** | **String**|  | 
 **startDate** | **DateTime**|  | 
 **endDate** | **DateTime**|  | 

### Return type

**String**

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **merchantActivate**
> MerchantGetMine200ResponseBody merchantActivate(id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMerchantApi();
final String id = id_example; // String | 

try {
    final response = api.merchantActivate(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MerchantApi->merchantActivate: $e\n');
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

# **merchantAnalytics**
> MerchantAnalytics200Response merchantAnalytics(id, period, startDate, endDate)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMerchantApi();
final String id = id_example; // String | 
final String period = period_example; // String | 
final DateTime startDate = 2013-10-20T19:20:30+01:00; // DateTime | 
final DateTime endDate = 2013-10-20T19:20:30+01:00; // DateTime | 

try {
    final response = api.merchantAnalytics(id, period, startDate, endDate);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MerchantApi->merchantAnalytics: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **period** | **String**|  | [optional] 
 **startDate** | **DateTime**|  | [optional] 
 **endDate** | **DateTime**|  | [optional] 

### Return type

[**MerchantAnalytics200Response**](MerchantAnalytics200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **merchantBestSellers**
> MerchantBestSellers200Response merchantBestSellers(limit, category)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMerchantApi();
final num limit = 8.14; // num | 
final String category = category_example; // String | 

try {
    final response = api.merchantBestSellers(limit, category);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MerchantApi->merchantBestSellers: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **limit** | **num**|  | 
 **category** | **String**|  | [optional] 

### Return type

[**MerchantBestSellers200Response**](MerchantBestSellers200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **merchantDeactivate**
> MerchantGetMine200ResponseBody merchantDeactivate(id, merchantDeactivateRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMerchantApi();
final String id = id_example; // String | 
final MerchantDeactivateRequest merchantDeactivateRequest = ; // MerchantDeactivateRequest | 

try {
    final response = api.merchantDeactivate(id, merchantDeactivateRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MerchantApi->merchantDeactivate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **merchantDeactivateRequest** | [**MerchantDeactivateRequest**](MerchantDeactivateRequest.md)|  | 

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

# **merchantGetAvailabilityStatus**
> MerchantGetAvailabilityStatus200Response merchantGetAvailabilityStatus(id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMerchantApi();
final String id = id_example; // String | 

try {
    final response = api.merchantGetAvailabilityStatus(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MerchantApi->merchantGetAvailabilityStatus: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**MerchantGetAvailabilityStatus200Response**](MerchantGetAvailabilityStatus200Response.md)

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

# **merchantGetReview**
> MerchantGetReview200Response merchantGetReview(id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMerchantApi();
final String id = id_example; // String | 

try {
    final response = api.merchantGetReview(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MerchantApi->merchantGetReview: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**MerchantGetReview200Response**](MerchantGetReview200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **merchantList**
> MerchantPopulars200Response merchantList(cursor, limit, direction, page, query, sortBy, order, mode, categories, isActive, minRating, maxRating, maxDistance, latitude, longitude)



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
final Object categories = ; // Object | 
final Object isActive = ; // Object | 
final num minRating = 8.14; // num | 
final num maxRating = 8.14; // num | 
final num maxDistance = 8.14; // num | 
final num latitude = 8.14; // num | 
final num longitude = 8.14; // num | 

try {
    final response = api.merchantList(cursor, limit, direction, page, query, sortBy, order, mode, categories, isActive, minRating, maxRating, maxDistance, latitude, longitude);
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
 **categories** | [**Object**](.md)|  | [optional] 
 **isActive** | [**Object**](.md)|  | [optional] 
 **minRating** | **num**|  | [optional] 
 **maxRating** | **num**|  | [optional] 
 **maxDistance** | **num**|  | [optional] 
 **latitude** | **num**|  | [optional] 
 **longitude** | **num**|  | [optional] 

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

# **merchantOrderAccept**
> MerchantOrderAccept200Response merchantOrderAccept(merchantId, id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMerchantApi();
final String merchantId = merchantId_example; // String | 
final String id = id_example; // String | 

try {
    final response = api.merchantOrderAccept(merchantId, id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MerchantApi->merchantOrderAccept: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **merchantId** | **String**|  | 
 **id** | **String**|  | 

### Return type

[**MerchantOrderAccept200Response**](MerchantOrderAccept200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **merchantOrderMarkPreparing**
> MerchantOrderAccept200Response merchantOrderMarkPreparing(merchantId, id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMerchantApi();
final String merchantId = merchantId_example; // String | 
final String id = id_example; // String | 

try {
    final response = api.merchantOrderMarkPreparing(merchantId, id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MerchantApi->merchantOrderMarkPreparing: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **merchantId** | **String**|  | 
 **id** | **String**|  | 

### Return type

[**MerchantOrderAccept200Response**](MerchantOrderAccept200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **merchantOrderMarkReady**
> MerchantOrderAccept200Response merchantOrderMarkReady(merchantId, id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMerchantApi();
final String merchantId = merchantId_example; // String | 
final String id = id_example; // String | 

try {
    final response = api.merchantOrderMarkReady(merchantId, id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MerchantApi->merchantOrderMarkReady: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **merchantId** | **String**|  | 
 **id** | **String**|  | 

### Return type

[**MerchantOrderAccept200Response**](MerchantOrderAccept200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **merchantOrderReject**
> MerchantOrderAccept200Response merchantOrderReject(merchantId, id, reason, note)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMerchantApi();
final String merchantId = merchantId_example; // String | 
final String id = id_example; // String | 
final String reason = reason_example; // String | 
final String note = note_example; // String | 

try {
    final response = api.merchantOrderReject(merchantId, id, reason, note);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MerchantApi->merchantOrderReject: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **merchantId** | **String**|  | 
 **id** | **String**|  | 
 **reason** | **String**|  | 
 **note** | **String**|  | [optional] 

### Return type

[**MerchantOrderAccept200Response**](MerchantOrderAccept200Response.md)

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

# **merchantSetOnlineStatus**
> MerchantGetMine200ResponseBody merchantSetOnlineStatus(id, driverUpdateOnlineStatusRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMerchantApi();
final String id = id_example; // String | 
final DriverUpdateOnlineStatusRequest driverUpdateOnlineStatusRequest = ; // DriverUpdateOnlineStatusRequest | 

try {
    final response = api.merchantSetOnlineStatus(id, driverUpdateOnlineStatusRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MerchantApi->merchantSetOnlineStatus: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **driverUpdateOnlineStatusRequest** | [**DriverUpdateOnlineStatusRequest**](DriverUpdateOnlineStatusRequest.md)|  | 

### Return type

[**MerchantGetMine200ResponseBody**](MerchantGetMine200ResponseBody.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **merchantSetOperatingStatus**
> MerchantGetMine200ResponseBody merchantSetOperatingStatus(id, merchantSetOperatingStatusRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMerchantApi();
final String id = id_example; // String | 
final MerchantSetOperatingStatusRequest merchantSetOperatingStatusRequest = ; // MerchantSetOperatingStatusRequest | 

try {
    final response = api.merchantSetOperatingStatus(id, merchantSetOperatingStatusRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MerchantApi->merchantSetOperatingStatus: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **merchantSetOperatingStatusRequest** | [**MerchantSetOperatingStatusRequest**](MerchantSetOperatingStatusRequest.md)|  | 

### Return type

[**MerchantGetMine200ResponseBody**](MerchantGetMine200ResponseBody.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **merchantSetOrderTakingStatus**
> MerchantGetMine200ResponseBody merchantSetOrderTakingStatus(id, merchantSetOrderTakingStatusRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMerchantApi();
final String id = id_example; // String | 
final MerchantSetOrderTakingStatusRequest merchantSetOrderTakingStatusRequest = ; // MerchantSetOrderTakingStatusRequest | 

try {
    final response = api.merchantSetOrderTakingStatus(id, merchantSetOrderTakingStatusRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MerchantApi->merchantSetOrderTakingStatus: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **merchantSetOrderTakingStatusRequest** | [**MerchantSetOrderTakingStatusRequest**](MerchantSetOrderTakingStatusRequest.md)|  | 

### Return type

[**MerchantGetMine200ResponseBody**](MerchantGetMine200ResponseBody.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **merchantSubmitApproval**
> MerchantGetReview200Response merchantSubmitApproval(id, driverSubmitApprovalRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMerchantApi();
final String id = id_example; // String | 
final DriverSubmitApprovalRequest driverSubmitApprovalRequest = ; // DriverSubmitApprovalRequest | 

try {
    final response = api.merchantSubmitApproval(id, driverSubmitApprovalRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MerchantApi->merchantSubmitApproval: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **driverSubmitApprovalRequest** | [**DriverSubmitApprovalRequest**](DriverSubmitApprovalRequest.md)|  | 

### Return type

[**MerchantGetReview200Response**](MerchantGetReview200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **merchantSubmitRejection**
> MerchantGetReview200Response merchantSubmitRejection(id, driverSubmitRejectionRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMerchantApi();
final String id = id_example; // String | 
final DriverSubmitRejectionRequest driverSubmitRejectionRequest = ; // DriverSubmitRejectionRequest | 

try {
    final response = api.merchantSubmitRejection(id, driverSubmitRejectionRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MerchantApi->merchantSubmitRejection: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **driverSubmitRejectionRequest** | [**DriverSubmitRejectionRequest**](DriverSubmitRejectionRequest.md)|  | 

### Return type

[**MerchantGetReview200Response**](MerchantGetReview200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **merchantUpdate**
> MerchantGetMine200ResponseBody merchantUpdate(id, phoneCountryCode, phoneNumber, locationX, locationY, bankProvider, bankNumber, name, email, address, category, document, image)



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
final String category = category_example; // String | Primary merchant category
final MultipartFile document = BINARY_DATA_HERE; // MultipartFile | 
final MultipartFile image = BINARY_DATA_HERE; // MultipartFile | 

try {
    final response = api.merchantUpdate(id, phoneCountryCode, phoneNumber, locationX, locationY, bankProvider, bankNumber, name, email, address, category, document, image);
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
 **category** | **String**| Primary merchant category | [optional] 
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

# **merchantUpdateDocumentStatus**
> MerchantGetReview200Response merchantUpdateDocumentStatus(id, merchantUpdateDocumentStatusRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getMerchantApi();
final String id = id_example; // String | 
final MerchantUpdateDocumentStatusRequest merchantUpdateDocumentStatusRequest = ; // MerchantUpdateDocumentStatusRequest | 

try {
    final response = api.merchantUpdateDocumentStatus(id, merchantUpdateDocumentStatusRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MerchantApi->merchantUpdateDocumentStatus: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **merchantUpdateDocumentStatusRequest** | [**MerchantUpdateDocumentStatusRequest**](MerchantUpdateDocumentStatusRequest.md)|  | 

### Return type

[**MerchantGetReview200Response**](MerchantGetReview200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

