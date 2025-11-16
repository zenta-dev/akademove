# api_client.api.BadgeApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *http://localhost:3000/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**badgeCreate**](BadgeApi.md#badgecreate) | **POST** /badges | 
[**badgeGet**](BadgeApi.md#badgeget) | **GET** /badges/{id} | 
[**badgeList**](BadgeApi.md#badgelist) | **GET** /badges | 
[**badgeRemove**](BadgeApi.md#badgeremove) | **DELETE** /badges/{id} | 
[**badgeUpdate**](BadgeApi.md#badgeupdate) | **PUT** /badges/{id} | 
[**badgeUserCreate**](BadgeApi.md#badgeusercreate) | **POST** /badges/user | 
[**badgeUserGet**](BadgeApi.md#badgeuserget) | **GET** /badges/user/{id} | 
[**badgeUserList**](BadgeApi.md#badgeuserlist) | **GET** /badges/user | 
[**badgeUserRemove**](BadgeApi.md#badgeuserremove) | **DELETE** /badges/user/{id} | 
[**badgeUserUpdate**](BadgeApi.md#badgeuserupdate) | **PUT** /badges/user/{id} | 


# **badgeCreate**
> BadgeCreate200Response badgeCreate(badgeCreateRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getBadgeApi();
final BadgeCreateRequest badgeCreateRequest = ; // BadgeCreateRequest | 

try {
    final response = api.badgeCreate(badgeCreateRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling BadgeApi->badgeCreate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **badgeCreateRequest** | [**BadgeCreateRequest**](BadgeCreateRequest.md)|  | 

### Return type

[**BadgeCreate200Response**](BadgeCreate200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **badgeGet**
> BadgeCreate200Response badgeGet(id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getBadgeApi();
final String id = id_example; // String | 

try {
    final response = api.badgeGet(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling BadgeApi->badgeGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**BadgeCreate200Response**](BadgeCreate200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **badgeList**
> BadgeList200Response badgeList(cursor, limit, page, query, sortBy, order)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getBadgeApi();
final String cursor = cursor_example; // String | 
final Object limit = ; // Object | 
final Object page = ; // Object | 
final String query = query_example; // String | 
final String sortBy = sortBy_example; // String | 
final String order = order_example; // String | 

try {
    final response = api.badgeList(cursor, limit, page, query, sortBy, order);
    print(response);
} catch on DioException (e) {
    print('Exception when calling BadgeApi->badgeList: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **cursor** | **String**|  | [optional] 
 **limit** | [**Object**](.md)|  | [optional] 
 **page** | [**Object**](.md)|  | [optional] 
 **query** | **String**|  | [optional] 
 **sortBy** | **String**|  | [optional] 
 **order** | **String**|  | [optional] [default to 'desc']

### Return type

[**BadgeList200Response**](BadgeList200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **badgeRemove**
> BadgeRemove200Response badgeRemove(id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getBadgeApi();
final String id = id_example; // String | 

try {
    final response = api.badgeRemove(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling BadgeApi->badgeRemove: $e\n');
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

# **badgeUpdate**
> BadgeCreate200Response badgeUpdate(id, badgeUpdateRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getBadgeApi();
final String id = id_example; // String | 
final BadgeUpdateRequest badgeUpdateRequest = ; // BadgeUpdateRequest | 

try {
    final response = api.badgeUpdate(id, badgeUpdateRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling BadgeApi->badgeUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **badgeUpdateRequest** | [**BadgeUpdateRequest**](BadgeUpdateRequest.md)|  | 

### Return type

[**BadgeCreate200Response**](BadgeCreate200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **badgeUserCreate**
> BadgeUserCreate200Response badgeUserCreate(badgeUserCreateRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getBadgeApi();
final BadgeUserCreateRequest badgeUserCreateRequest = ; // BadgeUserCreateRequest | 

try {
    final response = api.badgeUserCreate(badgeUserCreateRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling BadgeApi->badgeUserCreate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **badgeUserCreateRequest** | [**BadgeUserCreateRequest**](BadgeUserCreateRequest.md)|  | 

### Return type

[**BadgeUserCreate200Response**](BadgeUserCreate200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **badgeUserGet**
> BadgeUserCreate200Response badgeUserGet(id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getBadgeApi();
final String id = id_example; // String | 

try {
    final response = api.badgeUserGet(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling BadgeApi->badgeUserGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**BadgeUserCreate200Response**](BadgeUserCreate200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **badgeUserList**
> BadgeUserList200Response badgeUserList(cursor, limit, page, query, sortBy, order)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getBadgeApi();
final String cursor = cursor_example; // String | 
final Object limit = ; // Object | 
final Object page = ; // Object | 
final String query = query_example; // String | 
final String sortBy = sortBy_example; // String | 
final String order = order_example; // String | 

try {
    final response = api.badgeUserList(cursor, limit, page, query, sortBy, order);
    print(response);
} catch on DioException (e) {
    print('Exception when calling BadgeApi->badgeUserList: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **cursor** | **String**|  | [optional] 
 **limit** | [**Object**](.md)|  | [optional] 
 **page** | [**Object**](.md)|  | [optional] 
 **query** | **String**|  | [optional] 
 **sortBy** | **String**|  | [optional] 
 **order** | **String**|  | [optional] [default to 'desc']

### Return type

[**BadgeUserList200Response**](BadgeUserList200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **badgeUserRemove**
> BadgeRemove200Response badgeUserRemove(id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getBadgeApi();
final String id = id_example; // String | 

try {
    final response = api.badgeUserRemove(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling BadgeApi->badgeUserRemove: $e\n');
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

# **badgeUserUpdate**
> BadgeUserCreate200Response badgeUserUpdate(id, badgeUserUpdateRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getBadgeApi();
final String id = id_example; // String | 
final BadgeUserUpdateRequest badgeUserUpdateRequest = ; // BadgeUserUpdateRequest | 

try {
    final response = api.badgeUserUpdate(id, badgeUserUpdateRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling BadgeApi->badgeUserUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **badgeUserUpdateRequest** | [**BadgeUserUpdateRequest**](BadgeUserUpdateRequest.md)|  | 

### Return type

[**BadgeUserCreate200Response**](BadgeUserCreate200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

