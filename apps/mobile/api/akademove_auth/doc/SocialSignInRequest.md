# akademove_auth.model.SocialSignInRequest

## Load the model package
```dart
import 'package:akademove_auth/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**provider** | **String** |  | 
**callbackURL** | **String** | Callback URL to redirect to after the user has signed in | [optional] 
**newUserCallbackURL** | **String** |  | [optional] 
**errorCallbackURL** | **String** | Callback URL to redirect to if an error happens | [optional] 
**disableRedirect** | **bool** | Disable automatic redirection to the provider. Useful for handling the redirection yourself | [optional] 
**idToken** | [**SocialSignInRequestIdToken**](SocialSignInRequestIdToken.md) |  | [optional] 
**scopes** | [**BuiltList&lt;JsonObject&gt;**](JsonObject.md) | Array of scopes to request from the provider. This will override the default scopes passed. | [optional] 
**requestSignUp** | **bool** | Explicitly request sign-up. Useful when disableImplicitSignUp is true for this provider | [optional] 
**loginHint** | **String** | The login hint to use for the authorization code request | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


