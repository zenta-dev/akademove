# auth_client.api.AdminApi

## Load the API package
```dart
import 'package:auth_client/api.dart';
```

All URIs are relative to *http://localhost:3000/auth*

Method | HTTP request | Description
------------- | ------------- | -------------
[**adminHasPermissionPost**](AdminApi.md#adminhaspermissionpost) | **POST** /admin/has-permission | 
[**adminStopImpersonatingPost**](AdminApi.md#adminstopimpersonatingpost) | **POST** /admin/stop-impersonating | 
[**banUser**](AdminApi.md#banuser) | **POST** /admin/ban-user | 
[**createUser**](AdminApi.md#createuser) | **POST** /admin/create-user | 
[**getUser**](AdminApi.md#getuser) | **GET** /admin/get-user | 
[**impersonateUser**](AdminApi.md#impersonateuser) | **POST** /admin/impersonate-user | 
[**listUserSessions**](AdminApi.md#listusersessions) | **POST** /admin/list-user-sessions | 
[**listUsers**](AdminApi.md#listusers) | **GET** /admin/list-users | 
[**removeUser**](AdminApi.md#removeuser) | **POST** /admin/remove-user | 
[**revokeUserSession**](AdminApi.md#revokeusersession) | **POST** /admin/revoke-user-session | 
[**revokeUserSessions**](AdminApi.md#revokeusersessions) | **POST** /admin/revoke-user-sessions | 
[**setRole**](AdminApi.md#setrole) | **POST** /admin/set-role | 
[**setUserPassword**](AdminApi.md#setuserpassword) | **POST** /admin/set-user-password | 
[**unbanUser**](AdminApi.md#unbanuser) | **POST** /admin/unban-user | 
[**updateUser**](AdminApi.md#updateuser) | **POST** /admin/update-user | 


# **adminHasPermissionPost**
> AdminHasPermissionPost200Response adminHasPermissionPost(adminHasPermissionPostRequest)



Check if the user has permission

### Example
```dart
import 'package:auth_client/api.dart';

final api = AuthClient().getAdminApi();
final AdminHasPermissionPostRequest adminHasPermissionPostRequest = ; // AdminHasPermissionPostRequest | 

try {
    final response = api.adminHasPermissionPost(adminHasPermissionPostRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AdminApi->adminHasPermissionPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **adminHasPermissionPostRequest** | [**AdminHasPermissionPostRequest**](AdminHasPermissionPostRequest.md)|  | [optional] 

### Return type

[**AdminHasPermissionPost200Response**](AdminHasPermissionPost200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **adminStopImpersonatingPost**
> adminStopImpersonatingPost()



### Example
```dart
import 'package:auth_client/api.dart';

final api = AuthClient().getAdminApi();

try {
    api.adminStopImpersonatingPost();
} catch on DioException (e) {
    print('Exception when calling AdminApi->adminStopImpersonatingPost: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **banUser**
> SetRole200Response banUser(banUserRequest)



Ban a user

### Example
```dart
import 'package:auth_client/api.dart';

final api = AuthClient().getAdminApi();
final BanUserRequest banUserRequest = ; // BanUserRequest | 

try {
    final response = api.banUser(banUserRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AdminApi->banUser: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **banUserRequest** | [**BanUserRequest**](BanUserRequest.md)|  | 

### Return type

[**SetRole200Response**](SetRole200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createUser**
> SetRole200Response createUser(createUserRequest)



Create a new user

### Example
```dart
import 'package:auth_client/api.dart';

final api = AuthClient().getAdminApi();
final CreateUserRequest createUserRequest = ; // CreateUserRequest | 

try {
    final response = api.createUser(createUserRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AdminApi->createUser: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createUserRequest** | [**CreateUserRequest**](CreateUserRequest.md)|  | 

### Return type

[**SetRole200Response**](SetRole200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getUser**
> SetRole200Response getUser(id)



Get an existing user

### Example
```dart
import 'package:auth_client/api.dart';

final api = AuthClient().getAdminApi();
final String id = id_example; // String | 

try {
    final response = api.getUser(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AdminApi->getUser: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | [optional] 

### Return type

[**SetRole200Response**](SetRole200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **impersonateUser**
> ImpersonateUser200Response impersonateUser(listUserSessionsRequest)



Impersonate a user

### Example
```dart
import 'package:auth_client/api.dart';

final api = AuthClient().getAdminApi();
final ListUserSessionsRequest listUserSessionsRequest = ; // ListUserSessionsRequest | 

try {
    final response = api.impersonateUser(listUserSessionsRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AdminApi->impersonateUser: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **listUserSessionsRequest** | [**ListUserSessionsRequest**](ListUserSessionsRequest.md)|  | 

### Return type

[**ImpersonateUser200Response**](ImpersonateUser200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listUserSessions**
> ListUserSessions200Response listUserSessions(listUserSessionsRequest)



List user sessions

### Example
```dart
import 'package:auth_client/api.dart';

final api = AuthClient().getAdminApi();
final ListUserSessionsRequest listUserSessionsRequest = ; // ListUserSessionsRequest | 

try {
    final response = api.listUserSessions(listUserSessionsRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AdminApi->listUserSessions: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **listUserSessionsRequest** | [**ListUserSessionsRequest**](ListUserSessionsRequest.md)|  | 

### Return type

[**ListUserSessions200Response**](ListUserSessions200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listUsers**
> ListUsers200Response listUsers(searchValue, searchField, searchOperator, limit, offset, sortBy, sortDirection, filterField, filterValue, filterOperator)



List users

### Example
```dart
import 'package:auth_client/api.dart';

final api = AuthClient().getAdminApi();
final String searchValue = searchValue_example; // String | 
final String searchField = searchField_example; // String | 
final String searchOperator = searchOperator_example; // String | 
final String limit = limit_example; // String | 
final String offset = offset_example; // String | 
final String sortBy = sortBy_example; // String | 
final String sortDirection = sortDirection_example; // String | 
final String filterField = filterField_example; // String | 
final String filterValue = filterValue_example; // String | 
final String filterOperator = filterOperator_example; // String | 

try {
    final response = api.listUsers(searchValue, searchField, searchOperator, limit, offset, sortBy, sortDirection, filterField, filterValue, filterOperator);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AdminApi->listUsers: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **searchValue** | **String**|  | [optional] 
 **searchField** | **String**|  | [optional] 
 **searchOperator** | **String**|  | [optional] 
 **limit** | **String**|  | [optional] 
 **offset** | **String**|  | [optional] 
 **sortBy** | **String**|  | [optional] 
 **sortDirection** | **String**|  | [optional] 
 **filterField** | **String**|  | [optional] 
 **filterValue** | **String**|  | [optional] 
 **filterOperator** | **String**|  | [optional] 

### Return type

[**ListUsers200Response**](ListUsers200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **removeUser**
> SignOutPost200Response removeUser(listUserSessionsRequest)



Delete a user and all their sessions and accounts. Cannot be undone.

### Example
```dart
import 'package:auth_client/api.dart';

final api = AuthClient().getAdminApi();
final ListUserSessionsRequest listUserSessionsRequest = ; // ListUserSessionsRequest | 

try {
    final response = api.removeUser(listUserSessionsRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AdminApi->removeUser: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **listUserSessionsRequest** | [**ListUserSessionsRequest**](ListUserSessionsRequest.md)|  | 

### Return type

[**SignOutPost200Response**](SignOutPost200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **revokeUserSession**
> SignOutPost200Response revokeUserSession(revokeUserSessionRequest)



Revoke a user session

### Example
```dart
import 'package:auth_client/api.dart';

final api = AuthClient().getAdminApi();
final RevokeUserSessionRequest revokeUserSessionRequest = ; // RevokeUserSessionRequest | 

try {
    final response = api.revokeUserSession(revokeUserSessionRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AdminApi->revokeUserSession: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **revokeUserSessionRequest** | [**RevokeUserSessionRequest**](RevokeUserSessionRequest.md)|  | 

### Return type

[**SignOutPost200Response**](SignOutPost200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **revokeUserSessions**
> SignOutPost200Response revokeUserSessions(listUserSessionsRequest)



Revoke all user sessions

### Example
```dart
import 'package:auth_client/api.dart';

final api = AuthClient().getAdminApi();
final ListUserSessionsRequest listUserSessionsRequest = ; // ListUserSessionsRequest | 

try {
    final response = api.revokeUserSessions(listUserSessionsRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AdminApi->revokeUserSessions: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **listUserSessionsRequest** | [**ListUserSessionsRequest**](ListUserSessionsRequest.md)|  | 

### Return type

[**SignOutPost200Response**](SignOutPost200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **setRole**
> SetRole200Response setRole(setRoleRequest)



Set the role of a user

### Example
```dart
import 'package:auth_client/api.dart';

final api = AuthClient().getAdminApi();
final SetRoleRequest setRoleRequest = ; // SetRoleRequest | 

try {
    final response = api.setRole(setRoleRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AdminApi->setRole: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **setRoleRequest** | [**SetRoleRequest**](SetRoleRequest.md)|  | 

### Return type

[**SetRole200Response**](SetRole200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **setUserPassword**
> ResetPasswordPost200Response setUserPassword(setUserPasswordRequest)



Set a user's password

### Example
```dart
import 'package:auth_client/api.dart';

final api = AuthClient().getAdminApi();
final SetUserPasswordRequest setUserPasswordRequest = ; // SetUserPasswordRequest | 

try {
    final response = api.setUserPassword(setUserPasswordRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AdminApi->setUserPassword: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **setUserPasswordRequest** | [**SetUserPasswordRequest**](SetUserPasswordRequest.md)|  | 

### Return type

[**ResetPasswordPost200Response**](ResetPasswordPost200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **unbanUser**
> SetRole200Response unbanUser(listUserSessionsRequest)



Unban a user

### Example
```dart
import 'package:auth_client/api.dart';

final api = AuthClient().getAdminApi();
final ListUserSessionsRequest listUserSessionsRequest = ; // ListUserSessionsRequest | 

try {
    final response = api.unbanUser(listUserSessionsRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AdminApi->unbanUser: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **listUserSessionsRequest** | [**ListUserSessionsRequest**](ListUserSessionsRequest.md)|  | 

### Return type

[**SetRole200Response**](SetRole200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateUser**
> SetRole200Response updateUser(updateUserRequest)



Update a user's details

### Example
```dart
import 'package:auth_client/api.dart';

final api = AuthClient().getAdminApi();
final UpdateUserRequest updateUserRequest = ; // UpdateUserRequest | 

try {
    final response = api.updateUser(updateUserRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AdminApi->updateUser: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **updateUserRequest** | [**UpdateUserRequest**](UpdateUserRequest.md)|  | 

### Return type

[**SetRole200Response**](SetRole200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

