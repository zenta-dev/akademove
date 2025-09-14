# auth_client.api.DefaultApi

## Load the API package
```dart
import 'package:auth_client/api.dart';
```

All URIs are relative to *https://akademove-server.zenta.dev/auth*

Method | HTTP request | Description
------------- | ------------- | -------------
[**accountInfoPost**](DefaultApi.md#accountinfopost) | **POST** /account-info | 
[**changeEmailPost**](DefaultApi.md#changeemailpost) | **POST** /change-email | 
[**changePasswordPost**](DefaultApi.md#changepasswordpost) | **POST** /change-password | 
[**deleteUserCallbackGet**](DefaultApi.md#deleteusercallbackget) | **GET** /delete-user/callback | 
[**deleteUserPost**](DefaultApi.md#deleteuserpost) | **POST** /delete-user | 
[**errorGet**](DefaultApi.md#errorget) | **GET** /error | 
[**forgetPasswordPost**](DefaultApi.md#forgetpasswordpost) | **POST** /forget-password | 
[**getAccessTokenPost**](DefaultApi.md#getaccesstokenpost) | **POST** /get-access-token | 
[**getSessionGet**](DefaultApi.md#getsessionget) | **GET** /get-session | 
[**linkSocialPost**](DefaultApi.md#linksocialpost) | **POST** /link-social | 
[**listAccountsGet**](DefaultApi.md#listaccountsget) | **GET** /list-accounts | 
[**listSessionsGet**](DefaultApi.md#listsessionsget) | **GET** /list-sessions | 
[**okGet**](DefaultApi.md#okget) | **GET** /ok | 
[**refreshTokenPost**](DefaultApi.md#refreshtokenpost) | **POST** /refresh-token | 
[**requestPasswordResetPost**](DefaultApi.md#requestpasswordresetpost) | **POST** /request-password-reset | 
[**resetPasswordPost**](DefaultApi.md#resetpasswordpost) | **POST** /reset-password | 
[**resetPasswordTokenGet**](DefaultApi.md#resetpasswordtokenget) | **GET** /reset-password/{token} | 
[**revokeOtherSessionsPost**](DefaultApi.md#revokeothersessionspost) | **POST** /revoke-other-sessions | 
[**revokeSessionPost**](DefaultApi.md#revokesessionpost) | **POST** /revoke-session | 
[**revokeSessionsPost**](DefaultApi.md#revokesessionspost) | **POST** /revoke-sessions | 
[**sendVerificationEmailPost**](DefaultApi.md#sendverificationemailpost) | **POST** /send-verification-email | 
[**signInEmailPost**](DefaultApi.md#signinemailpost) | **POST** /sign-in/email | 
[**signOutPost**](DefaultApi.md#signoutpost) | **POST** /sign-out | 
[**signUpEmailPost**](DefaultApi.md#signupemailpost) | **POST** /sign-up/email | 
[**socialSignIn**](DefaultApi.md#socialsignin) | **POST** /sign-in/social | 
[**unlinkAccountPost**](DefaultApi.md#unlinkaccountpost) | **POST** /unlink-account | 
[**updateUserPost**](DefaultApi.md#updateuserpost) | **POST** /update-user | 
[**verifyEmailGet**](DefaultApi.md#verifyemailget) | **GET** /verify-email | 


# **accountInfoPost**
> AccountInfoPost200Response accountInfoPost(accountInfoPostRequest)



Get the account info provided by the provider

### Example
```dart
import 'package:auth_client/api.dart';

final api = AuthClient().getDefaultApi();
final AccountInfoPostRequest accountInfoPostRequest = ; // AccountInfoPostRequest | 

try {
    final response = api.accountInfoPost(accountInfoPostRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->accountInfoPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **accountInfoPostRequest** | [**AccountInfoPostRequest**](AccountInfoPostRequest.md)|  | 

### Return type

[**AccountInfoPost200Response**](AccountInfoPost200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **changeEmailPost**
> ChangeEmailPost200Response changeEmailPost(changeEmailPostRequest)



### Example
```dart
import 'package:auth_client/api.dart';

final api = AuthClient().getDefaultApi();
final ChangeEmailPostRequest changeEmailPostRequest = ; // ChangeEmailPostRequest | 

try {
    final response = api.changeEmailPost(changeEmailPostRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->changeEmailPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **changeEmailPostRequest** | [**ChangeEmailPostRequest**](ChangeEmailPostRequest.md)|  | 

### Return type

[**ChangeEmailPost200Response**](ChangeEmailPost200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **changePasswordPost**
> ChangePasswordPost200Response changePasswordPost(changePasswordPostRequest)



Change the password of the user

### Example
```dart
import 'package:auth_client/api.dart';

final api = AuthClient().getDefaultApi();
final ChangePasswordPostRequest changePasswordPostRequest = ; // ChangePasswordPostRequest | 

try {
    final response = api.changePasswordPost(changePasswordPostRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->changePasswordPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **changePasswordPostRequest** | [**ChangePasswordPostRequest**](ChangePasswordPostRequest.md)|  | 

### Return type

[**ChangePasswordPost200Response**](ChangePasswordPost200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteUserCallbackGet**
> DeleteUserCallbackGet200Response deleteUserCallbackGet(token, callbackURL)



Callback to complete user deletion with verification token

### Example
```dart
import 'package:auth_client/api.dart';

final api = AuthClient().getDefaultApi();
final String token = token_example; // String | 
final String callbackURL = callbackURL_example; // String | 

try {
    final response = api.deleteUserCallbackGet(token, callbackURL);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->deleteUserCallbackGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **token** | **String**|  | [optional] 
 **callbackURL** | **String**|  | [optional] 

### Return type

[**DeleteUserCallbackGet200Response**](DeleteUserCallbackGet200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteUserPost**
> DeleteUserPost200Response deleteUserPost(deleteUserPostRequest)



Delete the user

### Example
```dart
import 'package:auth_client/api.dart';

final api = AuthClient().getDefaultApi();
final DeleteUserPostRequest deleteUserPostRequest = ; // DeleteUserPostRequest | 

try {
    final response = api.deleteUserPost(deleteUserPostRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->deleteUserPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **deleteUserPostRequest** | [**DeleteUserPostRequest**](DeleteUserPostRequest.md)|  | 

### Return type

[**DeleteUserPost200Response**](DeleteUserPost200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **errorGet**
> String errorGet()



Displays an error page

### Example
```dart
import 'package:auth_client/api.dart';

final api = AuthClient().getDefaultApi();

try {
    final response = api.errorGet();
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->errorGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

**String**

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/html, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **forgetPasswordPost**
> ForgetPasswordPost200Response forgetPasswordPost(forgetPasswordPostRequest)



Send a password reset email to the user

### Example
```dart
import 'package:auth_client/api.dart';

final api = AuthClient().getDefaultApi();
final ForgetPasswordPostRequest forgetPasswordPostRequest = ; // ForgetPasswordPostRequest | 

try {
    final response = api.forgetPasswordPost(forgetPasswordPostRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->forgetPasswordPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **forgetPasswordPostRequest** | [**ForgetPasswordPostRequest**](ForgetPasswordPostRequest.md)|  | 

### Return type

[**ForgetPasswordPost200Response**](ForgetPasswordPost200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getAccessTokenPost**
> RefreshTokenPost200Response getAccessTokenPost(refreshTokenPostRequest)



Get a valid access token, doing a refresh if needed

### Example
```dart
import 'package:auth_client/api.dart';

final api = AuthClient().getDefaultApi();
final RefreshTokenPostRequest refreshTokenPostRequest = ; // RefreshTokenPostRequest | 

try {
    final response = api.getAccessTokenPost(refreshTokenPostRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getAccessTokenPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **refreshTokenPostRequest** | [**RefreshTokenPostRequest**](RefreshTokenPostRequest.md)|  | 

### Return type

[**RefreshTokenPost200Response**](RefreshTokenPost200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getSessionGet**
> GetSessionGet200Response getSessionGet()



Get the current session

### Example
```dart
import 'package:auth_client/api.dart';

final api = AuthClient().getDefaultApi();

try {
    final response = api.getSessionGet();
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getSessionGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**GetSessionGet200Response**](GetSessionGet200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **linkSocialPost**
> LinkSocialPost200Response linkSocialPost(linkSocialPostRequest)



Link a social account to the user

### Example
```dart
import 'package:auth_client/api.dart';

final api = AuthClient().getDefaultApi();
final LinkSocialPostRequest linkSocialPostRequest = ; // LinkSocialPostRequest | 

try {
    final response = api.linkSocialPost(linkSocialPostRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->linkSocialPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **linkSocialPostRequest** | [**LinkSocialPostRequest**](LinkSocialPostRequest.md)|  | 

### Return type

[**LinkSocialPost200Response**](LinkSocialPost200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listAccountsGet**
> BuiltList<ListAccountsGet200ResponseInner> listAccountsGet()



List all accounts linked to the user

### Example
```dart
import 'package:auth_client/api.dart';

final api = AuthClient().getDefaultApi();

try {
    final response = api.listAccountsGet();
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->listAccountsGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;ListAccountsGet200ResponseInner&gt;**](ListAccountsGet200ResponseInner.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listSessionsGet**
> BuiltList<Session> listSessionsGet()



List all active sessions for the user

### Example
```dart
import 'package:auth_client/api.dart';

final api = AuthClient().getDefaultApi();

try {
    final response = api.listSessionsGet();
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->listSessionsGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;Session&gt;**](Session.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **okGet**
> OkGet200Response okGet()



Check if the API is working

### Example
```dart
import 'package:auth_client/api.dart';

final api = AuthClient().getDefaultApi();

try {
    final response = api.okGet();
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->okGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**OkGet200Response**](OkGet200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **refreshTokenPost**
> RefreshTokenPost200Response refreshTokenPost(refreshTokenPostRequest)



Refresh the access token using a refresh token

### Example
```dart
import 'package:auth_client/api.dart';

final api = AuthClient().getDefaultApi();
final RefreshTokenPostRequest refreshTokenPostRequest = ; // RefreshTokenPostRequest | 

try {
    final response = api.refreshTokenPost(refreshTokenPostRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->refreshTokenPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **refreshTokenPostRequest** | [**RefreshTokenPostRequest**](RefreshTokenPostRequest.md)|  | 

### Return type

[**RefreshTokenPost200Response**](RefreshTokenPost200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **requestPasswordResetPost**
> ForgetPasswordPost200Response requestPasswordResetPost(forgetPasswordPostRequest)



Send a password reset email to the user

### Example
```dart
import 'package:auth_client/api.dart';

final api = AuthClient().getDefaultApi();
final ForgetPasswordPostRequest forgetPasswordPostRequest = ; // ForgetPasswordPostRequest | 

try {
    final response = api.requestPasswordResetPost(forgetPasswordPostRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->requestPasswordResetPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **forgetPasswordPostRequest** | [**ForgetPasswordPostRequest**](ForgetPasswordPostRequest.md)|  | 

### Return type

[**ForgetPasswordPost200Response**](ForgetPasswordPost200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **resetPasswordPost**
> ResetPasswordPost200Response resetPasswordPost(resetPasswordPostRequest)



Reset the password for a user

### Example
```dart
import 'package:auth_client/api.dart';

final api = AuthClient().getDefaultApi();
final ResetPasswordPostRequest resetPasswordPostRequest = ; // ResetPasswordPostRequest | 

try {
    final response = api.resetPasswordPost(resetPasswordPostRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->resetPasswordPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **resetPasswordPostRequest** | [**ResetPasswordPostRequest**](ResetPasswordPostRequest.md)|  | 

### Return type

[**ResetPasswordPost200Response**](ResetPasswordPost200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **resetPasswordTokenGet**
> ResetPasswordTokenGet200Response resetPasswordTokenGet(token, callbackURL)



Redirects the user to the callback URL with the token

### Example
```dart
import 'package:auth_client/api.dart';

final api = AuthClient().getDefaultApi();
final String token = token_example; // String | Password reset token
final String callbackURL = callbackURL_example; // String | 

try {
    final response = api.resetPasswordTokenGet(token, callbackURL);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->resetPasswordTokenGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **token** | **String**| Password reset token | 
 **callbackURL** | **String**|  | [optional] 

### Return type

[**ResetPasswordTokenGet200Response**](ResetPasswordTokenGet200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **revokeOtherSessionsPost**
> RevokeOtherSessionsPost200Response revokeOtherSessionsPost(body)



Revoke all other sessions for the user except the current one

### Example
```dart
import 'package:auth_client/api.dart';

final api = AuthClient().getDefaultApi();
final JsonObject body = Object; // JsonObject | 

try {
    final response = api.revokeOtherSessionsPost(body);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->revokeOtherSessionsPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | **JsonObject**|  | [optional] 

### Return type

[**RevokeOtherSessionsPost200Response**](RevokeOtherSessionsPost200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **revokeSessionPost**
> RevokeSessionPost200Response revokeSessionPost(revokeSessionPostRequest)



Revoke a single session

### Example
```dart
import 'package:auth_client/api.dart';

final api = AuthClient().getDefaultApi();
final RevokeSessionPostRequest revokeSessionPostRequest = ; // RevokeSessionPostRequest | 

try {
    final response = api.revokeSessionPost(revokeSessionPostRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->revokeSessionPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **revokeSessionPostRequest** | [**RevokeSessionPostRequest**](RevokeSessionPostRequest.md)|  | [optional] 

### Return type

[**RevokeSessionPost200Response**](RevokeSessionPost200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **revokeSessionsPost**
> RevokeSessionsPost200Response revokeSessionsPost(body)



Revoke all sessions for the user

### Example
```dart
import 'package:auth_client/api.dart';

final api = AuthClient().getDefaultApi();
final JsonObject body = Object; // JsonObject | 

try {
    final response = api.revokeSessionsPost(body);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->revokeSessionsPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | **JsonObject**|  | [optional] 

### Return type

[**RevokeSessionsPost200Response**](RevokeSessionsPost200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **sendVerificationEmailPost**
> SendVerificationEmailPost200Response sendVerificationEmailPost(sendVerificationEmailPostRequest)



Send a verification email to the user

### Example
```dart
import 'package:auth_client/api.dart';

final api = AuthClient().getDefaultApi();
final SendVerificationEmailPostRequest sendVerificationEmailPostRequest = ; // SendVerificationEmailPostRequest | 

try {
    final response = api.sendVerificationEmailPost(sendVerificationEmailPostRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->sendVerificationEmailPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **sendVerificationEmailPostRequest** | [**SendVerificationEmailPostRequest**](SendVerificationEmailPostRequest.md)|  | [optional] 

### Return type

[**SendVerificationEmailPost200Response**](SendVerificationEmailPost200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **signInEmailPost**
> SignInEmailPost200Response signInEmailPost(signInEmailPostRequest)



Sign in with email and password

### Example
```dart
import 'package:auth_client/api.dart';

final api = AuthClient().getDefaultApi();
final SignInEmailPostRequest signInEmailPostRequest = ; // SignInEmailPostRequest | 

try {
    final response = api.signInEmailPost(signInEmailPostRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->signInEmailPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **signInEmailPostRequest** | [**SignInEmailPostRequest**](SignInEmailPostRequest.md)|  | 

### Return type

[**SignInEmailPost200Response**](SignInEmailPost200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **signOutPost**
> SignOutPost200Response signOutPost(body)



Sign out the current user

### Example
```dart
import 'package:auth_client/api.dart';

final api = AuthClient().getDefaultApi();
final JsonObject body = Object; // JsonObject | 

try {
    final response = api.signOutPost(body);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->signOutPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | **JsonObject**|  | [optional] 

### Return type

[**SignOutPost200Response**](SignOutPost200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **signUpEmailPost**
> SignUpEmailPost200Response signUpEmailPost(signUpEmailPostRequest)



Sign up a user using email and password

### Example
```dart
import 'package:auth_client/api.dart';

final api = AuthClient().getDefaultApi();
final SignUpEmailPostRequest signUpEmailPostRequest = ; // SignUpEmailPostRequest | 

try {
    final response = api.signUpEmailPost(signUpEmailPostRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->signUpEmailPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **signUpEmailPostRequest** | [**SignUpEmailPostRequest**](SignUpEmailPostRequest.md)|  | [optional] 

### Return type

[**SignUpEmailPost200Response**](SignUpEmailPost200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **socialSignIn**
> SocialSignIn200Response socialSignIn(socialSignInRequest)



Sign in with a social provider

### Example
```dart
import 'package:auth_client/api.dart';

final api = AuthClient().getDefaultApi();
final SocialSignInRequest socialSignInRequest = ; // SocialSignInRequest | 

try {
    final response = api.socialSignIn(socialSignInRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->socialSignIn: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **socialSignInRequest** | [**SocialSignInRequest**](SocialSignInRequest.md)|  | 

### Return type

[**SocialSignIn200Response**](SocialSignIn200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **unlinkAccountPost**
> ResetPasswordPost200Response unlinkAccountPost(unlinkAccountPostRequest)



Unlink an account

### Example
```dart
import 'package:auth_client/api.dart';

final api = AuthClient().getDefaultApi();
final UnlinkAccountPostRequest unlinkAccountPostRequest = ; // UnlinkAccountPostRequest | 

try {
    final response = api.unlinkAccountPost(unlinkAccountPostRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->unlinkAccountPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **unlinkAccountPostRequest** | [**UnlinkAccountPostRequest**](UnlinkAccountPostRequest.md)|  | 

### Return type

[**ResetPasswordPost200Response**](ResetPasswordPost200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateUserPost**
> UpdateUserPost200Response updateUserPost(updateUserPostRequest)



Update the current user

### Example
```dart
import 'package:auth_client/api.dart';

final api = AuthClient().getDefaultApi();
final UpdateUserPostRequest updateUserPostRequest = ; // UpdateUserPostRequest | 

try {
    final response = api.updateUserPost(updateUserPostRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->updateUserPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **updateUserPostRequest** | [**UpdateUserPostRequest**](UpdateUserPostRequest.md)|  | [optional] 

### Return type

[**UpdateUserPost200Response**](UpdateUserPost200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **verifyEmailGet**
> VerifyEmailGet200Response verifyEmailGet(token, callbackURL)



Verify the email of the user

### Example
```dart
import 'package:auth_client/api.dart';

final api = AuthClient().getDefaultApi();
final String token = token_example; // String | The token to verify the email
final String callbackURL = callbackURL_example; // String | The URL to redirect to after email verification

try {
    final response = api.verifyEmailGet(token, callbackURL);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->verifyEmailGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **token** | **String**| The token to verify the email | 
 **callbackURL** | **String**| The URL to redirect to after email verification | [optional] 

### Return type

[**VerifyEmailGet200Response**](VerifyEmailGet200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

