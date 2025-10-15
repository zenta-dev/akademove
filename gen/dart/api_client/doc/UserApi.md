# api_client.api.UserApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *http://localhost:3000/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**userCreate**](UserApi.md#usercreate) | **POST** /users | 
[**userGet**](UserApi.md#userget) | **GET** /users/{id} | 
[**userList**](UserApi.md#userlist) | **GET** /users | 
[**userRemove**](UserApi.md#userremove) | **DELETE** /users/{id} | 
[**userUpdate**](UserApi.md#userupdate) | **PUT** /users/{id} | 


# **userCreate**
> UserCreate200Response userCreate(userCreateRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getUserApi();
final UserCreateRequest userCreateRequest = ; // UserCreateRequest | 

try {
    final response = api.userCreate(userCreateRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling UserApi->userCreate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userCreateRequest** | [**UserCreateRequest**](UserCreateRequest.md)|  | 

### Return type

[**UserCreate200Response**](UserCreate200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **userGet**
> UserCreate200Response userGet(id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getUserApi();
final String id = id_example; // String | 

try {
    final response = api.userGet(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling UserApi->userGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**UserCreate200Response**](UserCreate200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **userList**
> UserList200Response userList(cursor, limit, page, query, sortBy, order)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getUserApi();
final String cursor = cursor_example; // String | 
final Object limit = ; // Object | 
final Object page = ; // Object | 
final String query = query_example; // String | 
final String sortBy = sortBy_example; // String | 
final String order = order_example; // String | 

try {
    final response = api.userList(cursor, limit, page, query, sortBy, order);
    print(response);
} catch on DioException (e) {
    print('Exception when calling UserApi->userList: $e\n');
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

[**UserList200Response**](UserList200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **userRemove**
> DriverRemove200Response userRemove(id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getUserApi();
final String id = id_example; // String | 

try {
    final response = api.userRemove(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling UserApi->userRemove: $e\n');
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

# **userUpdate**
> UserCreate200Response userUpdate(id, userUpdateRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getUserApi();
final String id = id_example; // String | 
final UserUpdateRequest userUpdateRequest = ; // UserUpdateRequest | 

try {
    final response = api.userUpdate(id, userUpdateRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling UserApi->userUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **userUpdateRequest** | [**UserUpdateRequest**](UserUpdateRequest.md)|  | 

### Return type

[**UserCreate200Response**](UserCreate200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

