# api_client.api.AuthApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *http://localhost:3000/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**authForgotPassword**](AuthApi.md#authforgotpassword) | **POST** /auth/forgot-password | 
[**authGetSession**](AuthApi.md#authgetsession) | **GET** /auth/session | 
[**authHasPermission**](AuthApi.md#authhaspermission) | **POST** /auth/has-permission | 
[**authResetPassword**](AuthApi.md#authresetpassword) | **POST** /auth/reset-password | 
[**authSignIn**](AuthApi.md#authsignin) | **POST** /auth/sign-in | 
[**authSignOut**](AuthApi.md#authsignout) | **POST** /auth/sign-out | 
[**authSignUpDriver**](AuthApi.md#authsignupdriver) | **POST** /auth/sign-up/driver | 
[**authSignUpMerchant**](AuthApi.md#authsignupmerchant) | **POST** /auth/sign-up/merchant | 
[**authSignUpUser**](AuthApi.md#authsignupuser) | **POST** /auth/sign-up/user | 


# **authForgotPassword**
> AuthSignOut200Response authForgotPassword(authForgotPasswordRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAuthApi();
final AuthForgotPasswordRequest authForgotPasswordRequest = ; // AuthForgotPasswordRequest | 

try {
    final response = api.authForgotPassword(authForgotPasswordRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AuthApi->authForgotPassword: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **authForgotPasswordRequest** | [**AuthForgotPasswordRequest**](AuthForgotPasswordRequest.md)|  | 

### Return type

[**AuthSignOut200Response**](AuthSignOut200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **authGetSession**
> AuthGetSession200Response authGetSession()



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAuthApi();

try {
    final response = api.authGetSession();
    print(response);
} catch on DioException (e) {
    print('Exception when calling AuthApi->authGetSession: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**AuthGetSession200Response**](AuthGetSession200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **authHasPermission**
> AuthHasPermission200Response authHasPermission(authHasPermissionRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAuthApi();
final AuthHasPermissionRequest authHasPermissionRequest = ; // AuthHasPermissionRequest | 

try {
    final response = api.authHasPermission(authHasPermissionRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AuthApi->authHasPermission: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **authHasPermissionRequest** | [**AuthHasPermissionRequest**](AuthHasPermissionRequest.md)|  | 

### Return type

[**AuthHasPermission200Response**](AuthHasPermission200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **authResetPassword**
> AuthSignOut200Response authResetPassword(authResetPasswordRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAuthApi();
final AuthResetPasswordRequest authResetPasswordRequest = ; // AuthResetPasswordRequest | 

try {
    final response = api.authResetPassword(authResetPasswordRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AuthApi->authResetPassword: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **authResetPasswordRequest** | [**AuthResetPasswordRequest**](AuthResetPasswordRequest.md)|  | 

### Return type

[**AuthSignOut200Response**](AuthSignOut200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **authSignIn**
> AuthSignIn200Response authSignIn(authSignInRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAuthApi();
final AuthSignInRequest authSignInRequest = ; // AuthSignInRequest | 

try {
    final response = api.authSignIn(authSignInRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AuthApi->authSignIn: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **authSignInRequest** | [**AuthSignInRequest**](AuthSignInRequest.md)|  | 

### Return type

[**AuthSignIn200Response**](AuthSignIn200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **authSignOut**
> AuthSignOut200Response authSignOut()



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAuthApi();

try {
    final response = api.authSignOut();
    print(response);
} catch on DioException (e) {
    print('Exception when calling AuthApi->authSignOut: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**AuthSignOut200Response**](AuthSignOut200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **authSignUpDriver**
> AuthSignUpUser201Response authSignUpDriver(name, email, gender, phone, password, confirmPassword, photo, detailStudentId, detailLicensePlate, detailStudentCard, detailDriverLicense, detailVehicleCertificate, detailBankProvider, detailBankNumber)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAuthApi();
final String name = name_example; // String | 
final String email = email_example; // String | 
final String gender = gender_example; // String | 
final String phone = phone_example; // String | 
final String password = password_example; // String | 
final String confirmPassword = confirmPassword_example; // String | 
final MultipartFile photo = BINARY_DATA_HERE; // MultipartFile | 
final String detailStudentId = detailStudentId_example; // String | 
final String detailLicensePlate = detailLicensePlate_example; // String | 
final MultipartFile detailStudentCard = BINARY_DATA_HERE; // MultipartFile | 
final MultipartFile detailDriverLicense = BINARY_DATA_HERE; // MultipartFile | 
final MultipartFile detailVehicleCertificate = BINARY_DATA_HERE; // MultipartFile | 
final String detailBankProvider = detailBankProvider_example; // String | 
final num detailBankNumber = 8.14; // num | 

try {
    final response = api.authSignUpDriver(name, email, gender, phone, password, confirmPassword, photo, detailStudentId, detailLicensePlate, detailStudentCard, detailDriverLicense, detailVehicleCertificate, detailBankProvider, detailBankNumber);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AuthApi->authSignUpDriver: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **name** | **String**|  | 
 **email** | **String**|  | 
 **gender** | **String**|  | 
 **phone** | **String**|  | 
 **password** | **String**|  | 
 **confirmPassword** | **String**|  | 
 **photo** | **MultipartFile**|  | 
 **detailStudentId** | **String**|  | 
 **detailLicensePlate** | **String**|  | 
 **detailStudentCard** | **MultipartFile**|  | 
 **detailDriverLicense** | **MultipartFile**|  | 
 **detailVehicleCertificate** | **MultipartFile**|  | 
 **detailBankProvider** | **String**|  | 
 **detailBankNumber** | **num**|  | 

### Return type

[**AuthSignUpUser201Response**](AuthSignUpUser201Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **authSignUpMerchant**
> AuthSignUpUser201Response authSignUpMerchant(name, email, gender, phone, password, confirmPassword, detailType, detailName, detailEmail, detailPhone, detailAddress, detailLocationLat, detailLocationLng, detailBankProvider, detailBankNumber, photo, detailDocument)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAuthApi();
final String name = name_example; // String | 
final String email = email_example; // String | 
final String gender = gender_example; // String | 
final String phone = phone_example; // String | 
final String password = password_example; // String | 
final String confirmPassword = confirmPassword_example; // String | 
final String detailType = detailType_example; // String | 
final String detailName = detailName_example; // String | 
final String detailEmail = detailEmail_example; // String | 
final String detailPhone = detailPhone_example; // String | 
final String detailAddress = detailAddress_example; // String | 
final num detailLocationLat = 8.14; // num | 
final num detailLocationLng = 8.14; // num | 
final String detailBankProvider = detailBankProvider_example; // String | 
final num detailBankNumber = 8.14; // num | 
final MultipartFile photo = BINARY_DATA_HERE; // MultipartFile | 
final MultipartFile detailDocument = BINARY_DATA_HERE; // MultipartFile | 

try {
    final response = api.authSignUpMerchant(name, email, gender, phone, password, confirmPassword, detailType, detailName, detailEmail, detailPhone, detailAddress, detailLocationLat, detailLocationLng, detailBankProvider, detailBankNumber, photo, detailDocument);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AuthApi->authSignUpMerchant: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **name** | **String**|  | 
 **email** | **String**|  | 
 **gender** | **String**|  | 
 **phone** | **String**|  | 
 **password** | **String**|  | 
 **confirmPassword** | **String**|  | 
 **detailType** | **String**|  | 
 **detailName** | **String**|  | 
 **detailEmail** | **String**|  | 
 **detailPhone** | **String**|  | 
 **detailAddress** | **String**|  | 
 **detailLocationLat** | **num**|  | 
 **detailLocationLng** | **num**|  | 
 **detailBankProvider** | **String**|  | 
 **detailBankNumber** | **num**|  | 
 **photo** | **MultipartFile**|  | [optional] 
 **detailDocument** | **MultipartFile**|  | [optional] 

### Return type

[**AuthSignUpUser201Response**](AuthSignUpUser201Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **authSignUpUser**
> AuthSignUpUser201Response authSignUpUser(name, email, gender, phone, password, confirmPassword, photo)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAuthApi();
final String name = name_example; // String | 
final String email = email_example; // String | 
final String gender = gender_example; // String | 
final String phone = phone_example; // String | 
final String password = password_example; // String | 
final String confirmPassword = confirmPassword_example; // String | 
final MultipartFile photo = BINARY_DATA_HERE; // MultipartFile | 

try {
    final response = api.authSignUpUser(name, email, gender, phone, password, confirmPassword, photo);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AuthApi->authSignUpUser: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **name** | **String**|  | 
 **email** | **String**|  | 
 **gender** | **String**|  | 
 **phone** | **String**|  | 
 **password** | **String**|  | 
 **confirmPassword** | **String**|  | 
 **photo** | **MultipartFile**|  | [optional] 

### Return type

[**AuthSignUpUser201Response**](AuthSignUpUser201Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

