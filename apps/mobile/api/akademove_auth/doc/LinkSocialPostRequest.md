# akademove_auth.model.LinkSocialPostRequest

## Load the model package
```dart
import 'package:akademove_auth/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**provider** | **String** |  | 
**callbackURL** | **String** | The URL to redirect to after the user has signed in | [optional] 
**idToken** | [**LinkSocialPostRequestIdToken**](LinkSocialPostRequestIdToken.md) |  | [optional] 
**requestSignUp** | **bool** |  | [optional] 
**scopes** | [**BuiltList&lt;JsonObject&gt;**](JsonObject.md) | Additional scopes to request from the provider | [optional] 
**errorCallbackURL** | **String** | The URL to redirect to if there is an error during the link process | [optional] 
**disableRedirect** | **bool** | Disable automatic redirection to the provider. Useful for handling the redirection yourself | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


