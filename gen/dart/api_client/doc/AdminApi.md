# api_client.api.AdminApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *http://localhost:3000/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**userAdminCreate**](AdminApi.md#useradmincreate) | **POST** /users/admin | 
[**userAdminDashboardStats**](AdminApi.md#useradmindashboardstats) | **GET** /users/admin/dashboard-stats | 
[**userAdminGet**](AdminApi.md#useradminget) | **GET** /users/admin/{id} | 
[**userAdminList**](AdminApi.md#useradminlist) | **GET** /users/admin | 
[**userAdminRemove**](AdminApi.md#useradminremove) | **DELETE** /users/admin/{id} | 
[**userAdminUpdate**](AdminApi.md#useradminupdate) | **PUT** /users/admin/{id} | 


# **userAdminCreate**
> UserAdminCreate200Response userAdminCreate(insertUser)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminApi();
final InsertUser insertUser = ; // InsertUser | 

try {
    final response = api.userAdminCreate(insertUser);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AdminApi->userAdminCreate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **insertUser** | [**InsertUser**](InsertUser.md)|  | 

### Return type

[**UserAdminCreate200Response**](UserAdminCreate200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **userAdminDashboardStats**
> UserAdminDashboardStats200Response userAdminDashboardStats()



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminApi();

try {
    final response = api.userAdminDashboardStats();
    print(response);
} catch on DioException (e) {
    print('Exception when calling AdminApi->userAdminDashboardStats: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**UserAdminDashboardStats200Response**](UserAdminDashboardStats200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **userAdminGet**
> UserAdminCreate200Response userAdminGet(id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminApi();
final String id = id_example; // String | 

try {
    final response = api.userAdminGet(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AdminApi->userAdminGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**UserAdminCreate200Response**](UserAdminCreate200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **userAdminList**
> UserAdminList200Response userAdminList(cursor, limit, direction, page, query, sortBy, order, mode)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminApi();
final String cursor = cursor_example; // String | 
final Object limit = ; // Object | 
final String direction = direction_example; // String | 
final Object page = ; // Object | 
final String query = query_example; // String | 
final String sortBy = sortBy_example; // String | 
final PaginationOrder order = ; // PaginationOrder | 
final PaginationMode mode = ; // PaginationMode | 

try {
    final response = api.userAdminList(cursor, limit, direction, page, query, sortBy, order, mode);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AdminApi->userAdminList: $e\n');
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

[**UserAdminList200Response**](UserAdminList200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **userAdminRemove**
> BadgeRemove200Response userAdminRemove(id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminApi();
final String id = id_example; // String | 

try {
    final response = api.userAdminRemove(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AdminApi->userAdminRemove: $e\n');
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

# **userAdminUpdate**
> UserAdminCreate200Response userAdminUpdate(id, adminUpdateUser)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminApi();
final String id = id_example; // String | 
final AdminUpdateUser adminUpdateUser = ; // AdminUpdateUser | 

try {
    final response = api.userAdminUpdate(id, adminUpdateUser);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AdminApi->userAdminUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **adminUpdateUser** | [**AdminUpdateUser**](AdminUpdateUser.md)|  | 

### Return type

[**UserAdminCreate200Response**](UserAdminCreate200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

