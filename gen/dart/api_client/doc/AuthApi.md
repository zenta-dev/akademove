# api_client.api.AuthApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *http://localhost:3000/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**authExchangeToken**](AuthApi.md#authexchangetoken) | **GET** /auth/exchange-token | 
[**authForgotPassword**](AuthApi.md#authforgotpassword) | **POST** /auth/forgot-password | 
[**authGetSession**](AuthApi.md#authgetsession) | **GET** /auth/session | 
[**authHasPermission**](AuthApi.md#authhaspermission) | **POST** /auth/has-permission | 
[**authResetPassword**](AuthApi.md#authresetpassword) | **POST** /auth/reset-password | 
[**authSignIn**](AuthApi.md#authsignin) | **POST** /auth/sign-in | 
[**authSignOut**](AuthApi.md#authsignout) | **POST** /auth/sign-out | 
[**authSignUpDriver**](AuthApi.md#authsignupdriver) | **POST** /auth/sign-up/driver | 
[**authSignUpMerchant**](AuthApi.md#authsignupmerchant) | **POST** /auth/sign-up/merchant | 
[**authSignUpUser**](AuthApi.md#authsignupuser) | **POST** /auth/sign-up/user | 


# **authExchangeToken**
> AuthExchangeToken200Response authExchangeToken()



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAuthApi();

try {
    final response = api.authExchangeToken();
    print(response);
} catch on DioException (e) {
    print('Exception when calling AuthApi->authExchangeToken: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**AuthExchangeToken200Response**](AuthExchangeToken200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

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
> AuthSignOut200Response authResetPassword(resetPassword)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAuthApi();
final ResetPassword resetPassword = ; // ResetPassword | 

try {
    final response = api.authResetPassword(resetPassword);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AuthApi->authResetPassword: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **resetPassword** | [**ResetPassword**](ResetPassword.md)|  | 

### Return type

[**AuthSignOut200Response**](AuthSignOut200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **authSignIn**
> AuthSignIn200Response authSignIn(signInRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAuthApi();
final SignInRequest signInRequest = ; // SignInRequest | 

try {
    final response = api.authSignIn(signInRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AuthApi->authSignIn: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **signInRequest** | [**SignInRequest**](SignInRequest.md)|  | 

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
> AuthSignUpUser201Response authSignUpDriver(name, email, phoneCountryCode, phoneNumber, password, confirmPassword, photo, detailStudentId, detailLicensePlate, detailStudentCard, detailDriverLicense, detailVehicleCertificate, detailBankProvider, detailBankNumber, gender)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAuthApi();
final String name = name_example; // String | 
final String email = email_example; // String | 
final String phoneCountryCode = phoneCountryCode_example; // String | 
final int phoneNumber = 56; // int | 
final String password = password_example; // String | 
final String confirmPassword = confirmPassword_example; // String | 
final MultipartFile photo = BINARY_DATA_HERE; // MultipartFile | 
final num detailStudentId = 8.14; // num | 
final String detailLicensePlate = detailLicensePlate_example; // String | 
final MultipartFile detailStudentCard = BINARY_DATA_HERE; // MultipartFile | 
final MultipartFile detailDriverLicense = BINARY_DATA_HERE; // MultipartFile | 
final MultipartFile detailVehicleCertificate = BINARY_DATA_HERE; // MultipartFile | 
final String detailBankProvider = detailBankProvider_example; // String | 
final num detailBankNumber = 8.14; // num | 
final String gender = gender_example; // String | 

try {
    final response = api.authSignUpDriver(name, email, phoneCountryCode, phoneNumber, password, confirmPassword, photo, detailStudentId, detailLicensePlate, detailStudentCard, detailDriverLicense, detailVehicleCertificate, detailBankProvider, detailBankNumber, gender);
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
 **phoneCountryCode** | **String**|  | 
 **phoneNumber** | **int**|  | 
 **password** | **String**|  | 
 **confirmPassword** | **String**|  | 
 **photo** | **MultipartFile**|  | 
 **detailStudentId** | **num**|  | 
 **detailLicensePlate** | **String**|  | 
 **detailStudentCard** | **MultipartFile**|  | 
 **detailDriverLicense** | **MultipartFile**|  | 
 **detailVehicleCertificate** | **MultipartFile**|  | 
 **detailBankProvider** | **String**|  | 
 **detailBankNumber** | **num**|  | 
 **gender** | **String**|  | [optional] 

### Return type

[**AuthSignUpUser201Response**](AuthSignUpUser201Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **authSignUpMerchant**
> AuthSignUpUser201Response authSignUpMerchant(name, email, phoneCountryCode, phoneNumber, password, confirmPassword, detailName, detailEmail, detailPhoneCountryCode, detailPhoneNumber, detailAddress, detailLocationX, detailLocationY, detailBankProvider, detailBankNumber, photo, gender, detailDocument, detailImage)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAuthApi();
final String name = name_example; // String | 
final String email = email_example; // String | 
final String phoneCountryCode = phoneCountryCode_example; // String | 
final int phoneNumber = 56; // int | 
final String password = password_example; // String | 
final String confirmPassword = confirmPassword_example; // String | 
final String detailName = detailName_example; // String | 
final String detailEmail = detailEmail_example; // String | 
final String detailPhoneCountryCode = detailPhoneCountryCode_example; // String | 
final int detailPhoneNumber = 56; // int | 
final String detailAddress = detailAddress_example; // String | 
final num detailLocationX = 8.14; // num | Longitude (X-axis, East-West)
final num detailLocationY = 8.14; // num | Latitude (Y-axis, North-South)
final String detailBankProvider = detailBankProvider_example; // String | 
final num detailBankNumber = 8.14; // num | 
final MultipartFile photo = BINARY_DATA_HERE; // MultipartFile | 
final String gender = gender_example; // String | 
final MultipartFile detailDocument = BINARY_DATA_HERE; // MultipartFile | 
final MultipartFile detailImage = BINARY_DATA_HERE; // MultipartFile | 

try {
    final response = api.authSignUpMerchant(name, email, phoneCountryCode, phoneNumber, password, confirmPassword, detailName, detailEmail, detailPhoneCountryCode, detailPhoneNumber, detailAddress, detailLocationX, detailLocationY, detailBankProvider, detailBankNumber, photo, gender, detailDocument, detailImage);
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
 **phoneCountryCode** | **String**|  | 
 **phoneNumber** | **int**|  | 
 **password** | **String**|  | 
 **confirmPassword** | **String**|  | 
 **detailName** | **String**|  | 
 **detailEmail** | **String**|  | 
 **detailPhoneCountryCode** | **String**|  | 
 **detailPhoneNumber** | **int**|  | 
 **detailAddress** | **String**|  | 
 **detailLocationX** | **num**| Longitude (X-axis, East-West) | 
 **detailLocationY** | **num**| Latitude (Y-axis, North-South) | 
 **detailBankProvider** | **String**|  | 
 **detailBankNumber** | **num**|  | 
 **photo** | **MultipartFile**|  | [optional] 
 **gender** | **String**|  | [optional] 
 **detailDocument** | **MultipartFile**|  | [optional] 
 **detailImage** | **MultipartFile**|  | [optional] 

### Return type

[**AuthSignUpUser201Response**](AuthSignUpUser201Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **authSignUpUser**
> AuthSignUpUser201Response authSignUpUser(name, email, phoneCountryCode, phoneNumber, password, confirmPassword, photo, gender)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAuthApi();
final String name = name_example; // String | 
final String email = email_example; // String | 
final String phoneCountryCode = phoneCountryCode_example; // String | 
final int phoneNumber = 56; // int | 
final String password = password_example; // String | 
final String confirmPassword = confirmPassword_example; // String | 
final MultipartFile photo = BINARY_DATA_HERE; // MultipartFile | 
final String gender = gender_example; // String | 

try {
    final response = api.authSignUpUser(name, email, phoneCountryCode, phoneNumber, password, confirmPassword, photo, gender);
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
 **phoneCountryCode** | **String**|  | 
 **phoneNumber** | **int**|  | 
 **password** | **String**|  | 
 **confirmPassword** | **String**|  | 
 **photo** | **MultipartFile**|  | [optional] 
 **gender** | **String**|  | [optional] 

### Return type

[**AuthSignUpUser201Response**](AuthSignUpUser201Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

