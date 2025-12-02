# api_client.api.AdminApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *http://localhost:3000/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**contactDelete**](AdminApi.md#contactdelete) | **DELETE** /contacts/{id} | 
[**contactGetById**](AdminApi.md#contactgetbyid) | **GET** /contacts/{id} | 
[**contactList**](AdminApi.md#contactlist) | **GET** /contacts | 
[**contactUpdate**](AdminApi.md#contactupdate) | **PUT** /contacts/{id} | 
[**userAdminCreate**](AdminApi.md#useradmincreate) | **POST** /users/admin | 
[**userAdminDashboardStats**](AdminApi.md#useradmindashboardstats) | **GET** /users/admin/dashboard-stats | 
[**userAdminGet**](AdminApi.md#useradminget) | **GET** /users/admin/{id} | 
[**userAdminList**](AdminApi.md#useradminlist) | **GET** /users/admin | 
[**userAdminRemove**](AdminApi.md#useradminremove) | **DELETE** /users/admin/{id} | 
[**userAdminUpdate**](AdminApi.md#useradminupdate) | **PUT** /users/admin/{id} | 


# **contactDelete**
> AuthSignOut200Response contactDelete(id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.contactDelete(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AdminApi->contactDelete: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**AuthSignOut200Response**](AuthSignOut200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **contactGetById**
> ContactSubmit201Response contactGetById(id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.contactGetById(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AdminApi->contactGetById: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**ContactSubmit201Response**](ContactSubmit201Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **contactList**
> ContactList200Response contactList(page, limit, status, search)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminApi();
final int page = 56; // int | 
final int limit = 56; // int | 
final String status = status_example; // String | 
final String search = search_example; // String | 

try {
    final response = api.contactList(page, limit, status, search);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AdminApi->contactList: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **page** | **int**|  | [optional] 
 **limit** | **int**|  | [optional] 
 **status** | **String**|  | [optional] 
 **search** | **String**|  | [optional] 

### Return type

[**ContactList200Response**](ContactList200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **contactUpdate**
> ContactSubmit201Response contactUpdate(id, updateContact)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final UpdateContact updateContact = ; // UpdateContact | 

try {
    final response = api.contactUpdate(id, updateContact);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AdminApi->contactUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **updateContact** | [**UpdateContact**](UpdateContact.md)|  | 

### Return type

[**ContactSubmit201Response**](ContactSubmit201Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

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

