# api_client.api.UserApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *http://localhost:3000/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**contactSubmit**](UserApi.md#contactsubmit) | **POST** /contacts/submit | 
[**userMeChangePassword**](UserApi.md#usermechangepassword) | **PUT** /users/me/change-password | 
[**userMeUpdate**](UserApi.md#usermeupdate) | **PUT** /users/me | 


# **contactSubmit**
> ContactSubmit201Response contactSubmit(insertContact)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getUserApi();
final InsertContact insertContact = ; // InsertContact | 

try {
    final response = api.contactSubmit(insertContact);
    print(response);
} catch on DioException (e) {
    print('Exception when calling UserApi->contactSubmit: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **insertContact** | [**InsertContact**](InsertContact.md)|  | 

### Return type

[**ContactSubmit201Response**](ContactSubmit201Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **userMeChangePassword**
> AuthHasPermission200Response userMeChangePassword(updateUserPassword)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getUserApi();
final UpdateUserPassword updateUserPassword = ; // UpdateUserPassword | 

try {
    final response = api.userMeChangePassword(updateUserPassword);
    print(response);
} catch on DioException (e) {
    print('Exception when calling UserApi->userMeChangePassword: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **updateUserPassword** | [**UpdateUserPassword**](UpdateUserPassword.md)|  | 

### Return type

[**AuthHasPermission200Response**](AuthHasPermission200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **userMeUpdate**
> UserAdminCreate200Response userMeUpdate(name, email, photo, phoneCountryCode, phoneNumber)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getUserApi();
final String name = name_example; // String | 
final String email = email_example; // String | 
final MultipartFile photo = BINARY_DATA_HERE; // MultipartFile | 
final String phoneCountryCode = phoneCountryCode_example; // String | 
final int phoneNumber = 56; // int | 

try {
    final response = api.userMeUpdate(name, email, photo, phoneCountryCode, phoneNumber);
    print(response);
} catch on DioException (e) {
    print('Exception when calling UserApi->userMeUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **name** | **String**|  | [optional] 
 **email** | **String**|  | [optional] 
 **photo** | **MultipartFile**|  | [optional] 
 **phoneCountryCode** | **String**|  | [optional] 
 **phoneNumber** | **int**|  | [optional] 

### Return type

[**UserAdminCreate200Response**](UserAdminCreate200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

