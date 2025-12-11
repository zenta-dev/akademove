# api_client.api.UserApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *http://10.86.19.105:3000/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**accountDeletionSubmit**](UserApi.md#accountdeletionsubmit) | **POST** /account-deletion/submit | 
[**contactSubmit**](UserApi.md#contactsubmit) | **POST** /contacts/submit | 
[**userLookupByPhone**](UserApi.md#userlookupbyphone) | **GET** /users/lookup/phone | 
[**userMeChangePassword**](UserApi.md#usermechangepassword) | **PUT** /users/me/change-password | 
[**userMeUpdate**](UserApi.md#usermeupdate) | **PUT** /users/me | 


# **accountDeletionSubmit**
> AccountDeletionSubmit201Response accountDeletionSubmit(insertAccountDeletion)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getUserApi();
final InsertAccountDeletion insertAccountDeletion = ; // InsertAccountDeletion | 

try {
    final response = api.accountDeletionSubmit(insertAccountDeletion);
    print(response);
} catch on DioException (e) {
    print('Exception when calling UserApi->accountDeletionSubmit: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **insertAccountDeletion** | [**InsertAccountDeletion**](InsertAccountDeletion.md)|  | 

### Return type

[**AccountDeletionSubmit201Response**](AccountDeletionSubmit201Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

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

# **userLookupByPhone**
> UserLookupByPhone200Response userLookupByPhone(phone)



Lookup user by phone number for wallet transfer. Returns minimal user info with masked phone number for privacy.

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getUserApi();
final String phone = phone_example; // String | 

try {
    final response = api.userLookupByPhone(phone);
    print(response);
} catch on DioException (e) {
    print('Exception when calling UserApi->userLookupByPhone: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **phone** | **String**|  | 

### Return type

[**UserLookupByPhone200Response**](UserLookupByPhone200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **userMeChangePassword**
> AuthSignOut200Response userMeChangePassword(userMeChangePasswordRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getUserApi();
final UserMeChangePasswordRequest userMeChangePasswordRequest = ; // UserMeChangePasswordRequest | 

try {
    final response = api.userMeChangePassword(userMeChangePasswordRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling UserApi->userMeChangePassword: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userMeChangePasswordRequest** | [**UserMeChangePasswordRequest**](UserMeChangePasswordRequest.md)|  | 

### Return type

[**AuthSignOut200Response**](AuthSignOut200Response.md)

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

