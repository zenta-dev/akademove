# api_client.api.ConfigurationApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *http://localhost:3000/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**auditList**](ConfigurationApi.md#auditlist) | **GET** /audit-logs | 
[**bannerCreate**](ConfigurationApi.md#bannercreate) | **POST** /banners | 
[**bannerDelete**](ConfigurationApi.md#bannerdelete) | **DELETE** /banners/{id} | 
[**bannerGet**](ConfigurationApi.md#bannerget) | **GET** /banners/{id} | 
[**bannerList**](ConfigurationApi.md#bannerlist) | **GET** /banners | 
[**bannerListPublic**](ConfigurationApi.md#bannerlistpublic) | **GET** /banners/public | 
[**bannerToggleActive**](ConfigurationApi.md#bannertoggleactive) | **PATCH** /banners/{id}/toggle | 
[**bannerUpdate**](ConfigurationApi.md#bannerupdate) | **PUT** /banners/{id} | 
[**configurationGet**](ConfigurationApi.md#configurationget) | **GET** /configurations/{key} | 
[**configurationGetBusinessConfig**](ConfigurationApi.md#configurationgetbusinessconfig) | **GET** /configurations/business | 
[**configurationList**](ConfigurationApi.md#configurationlist) | **GET** /configurations | 
[**configurationUpdate**](ConfigurationApi.md#configurationupdate) | **PUT** /configurations/{key} | 


# **auditList**
> AuditList200Response auditList(cursor, limit, direction, page, query, sortBy, order, mode, tableName, recordId, operation, updatedById, startDate, endDate)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getConfigurationApi();
final String cursor = cursor_example; // String | 
final Object limit = ; // Object | 
final String direction = direction_example; // String | 
final Object page = ; // Object | 
final String query = query_example; // String | 
final String sortBy = sortBy_example; // String | 
final PaginationOrder order = ; // PaginationOrder | 
final PaginationMode mode = ; // PaginationMode | 
final String tableName = tableName_example; // String | 
final String recordId = recordId_example; // String | 
final String operation = operation_example; // String | 
final String updatedById = updatedById_example; // String | 
final DateTime startDate = 2013-10-20T19:20:30+01:00; // DateTime | 
final DateTime endDate = 2013-10-20T19:20:30+01:00; // DateTime | 

try {
    final response = api.auditList(cursor, limit, direction, page, query, sortBy, order, mode, tableName, recordId, operation, updatedById, startDate, endDate);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ConfigurationApi->auditList: $e\n');
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
 **tableName** | **String**|  | [optional] 
 **recordId** | **String**|  | [optional] 
 **operation** | **String**|  | [optional] 
 **updatedById** | **String**|  | [optional] 
 **startDate** | **DateTime**|  | [optional] 
 **endDate** | **DateTime**|  | [optional] 

### Return type

[**AuditList200Response**](AuditList200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **bannerCreate**
> BannerCreate201Response bannerCreate(bannerCreateRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getConfigurationApi();
final BannerCreateRequest bannerCreateRequest = ; // BannerCreateRequest | 

try {
    final response = api.bannerCreate(bannerCreateRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ConfigurationApi->bannerCreate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bannerCreateRequest** | [**BannerCreateRequest**](BannerCreateRequest.md)|  | 

### Return type

[**BannerCreate201Response**](BannerCreate201Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **bannerDelete**
> BannerDelete200Response bannerDelete(id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getConfigurationApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.bannerDelete(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ConfigurationApi->bannerDelete: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**BannerDelete200Response**](BannerDelete200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **bannerGet**
> BannerCreate201Response bannerGet(id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getConfigurationApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.bannerGet(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ConfigurationApi->bannerGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**BannerCreate201Response**](BannerCreate201Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **bannerList**
> BannerList200Response bannerList(cursor, limit, direction, page, query, sortBy, order, mode, placement, targetAudience, isActive, search)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getConfigurationApi();
final String cursor = cursor_example; // String | 
final Object limit = ; // Object | 
final String direction = direction_example; // String | 
final Object page = ; // Object | 
final String query = query_example; // String | 
final String sortBy = sortBy_example; // String | 
final PaginationOrder order = ; // PaginationOrder | 
final PaginationMode mode = ; // PaginationMode | 
final String placement = placement_example; // String | 
final String targetAudience = targetAudience_example; // String | 
final bool isActive = true; // bool | 
final String search = search_example; // String | 

try {
    final response = api.bannerList(cursor, limit, direction, page, query, sortBy, order, mode, placement, targetAudience, isActive, search);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ConfigurationApi->bannerList: $e\n');
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
 **placement** | **String**|  | [optional] 
 **targetAudience** | **String**|  | [optional] 
 **isActive** | **bool**|  | [optional] 
 **search** | **String**|  | [optional] 

### Return type

[**BannerList200Response**](BannerList200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **bannerListPublic**
> BannerListPublic200Response bannerListPublic(placement)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getConfigurationApi();
final String placement = placement_example; // String | 

try {
    final response = api.bannerListPublic(placement);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ConfigurationApi->bannerListPublic: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **placement** | **String**|  | [optional] 

### Return type

[**BannerListPublic200Response**](BannerListPublic200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **bannerToggleActive**
> BannerCreate201Response bannerToggleActive(id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getConfigurationApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.bannerToggleActive(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ConfigurationApi->bannerToggleActive: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**BannerCreate201Response**](BannerCreate201Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **bannerUpdate**
> BannerCreate201Response bannerUpdate(id, bannerUpdateRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getConfigurationApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final BannerUpdateRequest bannerUpdateRequest = ; // BannerUpdateRequest | 

try {
    final response = api.bannerUpdate(id, bannerUpdateRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ConfigurationApi->bannerUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **bannerUpdateRequest** | [**BannerUpdateRequest**](BannerUpdateRequest.md)|  | 

### Return type

[**BannerCreate201Response**](BannerCreate201Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **configurationGet**
> ConfigurationGet200Response configurationGet(key)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getConfigurationApi();
final String key = key_example; // String | 

try {
    final response = api.configurationGet(key);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ConfigurationApi->configurationGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **key** | **String**|  | 

### Return type

[**ConfigurationGet200Response**](ConfigurationGet200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **configurationGetBusinessConfig**
> ConfigurationGetBusinessConfig200Response configurationGetBusinessConfig()



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getConfigurationApi();

try {
    final response = api.configurationGetBusinessConfig();
    print(response);
} catch on DioException (e) {
    print('Exception when calling ConfigurationApi->configurationGetBusinessConfig: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**ConfigurationGetBusinessConfig200Response**](ConfigurationGetBusinessConfig200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **configurationList**
> ConfigurationList200Response configurationList(cursor, limit, direction, page, query, sortBy, order, mode)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getConfigurationApi();
final String cursor = cursor_example; // String | 
final Object limit = ; // Object | 
final String direction = direction_example; // String | 
final Object page = ; // Object | 
final String query = query_example; // String | 
final String sortBy = sortBy_example; // String | 
final PaginationOrder order = ; // PaginationOrder | 
final PaginationMode mode = ; // PaginationMode | 

try {
    final response = api.configurationList(cursor, limit, direction, page, query, sortBy, order, mode);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ConfigurationApi->configurationList: $e\n');
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

[**ConfigurationList200Response**](ConfigurationList200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **configurationUpdate**
> ConfigurationGet200Response configurationUpdate(key, updateConfiguration)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getConfigurationApi();
final String key = key_example; // String | 
final UpdateConfiguration updateConfiguration = ; // UpdateConfiguration | 

try {
    final response = api.configurationUpdate(key, updateConfiguration);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ConfigurationApi->configurationUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **key** | **String**|  | 
 **updateConfiguration** | [**UpdateConfiguration**](UpdateConfiguration.md)|  | 

### Return type

[**ConfigurationGet200Response**](ConfigurationGet200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

